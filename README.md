# TTR-i3
**A more Advanced version of the [simple i3](https://github.com/TheTechRun/Simple-i3) setup that I made. This is the version that I personally use with some slight alterations for better portability. This comes with our custom Rofi and Theme Switcher. Best to install from a terminal only environment for a mostly bloat free experience.**

***Tested and working on Debian 12 Bookworm but should be good to go on many other distros with some slight alterations*** 

### <ins>App Dependencies<ins>: 
alacritty, arandr, chromium, curl, dmenu, dunst, git, gnome-text-editor, greenclip, i3, libnotify-bin, libreoffice, light-locker, lightdm, nemo, network-manager-gnome, nitrogen, picom, polybar, powerline, rofi, slick-greeter, starship, xautolock, xorg

**Note**: *You can go to ~/.config/polybar/modules and alter the App scripts as you like.*

### <ins>TTR-i3 Install:<ins>
The **install.sh** script that will install just the config files, fonts, icons, and themes. 
The **app-install.sh** will install the *Apps* (mentioned in the sections above) on debian based systems using apt. You will need to run this script as sudo. 
Be sure to Backup any configs and/or files that these might replace.

The easiest method is to install is to run these commands in terminal: 
```
sudo apt update
sudo apt install git wget
cd ~  
wget https://raw.githubusercontent.com/thetechrun/ttr-i3/master/install.sh
chmod +x install.sh 
bash install.sh
sudo bash ~/.scripts/app-install.sh
```
Be sure to pay attention to the prompts and reboot.

 *Alter the app-install.sh script to work with your distro's package manager (dnf, pacman, etc) as you like.*

## <ins>Some Keybinds (See i3 config):<ins>
**$mod = Super Key**

**Control+Shift+t** = TTR i3 Theme Switcher

**Alt+Space** = TTR-Rofi

**Alt+z** = App Chooser

**Super+Tab** = Show/Switch Windows tabs

**Menu** = Terminal Popup (Scratchpad)

**Super+w** = Web Browser (Chromium)

**Super+t** = Terminal (Alacritty)

**Super+f** = File Browser (Nemo)

**Super+g** = Text Editor (Gnome Text Editor)

**Super+p** = Polybar

**Super+c** = Clipboard (Greenclip)

**Alt+l** = Lockscreen (light-locker)

**See ~/.config/i3/config for the rest of the keybinds.**

### <ins>TTR i3 Theme Switcher<ins>: 
This comes with 8 built in themes that can be switched on the fly (See Keybinds). The theme switcher changes the main color in i3, rofi, dunst, starship prompt, polybar, wallpaper, and GTK themes & icons.

### <ins>TTR Rofi<ins>: 
Adding read soon...

