sway-wm - My tiling Sway configuration for Debian
================================================================

### Screenshot:

![sway](https://git.q3aql.dev/q3aql/sway-wm/raw/branch/master/examples/sway.png)

### Installation:

  * **`Install dependencies:`**
  
    * Install the packages necessary for sway to function properly:

    ```shell
    $ sudo apt install sway swaylock swaybg swayidle sway-backgrounds lxappearance \
    nwg-look nwg-displays python3 python3-tk python3-psutil zenity pulseaudio-utils \
    pipewire pipewire-pulse slurp foot alacritty kitty mpv wf-recorder wl-clipboard \
    wlr-randr wdisplays ristretto grim arc-theme papirus-icon-theme adwaita-icon-theme \
    adwaita-qt6 adwaita-qt qt5ct qt6ct wofi keepassxc electron-mail clipman pcmanfm \
    geany firefox xarchiver iwd fonts-noto fonts-noto-core fonts-noto-extra fonts-noto-mono \
    xdg-desktop-portal-gtk xdg-desktop-portal xdg-desktop-portal-wlr wmctrl dex  
    ````
 
  * **`Install configuration (dotfiles):`**
  
    * Clone repository and copy files to your home:

      ```shell
      $ git clone https://git.q3aql.dev/q3aql/sway-wm
      $ cd sway-wm
      $ cp -rfv .config ~/
      $ echo "export QT_QPA_PLATFORMTHEME=qt5ct" >> ~/.bashrc 
      $ sudo tar zxvf packages/ubuntumono-nerd-fonts.tar.xz -C /
      $ sudo tar zxvf packages/iwd-connectd.tar.gz -C /
      $ sudo systemctl daemon-reload
      $ sudo systemctl enable iwd-connectd
      $ sudo packages/nwg-wrapper-install.sh
      ````

### Configuration:

  * **`Network:`**
  
    * By default, I use `iwd` as my network manager via the `iwd-connectd` script:
    * To modify the configuration, you must edit the file `/usr/bin/iwd-connectd-cfg` with root:
    
      ```shell
      interface="wlan0"
      wireless="yes" # Change to "no" for ethernet
      wireless_ssid="miwifiname"
      wireless_pass="passwordwifi"
      ip_interface="192.168.0.100/24"
      gw_interface="192.168.0.1"
      dns_one="1.1.1.1"
      dns_two="1.1.0.0"
      ````

    * After modifying the configuration, restart the service:

      ```shell
      $ sudo systemctl restart iwd-connectd
      ````

  * **`Monitor & resolution:`**
  
    * The configuration load my monitor configuration:
    * Use the command `wlr-randr` or `wdisplays` for show your config & edit the file `~/.config/sway/startwlrrandr.sh`:
    
      ```shell
      wlr-randr --output DP-1 --custom-mode 1280x1024@75Hz --pos 288,0
      wlr-randr --output DP-2 --custom-mode 1280x1024@75Hz --transform 90 --pos 1568,0
      ````

  * **`Screensaver:`**
  
    * The configuration file set the time in 20 minutes:
    * Edit the file `~/.config/sway/startwlrscreensaver.sh`:
    
      ```shell
      # Basic configuration variables
      ScreensaverTime="1200" # 20 minutes
      ````

 * **`Wallpaper:`**
  
    * By default, the config load wallpaper on `~/wallpapers/awesome.jpg`:
    * Edit  `~/.config/sway/config` for set your favorite wallpaper:
    
      ```shell
      exec --no-startup-id "swaybg -i ~/wallpapers/awesome.jpg -m fill"
      ````

 * **`Tray:`**
  
    * By default, the config set tray on monitor `HDMI-A-1`:
    * Edit  `~/.config/sway/config` for set your output monitor:
    
      ```shell
      tray_output HDMI-A-1
      ````

  * **`Layout:`**
  
    * By default, the config load my spanish layout.:
    * Edit  `~/.config/sway/config` for set your configuration:
    
      ```shell
      # Input layout
      input * {
        #xkb_layout "us"
        xkb_layout "es"
        #xkb_variant "colemak"
      }
      ````

### Keys configuration:

My list of extra combinations:

    - Super + d = Open Wofi (fbrun mode)
    - Super + p = Open Wofi (run mode)
    - Super + q = Open Wofi (window mode)
    - Super + o = Open Wofi (drun mode)
    - Super + b = Open Firefox
    - Super + n = Open PCManFM
    - Super + t = Open Wayland-Screenshooter
    - Super + g = Open Geany
    - Super + m = Open Telegram 
    - Super + z = Open Wf-Recorder (Screen video recorder) 
    - Super + x = Open Wdisplays
    - Super + u = Open Xterm
    - Super + i = Open LXAppearance
    - Super + c = Open NetWorkManager or Clipboard
    - Super + Shift + c = Caffeine Mode
    - Super + Shift + x = Display Tools
    - Volume-Up = Volume +5
    - Volume-Down = Volume -5
    - VolumeMute = Mute Volume
    - Super + Ctrl + Shift + l = Poweroff/Start screen (Screensaver step needed)
    - Super + Shift + e = Logout
    - Super + Backspace = Open menu Logout/Reboot/Shutdown
