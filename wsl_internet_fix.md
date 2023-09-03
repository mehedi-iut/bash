# WSL internet fix

1. In Windows search --> Turn Windows feature on or off
2. check Hyper-V, Windows Hypervisor Platform
3. Restart 
4. Search Hyper-V Manager, open in administrator mode
5. Select "WSL"
6. Click "External network", then Apply--> Ok
7. run "wsl --shutdown"
8. Create ".wslconfig" file in "C:\Users\<User name>\" with following content
[wsl2]
networkingMode=bridged
vmSwitch=WSL
9. Open Ubuntu and run "sudo apt update" and it will work
