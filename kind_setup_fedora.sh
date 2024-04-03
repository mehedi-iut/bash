#!/bin/bash

set -e

sudo dnf update -y
sudo dnf install jq -y

# install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# install helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

# For AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/`curl -s https://api.github.com/repos/kubernetes-sigs/kind/releases/latest | jq .name -r`/kind-linux-amd64
chmod +x ./kind
sudo cp ./kind /usr/local/bin/kind
rm -rf kind


cat <<EOF | kind create cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
- role: worker
- role: worker
EOF


kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/`curl -s https://api.github.com/repos/metallb/metallb/releases/latest | jq .tag_name -r`/config/manifests/metallb-native.yaml

wait_for_metallb_pods() {
    echo "Waiting for all pods in the metallb-system namespace to be ready..."
    while true; do
        all_ready=true
        for pod in $(kubectl get pods -n metallb-system -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}'); do
            if [[ "$(kubectl get pod $pod -n metallb-system -o jsonpath='{.status.phase}')" != "Running" ]]; then
                all_ready=false
                break
            fi
        done

        if [ "$all_ready" = true ]; then
            echo "All pods in the metallb-system namespace are ready."
            break
        else
            echo "Not all pods in the metallb-system namespace are ready. Retrying in 5 seconds..."
            sleep 5
        fi
    done
}

# Call the function to wait for all pods in the metallb-system namespace
wait_for_metallb_pods


network_bit=$(docker network inspect -f '{{.IPAM.Config}}' kind | awk -F'[{ }]' '/\/[0-9]+/ { print $2; exit }' | cut -d'/' -f1 | cut -d'.' -f1-2)

kubectl apply -f - <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - ${network_bit}.255.200-${network_bit}.255.250
EOF

kubectl apply -f - <<EOF
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: default
  namespace: metallb-system
spec:
  addresses:
  - ${network_bit}.255.200-${network_bit}.255.250
  autoAssign: true
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: default
  namespace: metallb-system
spec:
  ipAddressPools:
  - default
EOF


helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace
