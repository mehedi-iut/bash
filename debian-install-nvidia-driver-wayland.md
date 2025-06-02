# How to Install the "Open" Proprietary NVIDIA Driver (and use Wayland) on Debian 13:

If your primary goal is Wayland with performance on your RTX 3050, this is the path to take.

Add `contrib` and `non-free` / `non-free-firmware` repositories:
Edit `/etc/apt/sources.list` and ensure it includes these components. For Debian 13 (Trixie), it should look something like this:
```
deb http://deb.debian.org/debian trixie main contrib non-free non-free-firmware
deb http://deb.debian.org/debian trixie-updates main contrib non-free non-free-firmware
deb http://deb.debian.org/debian-security trixie-security main contrib non-free non-free-firmware
```

Save and exit.

Update your package lists:

```sh
sudo apt update
```

Install necessary headers and build tools:

```sh
sudo apt install linux-headers-$(uname -r) build-essential dkms
```

Install the NVIDIA proprietary driver (including the open kernel modules):
First, use nvidia-detect to find the recommended driver version:

```sh
sudo apt install nvidia-detect
nvidia-detect
```

It will suggest a package name (e.g., nvidia-driver). Then install it:

```sh
sudo apt install nvidia-driver firmware-misc-nonfree
```


The firmware-misc-nonfree package is crucial for many modern hardware components, including some NVIDIA GPU functionalities.

### Configure Wayland (if not automatic):
For GNOME, Wayland should be the default when a capable driver is detected. If it falls back to X11, you might need to ensure nvidia-drm.modeset=1 is enabled.

Edit `/etc/default/grub`:
```sh
sudo nano /etc/default/grub
```

Find the line `GRUB_CMDLINE_LINUX_DEFAULT=` and add `nvidia-drm.modeset=1` inside the quotes. It might look something like: `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nvidia-drm.modeset=1"`
Save the file and update grub:
```sh
sudo update-grub
```

You might also need to ensure GDM (GNOME's Display Manager) is configured to prefer Wayland, although with recent drivers, it usually detects it:

```sh
sudo nano /etc/gdm3/daemon.conf
```
Uncomment `WaylandEnable=false` if it's there, or ensure `WaylandEnable=true` is set. Sometimes, removing any Wayland disabling lines is enough.


### install envycontrol and gpu profile select
clone `https://github.com/bayasdev/envycontrol` and install it
```sh
git clone https://github.com/bayasdev/envycontrol
cd envycontrol
pipx install .
```

now, install gnome extension `GPU Profile Selector`

Reboot:

```sh
sudo reboot
```
