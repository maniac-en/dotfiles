# Dotfiles & stuff

## Preview
![Preview](https://i.imgur.com/kBJRydh.jpg)
> Font in this preview is [Comic Code Medium](https://www.myfonts.com/fonts/tabular-type-foundry/comic-code/medium/), if you have it, you can use the corresponding config from `dev` branch!

## Index
- [Clean Installation Steps](#clean-installation-steps)
- [Things to note](#things-to-note)
- [Contributing](#contributing)
- [Code of conduct](#code-of-conduct)
- [LICENSE](#license)

## Clean Installation Steps
- You need to have a arch base-install (or, you can experiment on your existing system if you wanna get adventurous),
- If you're new/confused, you should refer [arch wiki](https://wiki.archlinux.org/title/installation_guide)
- Steps you need to do before running my script: (layman's steps, need not be exact but expected working should be same)
        - Boot into a bootable image for an arch ISO which can be download from [here](https://archlinux.org/download/)
        - Perform disk partition using fdisk or cfdisk or whatever you're comfortable with
        - Create a file system by formatting the disks you made above
        - Connect to internet: wifi/ethernet/mobile tethering, anything that gets you started
        - Choose best mirror for downloading packages (not always required)
        - mount and pacstrap your arch install with following command
        ```sh
        pacstrap /mnt base linux linux-firmware sudo networkmanager git
        ```
        - arch-chroot to your installation and enable network manager service with following command
        > *(CASE SENSITIVE COMMAND)*
        ```sh
        systemctl enable NetworkManager.service
        ```
        - setup a root password using the command `passwd` (you won't be able login later unless you set this)
        - generate fstab entries, setup date-time, setup hosts and hostname
        - Install a bootloader, for grub installation: refer [this](https://wiki.archlinux.org/title/GRUB)
- After you boot back to your install as root user, you need to execute these steps for a clean install:
        > *assume **USER** for demonstration, replace it with whatever you want*
        - Adding a new user and giving it an access to run all sudo commands without password
        > Makes our clean install script process run without waiting for passwords from user
        ```sh
        useradd -m USER
        echo "USER ALL=(ALL) NOPASSWD: ALL" | sudo EDITOR='tee -a' visudo
        ```
        - set new password for newly create `USER` using the command `passwd USER`
        - switch user from to `root` to `USER` using `su - USER`
        - Clone and run the script using the command given below:
        ```sh
        git clone --recursive https://github.com/maniac-en/dotfiles.git ~/.dotfiles \
                && cd ~/.dotfiles && ./clean_install.sh
        ```

## Things to note
- Amongst the all [scripts](https://github.com/maniac-en/dotfiles/tree/main/dotfiles/scripts), I use API for two of them, and they can be put in user's home folder `/home/USER` with a file name `.env.api` [(Sample File)](https://github.com/maniac-en/dotfiles/blob/main/.env.api)
        - Github API (scope: notification access) for getting unread notification counter in polybar (bar present at the top in the screenshots)
        > Github API docs: [here](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token)
        - Imgur API for uploading screenshots to imgur for easy sharing!
        > Imgur API docs: [here](https://api.imgur.com/#overview)

### [Contributing](https://github.com/maniac-en/dotfiles/blob/main/docs/CONTRIBUTING.md)
### [Code of conduct](https://github.com/maniac-en/dotfiles/blob/main/CODE_OF_CONDUCT.md)
### [LICENSE](https://github.com/maniac-en/dotfiles/blob/main/LICENSE)
