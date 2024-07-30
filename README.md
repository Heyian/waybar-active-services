# waybar-active-services

Screenshot: ![Screenshot](screenshot.png)

This project was made mainly to monitor if a backup is running on my system. It will show a *red* update icon on the [Waybar](https://github.com/Alexays/Waybar/) with the number of services (backups) that are running. The infotip will show the active services and it will open a list of all the watched services with their status if clicked.

## Requirements

- [Waybar](https://github.com/Alexays/Waybar)
- [Nerd Fonts](https://www.nerdfonts.com/)

## Installation

- Put the shell script inside a folder that waybar can reach. I personally use `~/.config/waybar/scripts/`
- Make the script executable. `sudo chmod +x {path_to_script}`
- Edit the file and change the services to your own.

**Note**: I use foot as my terminal emulator, if you use something else, change it on the `"on-click": "foot -e bash -c ...` line of the module configuration.

## Waybar Configuration

Add `"custom/active-services"` to your modules at the top of the config file. Either `modules-left`, `modules-center` or `modules-right`

### Module configuration

```
    "custom/active-services": {
        "exec": "~/.config/waybar/scripts/check_active_services.sh",
        "return-type": "json",
        "interval": 15,
        "on-click": "foot -e bash -c '~/.config/waybar/scripts/check_active_services.sh --details; read -p \"Press Enter to close...\"'",
        "format": "{}",
    "tooltip":true,
    },
```

**Note**: Since I'm using this as a running backups monitor, I chose the icon that fits. If you want something else. Simply choose another icon from [Nerd Fonts](https://www.nerdfonts.com/) on the line 55 of the script.
