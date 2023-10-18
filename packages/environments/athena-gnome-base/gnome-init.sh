#!/bin/sh

detect_virt=$(systemd-detect-virt)

if ([ ! -z "$DISPLAY" ] && [ "$DISPLAY" != ":0" ]) || ([ "$detect_virt" != "docker" ] && [ "$detect_virt" != "podman" ] && [ "$detect_virt" != "wsl" ]); then

     FLAGFILE="$HOME/.flag-gnome-once"
     #FLAGNET="$HOME/.flag-gnome-net-once"

     DCONF_CK="/usr/share/athena-gnome-config/dconf-custom-keybindings.ini"
     DCONF_DS="/usr/share/athena-gnome-config/dconf-desktop.ini"
     DCONF_MT="/usr/share/athena-gnome-config/dconf-mutter.ini"
     DCONF_SH="/usr/share/athena-gnome-config/dconf-shell.ini"

     if [ -f "$FLAGFILE" ]; then

         ############################################################

         xdg-mime default org.gnome.Nautilus.desktop inode/directory
         
         ############################################################
     
         cat $DCONF_CK | dconf load /org/gnome/settings-daemon/plugins/media-keys/
         cat $DCONF_DS | dconf load /org/gnome/desktop/
         cat $DCONF_MT | dconf load /org/gnome/mutter/
         cat $DCONF_SH | dconf load /org/gnome/shell/

         ############################################################

         sh ~/.vim_runtime/install_awesome_parameterized.sh ~/.vim_runtime $USER

         package=athena-akame-theme
         if pacman -Qq $package > /dev/null ; then
              theme-switcher AkameGaKill
         fi

        package=athena-cyborg-theme
        if pacman -Qq $package > /dev/null ; then
            theme-switcher Cyborg
        fi

         package=athena-everblush-theme
         if pacman -Qq $package > /dev/null ; then
              theme-switcher Everblush
         fi

         package=athena-graphite-theme
         if pacman -Qq $package > /dev/null ; then
              theme-switcher Graphite
         fi
         
         package=athena-htb-theme
         if pacman -Qq $package > /dev/null ; then
              theme-switcher HackTheBox
         fi

         package=athena-samurai-theme
         if pacman -Qq $package > /dev/null ; then
              theme-switcher SamuraiGirl
         fi

         package=athena-sweetdark-theme
         if pacman -Qq $package > /dev/null ; then
              theme-switcher SweetDark
         fi

         package=athena-xxe-theme
         if pacman -Qq $package > /dev/null ; then
              theme-switcher XXE
         fi

         package=athena-parrotctfs-theme
         if pacman -Qq $package > /dev/null ; then
              athena-parrotctfs-theme
         fi

         rm -rf "$FLAGFILE"

         systemctl --user enable --now psd
         ln -s "$HOME/.mozilla/firefox-esr" "$HOME/.mozilla/firefox"
     fi

     #if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
     #    if [ -f "$FLAGNET" ]; then
     #    # Commented for keeping nist-feed disable. The user decides if enable it.
     #    #	/usr/local/bin/nist-feed -n -l
     #    	rm -rf "$FLAGNET"
     #    fi
     #    /usr/local/bin/htb-update
     #fi

     #If tun0 is down (i.e., after a reboot), the shell prompt must be updated with the running interfaces
     #if ! nmcli c show --active | grep -q tun ; then

     #   /usr/local/bin/prompt-reset

     #fi

     gsettings set org.gnome.shell disable-user-extensions false
fi