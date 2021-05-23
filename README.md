# Dotfiles & stuff

## LICENSE
[GPL-3.0 License](https://github.com/maniac-en/dotfiles/blob/main/LICENSE)

## Things to note
- THESE DOTFILES MIGHT BREAK YOUR EXISTING SYSTEM OR MIGHT NOT EVEN WORK FOR YOU. THESE ARE MEANT FOR MY PERSONAL USAGE, AND MY ACQUAINTANCES.
- I use [`Comic Code Medium`](https://www.myfonts.com/fonts/tabular-type-foundry/comic-code/medium/) font but you can change it using `update_font.sh`. Just run:
```sh
./update_font.sh
```
- I use an [IMGUR API](https://api.imgur.com/#overview) for the screenshot script. It can be put in user's home folder `/home/USER` with a file name `.env.api` [(Sample File)](https://github.com/maniac-en/dotfiles/blob/gruvbox/.env.api)

## Clean Installation Steps
- You need to have a arch base-install (or, you can experiment on your existing system if you wanna get adventurous),
- If you're new/confused, you should refer [arch wiki](https://wiki.archlinux.org/title/installation_guide)
> Steps given below are in layman's terms, they don't have to be followed exactly!
- Steps you gotta perform before running the clean install script:
1. Boot into a bootable image for an arch ISO which can be download from [here](https://archlinux.org/download/)
2. Perform disk partition using `fdisk` or `cfdisk` or whatever you're comfortable with
3. Create a file system by formatting the disks you made above
4. Connect to internet: wifi/ethernet/mobile tethering, anything that gets you started, `ping 8.8.8.8`
5. Mount your filesystem root to `/mnt` and also `swappon /dev...` if you made a SWAP partition
6. pacstrap your arch install with following command
```sh
pacstrap /mnt base linux linux-firmware sudo networkmanager git
```
7. generate fstab entries using the following command:
```sh
genfstab -U /mnt >> /mnt/etc/fstab
```
8. arch-chroot to your installation and enable network manager service with following command
```sh
systemctl enable NetworkManager.service
```
9. setup a root password using the command `passwd` (you won't be able login later unless you set this)
10. Setup date-time, setup hosts and hostname
11. Install a bootloader, for e.x grub, rEFInd, etc.
12. Boot back to your newly installed OS
13. Follow [this](https://howto.lintel.in/install-nvidia-arch-linux/) or the [arhived version](http://web.archive.org/web/20210119174352/https://howto.lintel.in/install-nvidia-arch-linux/) for installing and setting up nvidia drivers
14. Making a non-root user with `NOPASSD sudo access` so as to proceed with the installation:
	> *assume **USER** for demonstration, replace it with whatever you want*
	- Adding a new user and giving it an access to run all sudo commands without password
	- set `USER` password
	- switch to `USER`
	```sh
	useradd -m USER
	echo "USER ALL=(ALL) NOPASSWD: ALL" | sudo EDITOR='tee -a' visudo
	passwd USER
	su - USER
	```
15. Clone and run the script using following command:
```sh
git clone --recursive --depth 1 https://github.com/maniac-en/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && ./clean_install.sh
```

Happy computing :)
