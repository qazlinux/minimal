#!/bin/bash

apt install sudo nala git wget

sudo nala install -y acpi acpitool acpi-support rename fancontrol firmware-linux-free fwupd hardinfo hwdata hwinfo irqbalance iucode-tool laptop-detect lm-sensors lshw lsscsi smartmontools software-properties-gtk util-linux

sudo nala install -y firmware-linux firmware-misc-nonfree

sudo nala install -y dconf-editor curl aria2

sudo nala install -y xorg xserver-xorg ffmpegthumbnailer gstreamer1.0-gl gstreamer1.0-nice gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-pulseaudio gstreamer1.0-x

sudo nala install -y libdvdnav4 libdvdread8 libfaac0 libmad0 libmp3lame0 libxvidcore4 vorbis-tools flac

sudo nala install -y gcc g++ gfortran clang rustc valac fpc gnat ocaml-nox crystal linux-headers-$(uname -r) build-essential make cmake meson libgcr-3-dev ninja-build cargo autoconf automake libtool scons gradle default-jdk default-jre

sudo nala install -y papirus-icon-theme arc-theme dmz-cursor-theme adwaita-qt

sudo nala install -y arj bzip2 gzip lhasa liblhasa0 lzip lzma p7zip p7zip-full p7zip-rar sharutils rar unace unrar unrar-free tar unzip xz-utils zip

sudo clear

# Function for managing repositories
manage_repositories() {
    # ANSI color codes
    YELLOW='\033[1;33m'
    NC='\033[0m' # No Color

    while true; do
        echo "Select an option:"
        echo "1) Add Backports repository"
        echo "2) Add Multimedia repository"
        echo "3) Add Backports and Multimedia repositories"
        echo "4) Return to main menu"
        read -p "Option [1-4]: " repo_option

        if [[ "$repo_option" =~ ^[1-4]$ ]]; then
            case $repo_option in
                1) # Add Backports repository
                    echo "Adding Backports repository..."
                    echo "# BACKPORTS" | sudo tee -a /etc/apt/sources.list
                    echo "deb http://deb.debian.org/debian bookworm-backports main contrib non-free-firmware" | sudo tee -a /etc/apt/sources.list
                    echo "deb-src http://deb.debian.org/debian bookworm-backports main contrib non-free-firmware" | sudo tee -a /etc/apt/sources.list
                    echo "Backports repository added."
                    sudo nala update
                    sudo nala upgrade -y
                    sudo clear
                    ;;
                2) # Add Multimedia repository
                    echo "Adding Multimedia repository..."
                    wget -O /tmp/deb-multimedia-keyring.deb https://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.8.1_all.deb
                    sudo dpkg -i /tmp/deb-multimedia-keyring.deb
                    sudo rm -f /tmp/deb-multimedia-keyring.deb
                    echo "# MULTIMEDIA" | sudo tee -a /etc/apt/sources.list
                    echo "deb https://www.deb-multimedia.org bookworm main non-free" | sudo tee -a /etc/apt/sources.list
                    echo "deb https://www.deb-multimedia.org bookworm-backports main" | sudo tee -a /etc/apt/sources.list
                    echo "Multimedia repository added."
                    sudo nala update
                    sudo nala upgrade -y
                    sudo clear
                    ;;
                3) # Add both Backports and Multimedia repositories
                    echo "Adding both Backports and Multimedia repositories..."
                    echo "# BACKPORTS" | sudo tee -a /etc/apt/sources.list
                    echo "deb http://deb.debian.org/debian bookworm-backports main contrib non-free-firmware" | sudo tee -a /etc/apt/sources.list
                    echo "deb-src http://deb.debian.org/debian bookworm-backports main contrib non-free-firmware" | sudo tee -a /etc/apt/sources.list
                    echo " " | sudo tee -a /etc/apt/sources.list
                    wget -O /tmp/deb-multimedia-keyring.deb https://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.8.1_all.deb
                    sudo dpkg -i /tmp/deb-multimedia-keyring.deb
                    sudo rm -f /tmp/deb-multimedia-keyring.deb
                    echo "# MULTIMEDIA" | sudo tee -a /etc/apt/sources.list
                    echo "deb https://www.deb-multimedia.org bookworm main non-free" | sudo tee -a /etc/apt/sources.list
                    echo "deb https://www.deb-multimedia.org bookworm-backports main" | sudo tee -a /etc/apt/sources.list
                    echo "Backports and Multimedia repositories added."
                    sudo nala update
                    sudo nala upgrade -y
                    sudo clear
                    ;;
                4) # Return to main menu
                    echo "Returning to the main menu."
                    sudo clear
                    return
                    ;;
                *) # Invalid option
                    echo "Invalid option: $repo_option"
                    ;;
            esac
        else
            echo "Invalid option. Please enter a number between 1 and 4."
        fi
    done
}

# Function for installing minimal desktop environments and applications
install_minimal_desktop_envs() {
    # ANSI color codes
    YELLOW='\033[1;33m'
    NC='\033[0m' # No Color

    while true; do
        echo "Select an option:"
        echo "1) Install minimal GNOME environment"
        echo "2) Install minimal Budgie environment"
        echo "3) Install minimal XFCE environment"
        echo "4) Exit"
        read -p "Option [1-4]: " main_option

        if [[ "$main_option" =~ ^[1-4]$ ]]; then
            case $main_option in
                1) # GNOME
                    echo "Installing minimal GNOME environment..."
                    nala install -y gnome-core gedit eog tilix nautilus mpv synaptic || { echo "Error installing GNOME environment"; exit 1; }
                    gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Dark'
                    gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
                    gsettings set org.gnome.shell.extensions.user-theme name 'Arc-Dark'
                    echo "Installing LibreWolf..."
                    sudo apt update && sudo apt install extrepo -y
                    sudo extrepo enable librewolf
                    sudo apt update && sudo apt install librewolf -y || { echo "Error installing LibreWolf"; exit 1; }
                    echo "GNOME installation completed."
                    ;;
                2) # Budgie
                    echo "Installing minimal Budgie environment..."
                    nala install -y budgie-desktop budgie* tilix slick-greeter mousepad eog mpv thunar thunar-archive-plugin thunar-volman synaptic|| { echo "Error installing Budgie environment"; exit 1; }
                    gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Dark'
                    gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
                    echo "Installing LibreWolf..."
                    sudo apt update && sudo apt install extrepo -y
                    sudo extrepo enable librewolf
                    sudo apt update && sudo apt install librewolf -y || { echo "Error installing LibreWolf"; exit 1; }
                    echo "Budgie installation completed."
                    ;;
                3) # XFCE
                    echo "Installing minimal XFCE environment..."
                    nala install -y xfce4 tilix slick-greeter mousepad ristretto mpv thunar thunar-archive-plugin thunar-volman synaptic|| { echo "Error installing XFCE environment"; exit 1; }
                    xfconf-query -c xsettings -p /Net/ThemeName -s "Arc-Dark"
                    xfconf-query -c xsettings -p /Net/IconThemeName -s "Papirus-Dark"
                    xfconf-query -c xfwm4 -p /general/theme -s "Arc-Dark"
                    echo "Installing LibreWolf..."
                    sudo apt update && sudo apt install extrepo -y
                    sudo extrepo enable librewolf
                    sudo apt update && sudo apt install librewolf -y || { echo "Error installing LibreWolf"; exit 1; }
                    echo "XFCE installation completed."
                    ;;
                4) # Exit
                    echo "Exiting the installation menu."
                    sudo clear
                    return
                    ;;
                *) # Invalid option
                    echo "Invalid option: $main_option"
                    ;;
            esac
        else
            echo "Invalid option. Please enter a number between 1 and 4."
        fi
    done
}

# Enable error handling
set -e

# Log file
LOGFILE="/var/log/firmware_update.log"

# Function to log messages
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOGFILE"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to update the system and handle package issues
update_system() {
    log "Updating the package list..."
    if ! sudo nala update; then
        log "Failed to update package list. Attempting to fix broken packages..."
        sudo nala install -f || log "Failed to fix broken packages."
    fi

    log "Upgrading installed packages..."
    if ! sudo nala upgrade; then
        log "Failed to upgrade packages. Attempting to fix broken packages..."
        sudo nala install -f || log "Failed to fix broken packages."
    fi

    log "Cleaning up unused packages..."
    sudo nala autoremove -y || true  # Ignore errors and continue
}

# Function to update and manage firmware
update_firmware() {
    log "Starting firmware update process..."

    # Update the system first
    update_system

    # Install fwupd if it's not already installed
    if ! command_exists fwupdmgr; then
        log "fwupd is not installed. Installing fwupd..."
        sudo nala install fwupd -y
    fi

    # Refresh the fwupd database
    log "Refreshing the fwupd database..."
    sudo fwupdmgr refresh || true  # Ignore errors and continue

    # List available firmware updates
    log "Checking for available firmware updates..."
    available_firmware=$(sudo fwupdmgr get-updates || true)  # Ignore errors and continue

    if [[ -z "$available_firmware" ]]; then
        log "No available firmware updates found."
    else
        log "Available firmware updates:"
        echo "$available_firmware"

        # Install firmware updates without prompting
        log "Installing firmware updates..."
        sudo fwupdmgr update || log "Failed to install firmware updates."
    fi

    # Install common additional firmware
    log "Installing common additional firmware..."
    sudo nala install firmware-linux firmware-linux-nonfree -y || log "Failed to install additional firmware."
    sudo clear
    
    # Clean the package cache
    log "Cleaning the package cache..."
    sudo nala clean || true  # Ignore errors and continue
    sudo clear
    
    log "Firmware search and installation process completed."
    sudo clear
}

# Function to display usage information
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -h, --help        Show this help message"
    echo "  -l, --log         Specify a log file (default: /var/log/firmware_update.log)"
}

# Parse command-line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--help) usage; exit 0 ;;
        -l|--log) LOGFILE="$2"; shift ;;
        *) echo "Unknown option: $1"; usage; exit 1 ;;
    esac
    shift
done

# Ensure the terminal is cleared before exiting
sudo clear

# Function to check if an application is installed
is_installed() {
    dpkg -l | grep -q "$1"
}

# Function to display the application status
get_app_status() {
    if is_installed "$1"; then
        echo "✅"  # For installed
    else
        echo "❌"  # For not installed
    fi
}

# Function to detect the CPU
detect_cpu() {
    echo "Detecting CPU..."
    if CPU_INFO=$(cat /proc/cpuinfo | grep "model name" | uniq); then
        echo "Detected CPU: $CPU_INFO"
    else
        echo "Failed to detect CPU."
        exit 1
    fi
}

# Function to detect the GPU
detect_gpu() {
    echo "Detecting GPU..."
    if command -v lspci &> /dev/null; then
        GPU_INFO=$(lspci | grep -E "VGA|3D")
        echo "Detected GPU: $GPU_INFO"
    else
        echo "lspci is not installed. Please install it to detect the GPU."
        exit 1
    fi
}

# Function to manage installations and uninstalls
manage_installations() {
    detect_cpu
    detect_gpu

    while true; do
        echo "Your CPU is: $CPU_INFO"
        echo "Your GPU is: $GPU_INFO"
        echo "Recommended installations based on your hardware:"

        if echo "$GPU_INFO" | grep -i "nvidia" &> /dev/null; then
            echo "1. Install NVIDIA drivers $(get_app_status nvidia-driver)"
            echo "2. Install open-source NVIDIA driver (nouveau) $(get_app_status xserver-xorg-video-nouveau)"
            echo "3. Install NVIDIA monitoring tools (nvidia-smi) $(get_app_status nvidia-smi)"
        elif echo "$GPU_INFO" | grep -i "amd" &> /dev/null; then
            echo "1. Install AMD drivers (firmware-amd-graphics) $(get_app_status firmware-amd-graphics)"
            echo "2. Install CoreCtrl (for monitoring and control) $(get_app_status corectrl)"
            echo "3. Install Radeontop (for monitoring) $(get_app_status radeontop)"
        else
            echo "No supported GPU detected."
            exit 1
        fi

        echo "4. Exit"

        read -p "Select an option (1-4): " option

        case $option in
            1)
                if echo "$GPU_INFO" | grep -i "nvidia" &> /dev/null; then
                    read -p "Do you want to install the proprietary NVIDIA driver (1) or the open-source driver (2)? " driver_option
                    if [[ "$driver_option" == "1" ]]; then
                        echo "Installing NVIDIA drivers..."
                        if sudo nala install -y nvidia-driver; then
                            echo "NVIDIA drivers installed successfully."
                        else
                            echo "Failed to install NVIDIA drivers."
                        fi
                    elif [[ "$driver_option" == "2" ]]; then
                        echo "Installing open-source NVIDIA driver..."
                        if sudo nala install -y xserver-xorg-video-nouveau; then
                            echo "Open-source NVIDIA driver installed successfully."
                        else
                            echo "Failed to install open-source NVIDIA driver."
                        fi
                    else
                        echo "Invalid option. Please select 1 or 2."
                    fi
                elif echo "$GPU_INFO" | grep -i "amd" &> /dev/null; then
                    echo "Installing AMD drivers..."
                    if sudo nala install -y firmware-amd-graphics; then
                        echo "AMD drivers installed successfully."
                    else
                        echo "Failed to install AMD drivers."
                    fi
                fi
                ;;
            2)
                if echo "$GPU_INFO" | grep -i "amd" &> /dev/null; then
                    echo "Installing CoreCtrl..."
                    if sudo nala install -y corectrl; then
                        echo "CoreCtrl installed successfully."
                    else
                        echo "Failed to install CoreCtrl."
                    fi
                fi
                ;;
            3)
                if echo "$GPU_INFO" | grep -i "amd" &> /dev/null; then
                    echo "Installing Radeontop..."
                    if sudo nala install -y radeontop; then
                        echo "Radeontop installed successfully."
                    else
                        echo "Failed to install Radeontop."
                    fi
                elif echo "$GPU_INFO" | grep -i "nvidia" &> /dev/null; then
                    echo "Installing NVIDIA monitoring tools..."
                    if sudo nala install -y nvidia-smi; then
                        echo "NVIDIA monitoring tools installed successfully."
                    else
                        echo "Failed to install NVIDIA monitoring tools."
                    fi
                fi
                ;;

            4)
               sudo clear
               return
               ;; 
            *)
                echo "Invalid option. Please try again."
                ;;
        esac

        echo "Installation/Uninstallation complete. Returning to the main menu..."
        echo ""
    done
}


is_installed() {
    app_name="$1"
    
    # Verifica si la aplicación está instalada mediante dpkg-query
    if dpkg-query -W -f='${Package}\n' | grep -q "^$app_name$"; then
        return 0  # La aplicación está instalada
    fi
    
    # Si ninguna verificación tiene éxito, se devuelve 1 (no instalado)
    return 1  # La aplicación no está instalada
}

# Function for browser installation
install_browsers() {
    # ANSI color codes
    YELLOW='\033[38;5;178m'
    NC='\033[0m' # No Color

    while true; do
        echo "Select an option:"
        echo "1) Install browsers"
        echo "2) Uninstall browsers"
        echo "3) Exit"
        read -p "Option [1-3]: " main_option

        if [[ "$main_option" =~ ^[1-3]$ ]]; then
            if [ "$main_option" -eq 1 ]; then
                echo "Select the browsers you want to install (enter the corresponding numbers, separated by spaces):"
                echo -e "1) Brave ${YELLOW} - Privacy-focused browser.${NC} $(get_app_status brave-browser)"
                echo -e "2) Epiphany ${YELLOW} - Simple web browser for GNOME.${NC} $(get_app_status epiphany)"
                echo -e "3) Firefox ${YELLOW} - Popular open-source web browser.${NC} $(get_app_status firefox)"
                echo -e "4) Firefox ESR ${YELLOW} - Extended Support Release of Firefox.${NC} $(get_app_status firefox-esr)"
                echo -e "5) LibreWolf (RECOMMENDED). ${YELLOW} - Privacy-focused fork of Firefox.${NC} $(get_app_status librewolf)"
                echo -e "6) Mullvad ${YELLOW} - Privacy-focused browser from Mullvad VPN.${NC} $(get_app_status mullvad-browser)"
                echo -e "7) Tor Browser ${YELLOW} - Browser for anonymous web browsing.${NC} $(get_app_status torbrowser-launcher)"
                echo "8) None"
                read -p "Option [1-8]: " -a options

                # Install the selected browsers
                for option in "${options[@]}"; do
                    case $option in
                        1) # Brave
                            echo "Adding the Brave repository..."
                            curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
                            echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
                            nala update
                            nala install -y brave-browser || { echo "Error installing Brave"; exit 1; }
                            ;;
                        2) # Epiphany
                            echo "Installing Epiphany..."
                            nala update
                            nala install -y epiphany-browser || { echo "Error installing Epiphany"; exit 1; }
                            ;;
                        3) # Firefox
                            echo "Importing the signing key for the Mozilla repository..."
                            wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
                            echo "Adding the Mozilla repository..."
                            echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee /etc/apt/sources.list.d/mozilla.list > /dev/null
                            nala update
                            nala install -y firefox || { echo "Error installing Firefox"; exit 1; }
                            # List available language packages
                            echo "Fetching available language packages for Firefox..."
                            language_packages=$(apt-cache search firefox-l10n | awk '{print $1}')
                            if [ -z "$language_packages" ]; then
                                echo "No language packages found."
                                echo "No language package will be installed."
                            else
                                echo "Select the language package for Firefox:"
                                select language_option in $language_packages "None"; do
                                    case $language_option in
                                        "None")
                                            echo "No language package will be installed."
                                            break
                                            ;;
                                        *)
                                            echo "Installing the language package: $language_option..."
                                            nala install -y "$language_option" || { echo "Error installing the language package: $language_option"; }
                                            break
                                            ;;
                                    esac
                                done
                            fi
                            ;;
                        4) # Firefox-ESR
                            echo "Installing Firefox-ESR..."
                            nala install -y firefox-esr || { echo "Error installing Firefox-ESR"; exit 1; }
                            # List available language packages
                            echo "Fetching available language packages for Firefox-ESR..."
                            language_packages=$(apt-cache search firefox-l10n | awk '{print $1}')
                            if [ -z "$language_packages" ]; then
                                echo "No language packages found."
                                echo "No language package will be installed."
                            else
                                echo "Select the language package for Firefox-ESR:"
                                select language_option in $language_packages "None"; do
                                    case $language_option in
                                        "None")
                                            echo "No language package will be installed."
                                            break
                                            ;;
                                        *)
                                            echo "Installing the language package: $language_option..."
                                            nala install -y "$language_option" || { echo "Error installing the language package: $language_option"; }
                                            break
                                            ;;
                                    esac
                                done
                            fi
                            ;;
                        5) # LibreWolf
                            echo "Adding the LibreWolf repository..."
                            nala update && nala install extrepo -y || { echo "Error installing extrepo"; exit 1; }
                            sudo extrepo enable librewolf
                            nala update && nala install librewolf -y || { echo "Error installing LibreWolf"; exit 1; }
                            ;;
                        6) # Mullvad
                            # Download the Mullvad signing key
                            sudo curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc
                            # Add the Mullvad repository server to apt
                            echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$(dpkg --print-architecture)] https://repository.mullvad.net/deb/stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/mullvad.list
                            # Install the package
                            sudo nala update
                            sudo nala install -y mullvad-browser || { echo "Error installing Mullvad"; exit 1; }
                            ;;
                        7) # Tor Browser
                            echo "Installing Tor Browser..."
                            nala update
                            nala install -y apt-transport-https || { echo "Error installing apt-transport-https"; exit 1; }
                            echo "Creating the tor.list file..."
                            echo "deb [signed-by=/usr/share/keyrings/deb.torproject.org-keyring.gpg] https://deb.torproject.org/torproject.org bookworm main" | sudo tee /etc/apt/sources.list.d/tor.list
                            echo "deb-src [signed-by=/usr/share/keyrings/deb.torproject.org-keyring.gpg] https://deb.torproject.org/torproject.org bookworm main" | sudo tee -a /etc/apt/sources.list.d/tor.list
                            echo "Adding the GPG key..."
                            wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --dearmor | sudo tee /usr/share/keyrings/deb.torproject.org-keyring.gpg >/dev/null
                            echo "Updating the package list..."
                            nala update
                            echo "Installing tor and deb.torproject.org-keyring..."
                            nala install -y tor deb.torproject.org-keyring || { echo "Error installing Tor"; exit 1; }
                            echo "Installing tor-browser..."
                            nala install -y torbrowser-launcher || { echo "Error installing tor-browser"; exit 1; }
                            ;;
                        8) # None
                            echo "No browser will be installed."
                            sudo clear
                            return
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                echo "Installation completed. Enjoy your browsers!"

            elif [ "$main_option" -eq 2 ]; then
                echo "Select the browsers you want to uninstall (enter the corresponding numbers, separated by spaces):"
                echo -e "1) Brave ${YELLOW} - Privacy-focused browser.${NC} $(get_app_status brave-browser)"
                echo -e "2) Epiphany ${YELLOW} - Simple web browser for GNOME.${NC} $(get_app_status epiphany)"
                echo -e "3) Firefox ${YELLOW} - Popular open-source web browser.${NC} $(get_app_status firefox)"
                echo -e "4) Firefox ESR ${YELLOW} - Extended Support Release of Firefox.${NC} $(get_app_status firefox-esr)"
                echo -e "5) LibreWolf ${YELLOW} - Privacy-focused fork of Firefox.${NC} $(get_app_status librewolf)"
                echo -e "6) Mullvad ${YELLOW} - Privacy-focused browser from Mullvad VPN.${NC} $(get_app_status mullvad-browser)"
                echo -e "7) Tor Browser ${YELLOW} - Browser for anonymous web browsing.${NC} $(get_app_status torbrowser-launcher)"
                echo "8) None"
                read -p "Option [1-9]: " -a uninstall_options

                # Uninstall the selected browsers
                for option in "${uninstall_options[@]}"; do
                    case $option in
                        1) # Brave
                            nala remove --purge -y brave-browser || { echo "Error uninstalling Brave"; }
                            sudo rm -f /etc/apt/sources.list.d/brave-browser-release.list
                            sudo rm -f /usr/share/keyrings/brave-browser-archive-keyring.gpg
                            ;;
                        2) # Epiphany
                            nala remove --purge -y epiphany-browser || {                             echo "Error uninstalling Epiphany"; }
                            ;;
                        3) # Firefox
                            nala remove --purge -y firefox || { echo "Error uninstalling Firefox"; }
                            sudo rm -f /etc/apt/sources.list.d/mozilla.list
                            sudo rm -f /etc/apt/keyrings/packages.mozilla.org.asc
                            ;;
                        4) # Firefox-ESR
                            nala remove --purge -y firefox-esr || { echo "Error uninstalling Firefox-ESR"; }
                            ;;
                        5) # LibreWolf
                            nala remove --purge -y librewolf || { echo "Error uninstalling LibreWolf"; }
                            sudo extrepo disable librewolf
                            ;;
                        6) # Mullvad
                            nala remove --purge -y mullvad-browser || { echo "Error uninstalling Mullvad"; }
                            sudo rm -f /etc/apt/sources.list.d/mullvad.list
                            sudo rm -f /usr/share/keyrings/mullvad-keyring.asc
                            ;;
                        7) # Tor Browser
                            nala remove --purge -y tor torbrowser-launcher || { echo "Error uninstalling Tor Browser"; }
                            sudo rm -f /etc/apt/sources.list.d/tor.list
                            sudo rm -f /usr/share/keyrings/deb.torproject.org-keyring.gpg
                            ;;
                        8) # None
                            echo "No browser will be uninstalled."
                            sudo clear
                            return
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                # Clean orphaned packages
                echo "Cleaning orphaned packages..."
                nala autoremove -y || { echo "Error cleaning orphaned packages"; }

                echo "Uninstallation completed."

            elif [ "$main_option" -eq 3 ]; then
                echo "Exiting..."
                break
            else
                echo "Invalid option. Please select again."
            fi
        else
            echo "Invalid option. Please select again."
        fi
    done
sudo clear
}

# Función para mostrar el estado de la aplicación
get_app_status() {
    if is_installed "$1"; then
        echo -e "\e[32m✅ Instalado\e[0m"
    else
        echo -e "\e[31m❌ No instalado\e[0m"
    fi
}


# Function to check if a package is installed
is_installed() {
    dpkg -l | grep -E "^ii\s+$1" > /dev/null
}

# Function to display the application status
get_app_status() {
    if is_installed "$1"; then
        echo -e "\e[32m✅\e[0m"  # For installed
    else
        echo "❌"  # For not installed
    fi
}

# Function to check if an application is installed
is_installed() {
    dpkg -l | grep -q "$1"
}

# Function for messaging application installation
install_messaging_apps() {
    # ANSI color codes
    YELLOW='\033[38;5;178m'
    NC='\033[0m' # No Color

    while true; do
        echo "Select an option:"
        echo "1) Install messaging applications"
        echo "2) Uninstall messaging applications"
        echo "3) Exit"
        read -p "Option [1-3]: " option_main
        case $option_main in
            1)  # Install applications
                echo "Select applications to install:"
                echo -e "1) Element ${YELLOW} - Secure messaging app based on Matrix.${NC} $(get_app_status element-desktop)"
                echo -e "2) Gajim ${YELLOW} - Jabber/XMPP client with a user-friendly interface.${NC} $(get_app_status gajim)"
                echo -e "3) Jami ${YELLOW} - Decentralized communication platform for voice, video, and messaging.${NC} $(get_app_status jami)"
                echo -e "4) Pidgin + OTR ${YELLOW} - Multi-protocol instant messaging client with encryption.${NC} $(get_app_status pidgin)"
                echo -e "5) Session ${YELLOW} - Privacy-focused messaging app that doesn't require a phone number.${NC} $(get_app_status session-desktop)"
                echo -e "6) Signal ${YELLOW} - Encrypted messaging app known for its strong privacy features.${NC} $(get_app_status signal-desktop)"
                echo -e "7) Threema ${YELLOW} - Secure messaging app that emphasizes user privacy.${NC} $(get_app_status threema)"
                echo -e "8) Telegram ${YELLOW} - Cloud-based messaging app with a focus on speed and security.${NC} $(get_app_status telegram)"
                echo -e "9) QTox ${YELLOW} - Secure and private messaging app based on Tox protocol.${NC} $(get_app_status qtox)"
                echo "10) None"

                read -p "Option [1-10]: " -a options

                # Install the selected messaging applications
                for option in "${options[@]}"; do
                    case $option in
                        1) # Element
                            if is_installed "element-desktop"; then
                                echo "Element is already installed."
                            else
                                echo "Installing Element..."
                                sudo nala install -y wget apt-transport-https
                                sudo wget -O /usr/share/keyrings/element-io-archive-keyring.gpg https://packages.element.io/debian/element-io-archive-keyring.gpg
                                echo "deb [signed-by=/usr/share/keyrings/element-io-archive-keyring.gpg] https://packages.element.io/debian/ default main" | sudo tee /etc/apt/sources.list.d/element-io.list
                                sudo nala update
                                sudo nala install -y element-desktop
                            fi
                            ;;
                        2) # Gajim
                            if is_installed "gajim"; then
                                echo "Gajim is already installed."
                            else
                                echo "Installing Gajim..."
                                sudo nala install -y gajim || { echo "Error installing Gajim."; }
                            fi
                            ;;
                        3) # Jami
                            if is_installed "jami"; then
                                echo "Jami is already installed."
                            else
                                echo "Installing Jami..."
                                sudo nala install gnupg dirmngr ca-certificates curl --no-install-recommends 
                                curl -s https://dl.jami.net/public-key.gpg | sudo tee /usr/share/keyrings/jami-archive-keyring.gpg > /dev/null
                                sudo sh -c "echo 'deb [signed-by=/usr/share/keyrings/jami-archive-keyring.gpg] https://dl.jami.net/stable/debian_12/ jami main' > /etc/apt/sources.list.d/jami.list"
                                sudo nala update
                                sudo nala install -y jami || { echo "Error installing Jami."; }
                            fi
                            ;;
                        4) # Pidgin + OTR
                            if is_installed "pidgin"; then
                                echo "Pidgin is already installed."
                            else
                                echo "Installing Pidgin + OTR..."
                                sudo nala install -y pidgin pidgin-otr || { echo "Error installing Pidgin + OTR."; }
                            fi
                            sudo clear
                            ;;
                        5) # Session
                            if is_installed "session-desktop"; then
                                echo "Session is already installed."
                            else
                                echo "Installing Session..."
                                sudo curl -so /etc/apt/trusted.gpg.d/oxen.gpg https://deb.oxen.io/pub.gpg
                                echo "deb https://deb.oxen.io $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/oxen.list
                                sudo nala update
                                sudo nala install -y session-desktop || { echo "Error installing Session."; }
                            fi
                            ;;
                        6) # Signal
                            if is_installed "signal-desktop"; then
                                echo "Signal is already installed."
                            else
                                echo "Installing Signal..."
                                wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
                                cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
                                echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | sudo tee /etc/apt/sources.list.d/signal-xenial.list
                                sudo nala update
                                sudo nala install -y signal-desktop || { echo "Error installing Signal."; }
                            fi
                            ;;
                        7) # Threema
                            if is_installed "threema"; then
                                echo "Threema is already installed."
                            else
                                echo "Installing Threema..."
                                cd /tmp
                                wget -O Threema-Latest.deb https://releases.threema.ch/web-electron/v1/release/Threema-Latest.deb
                                sudo nala install -y ./Threema-Latest.deb || { echo "Error installing Threema."; }
                                rm Threema-Latest.deb  # Remove the .deb file after installation
                            fi
                            ;;
                        8) # Telegram
                            if is_installed "telegram-desktop"; then
                                echo "Telegram is already installed."
                            else
                                sudo nala install -y telegram-desktop || { echo "Error installing Telegram."; }
                            fi
                            ;;
                        9) # QTox
                            if is_installed "qtox"; then
                                echo "QTox is already installed."
                            else
                                echo "Installing QTox..."
                                sudo nala install -y qtox || { echo "Error installing QTox."; }
                            fi
                            ;;
                        10) # None
                            echo "No applications will be installed."
                            sudo clear
                            return
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                echo "Installation completed."
                # Clean up orphaned packages
                sudo nala autoremove -y
                ;;

            2)  # Uninstall applications
                echo -e "1) Element ${YELLOW} - Secure messaging app based on Matrix.${NC} $(get_app_status element-desktop)"
                echo -e "2) Gajim ${YELLOW} - Jabber/XMPP client with a user-friendly interface.${NC} $(get_app_status gajim)"
                echo -e "3) Jami ${YELLOW} - Decentralized communication platform for voice, video, and messaging.${NC} $(get_app_status jami)"
                echo -e "4) Pidgin + OTR ${YELLOW} - Multi-protocol instant messaging client with encryption.${NC} $(get_app_status pidgin)"
                echo -e "5) Session ${YELLOW} - Privacy-focused messaging app that doesn't require a phone number.${NC} $(get_app_status session-desktop)"
                echo -e "6) Signal ${YELLOW} - Encrypted messaging app known for its strong privacy features.${NC} $(get_app_status signal-desktop)"
                echo -e "7) Threema ${YELLOW} - Secure messaging app that emphasizes user privacy.${NC} $(get_app_status threema)"
                echo -e "8) Telegram ${YELLOW} - Cloud-based messaging app with a focus on speed and security.${NC} $(get_app_status telegram)"
                echo -e "9) QTox ${YELLOW} - Secure and private messaging app based on Tox protocol.${NC} $(get_app_status qtox)"
                echo "10) None"

                read -p "Option [1-10]: " -a options

                # Uninstall the selected messaging applications
                for option in "${options[@]}"; do
                    case $option in
                        1) # Element
                            if is_installed "element-desktop"; then
                                echo "Uninstalling Element..."
                                sudo nala remove --purge -y element-desktop || { echo "Error uninstalling Element."; }
                                sudo rm -r /etc/apt/sources.list.d/element-io.list
	                            else
                                echo "Element is not installed."
                            fi
                            ;;
                        2) # Gajim
                            if is_installed "gajim"; then
                                echo "Uninstalling Gajim..."
                                sudo nala remove --purge -y gajim || { echo "Error uninstalling Gajim."; }
                            else
                                echo "Gajim is not installed."
                            fi
                            ;;
                        3) # Jami
                            if is_installed "jami"; then
                                echo "Uninstalling Jami..."
                                sudo rm -f /etc/apt/sources.list.d/jami.list
                                sudo rm -f /usr/share/keyrings/jami-archive-keyring.gpg
                                sudo nala remove --purge -y jami || { echo "Error uninstalling Jami."; }
                            else
                                echo "Jami is not installed."
                            fi
                            ;;
                        4) # Pidgin + OTR
                            if is_installed "pidgin"; then
                                echo "Uninstalling Pidgin + OTR..."
                                sudo nala remove --purge -y pidgin pidgin-otr || { echo "Error uninstalling Pidgin + OTR."; }
                            else
                                echo "Pidgin is not installed."
                            fi
                            ;;
                        5) # Session
                            if is_installed "session-desktop"; then
                                echo "Uninstalling Session..."
                                sudo rm -f /etc/apt/sources.list.d/oxen.list
                                sudo rm -f /etc/apt/trusted.gpg.d/oxen.gpg
                                sudo nala remove --purge -y session-desktop || { echo "Error uninstalling Session."; }
                            else
                                echo "Session is not installed."
                            fi
                            ;;
                        6) # Signal
                            if is_installed "signal-desktop"; then
                                echo "Uninstalling Signal..."
                                sudo rm -f /etc/apt/sources.list.d/signal-xenial.list
                                sudo rm -f /usr/share/keyrings/signal-desktop-keyring.gpg
                                sudo nala remove --purge -y signal-desktop || { echo "Error uninstalling Signal."; }
                            else
                                echo "Signal is not installed."
                            fi
                            ;;
                        7) # Threema
                            if is_installed "threema"; then
                                echo "Uninstalling Threema..."
                                sudo nala remove --purge -y threema || { echo "Error uninstalling Threema."; }
                            else
                                echo "Threema is not installed."
                            fi
                            ;;
                        8) # Telegram
                            if is_installed "telegram-desktop"; then
                                echo "Uninstalling Telegram..."
                                sudo nala remove --purge -y telegram-desktop || { echo "Error uninstalling Telegram."; }
                            else
                                echo "Telegram is not installed."
                            fi
                            ;;
                        9) # QTox
                            if is_installed "qtox"; then
                                echo "Uninstalling QTox..."
                                sudo nala remove --purge -y qtox || { echo "Error uninstalling QTox."; }
                            else
                                echo "QTox is not installed."
                            fi
                            ;;
                        10) # None
                            echo "No applications will be uninstalled."
                            sudo clear
                            return
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                echo "Uninstallation completed."
                # Clean up orphaned packages
                sudo nala autoremove -y
                ;;
            3)  # Exit
                echo "Exiting..."
                break
                ;;
            *)  # Invalid option
                echo "Invalid option. Please select again."
                ;;
        esac
    done
sudo clear
}


# Function to check if a package is installed
is_installed() {
    dpkg -l | grep -E "^ii\s+($1|$1-gui|$1-gtk)" > /dev/null 2>&1
}

# Function to display the application status
get_app_status() {
    if is_installed "$1"; then
        echo -e "\e[32m✅\e[0m"  # For installed
    else
        echo "❌"  # For not installed
    fi
}
## Function to check if an application is installed
is_installed() {
    dpkg -l | grep -q "$1"
}

# Function for music application installation
install_music_apps() {
    # ANSI color codes
    YELLOW='\033[38;5;178m'
    NC='\033[0m' # No Color

    while true; do
        echo "Select an option:"
        echo "1) Install music applications"
        echo "2) Uninstall music applications"
        echo "3) Exit"
        read -p "Option [1-3]: " main_option

        if [[ "$main_option" =~ ^[1-3]$ ]]; then
            if [ "$main_option" -eq 1 ]; then
                echo "Select the music applications you want to install (enter the corresponding numbers, separated by spaces):"
                echo -e "1) Audacious ${YELLOW} - Lightweight music player with a simple interface.${NC} $(get_app_status audacious)"
                echo -e "2) Clementine ${YELLOW} - Modern music player and library organizer.${NC} $(get_app_status clementine)"
                echo -e "3) Exaile ${YELLOW} - Music player and library manager with a focus on simplicity.${NC} $(get_app_status exaile)"
                echo -e "4) Lollypop ${YELLOW} - Modern music player with a beautiful interface.${NC} $(get_app_status lollypop)"
                echo -e "5) Ncmpcpp ${YELLOW} - Feature-rich music player client for MPD.${NC} $(get_app_status ncmpcpp)"
                echo -e "6) Quod Libet ${YELLOW} - Music player with a focus on flexibility and extensibility.${NC} $(get_app_status quodlibet)"
                echo -e "7) Strawberry ${YELLOW} - Music player and library organizer inspired by Clementine.${NC} $(get_app_status strawberry)"
                echo "8) None"
                read -p "Option [1-8]: " -a options

                # Install the selected music applications
                for option in "${options[@]}"; do
                    case $option in
                        1) # Audacious
                            echo "Installing Audacious..."
                            nala install -y audacious || { echo "Error installing Audacious"; exit 1; }
                            ;;
                        2) # Clementine
                            echo "Installing Clementine..."
                            nala install -y clementine || { echo "Error installing Clementine"; exit 1; }
                            ;;
                        3) # Exaile
                            echo "Installing Exaile..."
                            nala install -y exaile || { echo "Error installing Exaile"; exit 1; }
                            ;;
                        4) # Lollypop
                            echo "Installing Lollypop..."
                            nala install -y lollypop || { echo "Error installing Lollypop"; exit 1; }
                            ;;
                        5) # Ncmpcpp
                            echo "Installing Ncmpcpp..."
                            nala install -y ncmpcpp || { echo "Error installing Ncmpcpp"; exit 1; }
                            ;;
                        6) # Quod Libet
                            echo "Installing Quod Libet..."
                            nala install -y quodlibet || { echo "Error installing Quod Libet"; exit 1; }
                            ;;
                        7) # Strawberry
                            echo "Installing Strawberry..."
                            nala install -y strawberry || { echo "Error installing Strawberry"; exit 1; }
                            ;;
                        8) # None
                            echo "No music application will be installed."
                            return
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                echo "Installation completed. Enjoy your music applications!"

            elif [ "$main_option" -eq 2 ]; then
                echo "Select the music applications you want to uninstall (enter the corresponding numbers, separated by spaces):"
                echo -e "1) Audacious ${YELLOW} - Lightweight music player with a simple interface.${NC} $(get_app_status audacious)"
                echo -e "2) Clementine ${YELLOW} - Modern music player and library organizer.${NC} $(get_app_status clementine)"
                echo -e "3) Exaile ${YELLOW} - Music player and library manager with a focus on simplicity.${NC} $(get_app_status exaile)"
                echo -e "4) Lollypop ${YELLOW} - Modern music player with a beautiful interface.${NC} $(get_app_status lollypop)"
                echo -e "5) Ncmpcpp ${YELLOW} - Feature-rich music player client for MPD.${NC} $(get_app_status ncmpcpp)"
                echo -e "6) Quod Libet ${YELLOW} - Music player with a focus on flexibility and extensibility.${NC} $(get_app_status quodlibet)"
                echo -e "7) Strawberry ${YELLOW} - Music player and library organizer inspired by Clementine.${NC} $(get_app_status strawberry)"
                echo "8) None"
                read -p "Option [1-8]: " -a options

                # Uninstall the selected music applications
                for option in "${options[@]}"; do
                    case $option in
                        1) # Audacious
                            echo "Uninstalling Audacious..."
                            nala remove --purge -y audacious || { echo "Error uninstalling Audacious"; }
                            ;;
                        2) # Clementine
                            echo "Uninstalling Clementine..."
                            nala remove --purge -y clementine || { echo "Error uninstalling Clementine"; }
                            ;;
                        3) # Exaile
                            echo "Uninstalling Exaile..."
                            nala remove --purge -y exaile || { echo "Error uninstalling Exaile"; }
                            ;;
                        4) # Lollypop
                            echo "Uninstalling Lollypop..."
                            nala remove --purge -y lollypop || { echo "Error uninstalling Lollypop"; }
                            ;;
                        5) # Ncmpcpp
                            echo "Uninstalling Ncmpcpp..."
                            nala remove --purge -y ncmpcpp || { echo "Error uninstalling Ncmpcpp"; }
                            ;;
                        6) # Quod Libet
                            echo "Uninstalling Quod Libet..."
                            nala remove --purge -y quodlibet || { echo "Error uninstalling Quod Libet"; }
                            ;;
                        7) # Strawberry
                            echo "Uninstalling Strawberry..."
                            nala remove --purge -y strawberry || { echo "Error uninstalling Strawberry"; }
                            ;;
                        8) # None
                            echo "No music application will be uninstalled."
                            return
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                # Clean orphaned packages
                echo "Cleaning orphaned packages..."
                nala autoremove -y

                echo "Uninstallation completed."

            elif [ "$main_option" -eq 3 ]; then
                echo "Exiting the music application menu."
                return  # Esto saldrá de la función, pero no del script completo
            else
                echo "Invalid option: $main_option"
            fi  # Fin del bloque if
        else
            echo "Invalid option. Please enter a number between 1 and 3."
        fi  # Fin del bloque if
    done
sudo clear
}

# Function for video application installation
install_video_apps() {
    # ANSI color codes
    YELLOW='\033[38;5;178m'
    NC='\033[0m' # No Color

    while true; do
        echo "Select an option:"
        echo "1) Install video applications"
        echo "2) Uninstall video applications"
        echo "3) Exit"
        read -p "Option [1-3]: " main_option

        if [[ "$main_option" =~ ^[1-3]$ ]]; then
            if [ "$main_option" -eq 1 ]; then
                echo "Select the video applications you want to install (enter the corresponding numbers, separated by spaces):"
                echo -e "1) Avidemux ${YELLOW} - Video editor designed for quick cutting, filtering, and encoding.${NC} $(get_app_status avidemux)"
                echo -e "2) Blender ${YELLOW} - Powerful open-source 3D creation suite with video editing capabilities.${NC} $(get_app_status blender)"
                echo -e "3) Celluloid ${YELLOW} - Simple video player for the GNOME desktop.${NC} $(get_app_status celluloid)"
                echo -e "4) Gnome Videos (Totem) ${YELLOW} - Default video player for GNOME, easy to use.${NC} $(get_app_status totem)"
                echo -e "5) Handbrake ${YELLOW} - Open-source video transcoder for converting video files.${NC} $(get_app_status handbrake)"
                echo -e "6) MKVToolNix ${YELLOW} - Set of tools to create, alter, and inspect Matroska files.${NC} $(get_app_status mkvtoolnix)"
                echo -e "7) MPV ${YELLOW} - Versatile media player based on MPlayer and mplayer2.${NC} $(get_app_status mpv)"
                echo -e "8) Parole ${YELLOW} - Media player designed for the Xfce desktop environment.${NC} $(get_app_status parole)"
                echo -e "9) Pitivi ${YELLOW} - Open-source video editor with a user-friendly interface.${NC} $(get_app_status pitivi)"
                echo -e "10) Shotcut ${YELLOW} - Open-source video editor with a wide range of features.${NC} $(get_app_status shotcut)"
                echo -e "11) VLC Media Player ${YELLOW} - Popular open-source media player that supports various formats.${NC} $(get_app_status vlc)"
                echo "12) None"
                read -p "Option [1-12]: " -a options

                # Install the selected video applications
                for option in "${options[@]}"; do
                    case $option in
                        1) # Avidemux
                            echo "Installing Avidemux..."
                            nala install -y avidemux || { echo "Error installing Avidemux"; exit 1; }
                            ;;
                        2) # Blender
                            echo "Installing Blender..."
                            nala install -y blender || { echo "Error installing Blender"; exit 1; }
                            ;;
                        3) # Celluloid
                            echo "Installing Celluloid..."
                            nala install -y celluloid || { echo "Error installing Celluloid"; exit 1; }
                            ;;
                        4) # Gnome Videos (Totem)
                            echo "Installing Gnome Videos (Totem)..."
                            nala install -y totem || { echo "Error installing Gnome Videos (Totem)"; exit 1; }
                            ;;
                        5) # Handbrake
                            echo "Installing Handbrake..."
                            nala install -y handbrake handbrake-gtk || { echo "Error installing HandBrake"; exit 1; }
                            ;;
                        6) # MKVToolNix
                            echo "Installing MKVToolNix..."
                            sudo wget -O /usr/share/keyrings/gpg-pub-moritzbunkus.gpg https://mkvtoolnix.download/gpg-pub-moritzbunkus.gpg
                            echo "deb [signed-by=/usr/share/keyrings/gpg-pub-moritzbunkus.gpg] https://mkvtoolnix.download/debian/ bookworm main" | sudo tee /etc/apt/sources.list.d/mkvtoolnix.download.list
                            echo "deb-src [signed-by=/usr/share/keyrings/gpg-pub-moritzbunkus.gpg] https://mkvtoolnix.download/debian/ bookworm main" |                             sudo tee -a /etc/apt/sources.list.d/mkvtoolnix.download.list
                            nala update
                            nala install -y mkvtoolnix mkvtoolnix-gui || { echo "Error installing MKVToolNix"; exit 1; }
                            ;;
                        7) # MPV
                            echo "Installing MPV..."
                            nala install -y mpv || { echo "Error installing MPV"; exit 1; }
                            ;;
                        8) # Parole
                            echo "Installing Parole..."
                            nala install -y parole || { echo "Error installing Parole"; exit 1; }
                            ;;
                        9) # Pitivi
                            echo "Installing Pitivi..."
                            nala install -y pitivi || { echo "Error installing Pitivi"; exit 1; }
                            ;;
                        10) # Shotcut
                            echo "Installing Shotcut..."
                            nala install -y shotcut || { echo "Error installing Shotcut"; exit 1; }
                            ;;
                        11) # VLC Media Player
                            echo "Installing VLC Media Player..."
                            nala install -y vlc || { echo "Error installing VLC Media Player"; exit 1; }
                            ;;
                        12) # None
                            echo "No video application will be installed."
                            return
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                echo "Installation completed. Enjoy your video applications!"

            elif [ "$main_option" -eq 2 ]; then
                echo "Select the video applications you want to uninstall (enter the corresponding numbers, separated by spaces):"
                echo -e "1) Avidemux ${YELLOW} - Video editor designed for quick cutting, filtering, and encoding.${NC} $(get_app_status avidemux)"
                echo -e "2) Blender ${YELLOW} - Powerful open-source 3D creation suite with video editing capabilities.${NC} $(get_app_status blender)"
                echo -e "3) Celluloid ${YELLOW} - Simple video player for the GNOME desktop.${NC} $(get_app_status celluloid)"
                echo -e "4) Gnome Videos (Totem) ${YELLOW} - Default video player for GNOME, easy to use.${NC} $(get_app_status totem)"
                echo -e "5) Handbrake ${YELLOW} - Open-source video transcoder for converting video files.${NC} $(get_app_status handbrake)"
                echo -e "6) MKVToolNix ${YELLOW} - Set of tools to create, alter, and inspect Matroska files.${NC} $(get_app_status mkvtoolnix)"
                echo -e "7) MPV ${YELLOW} - Versatile media player based on MPlayer and mplayer2.${NC} $(get_app_status mpv)"
                echo -e "8) Parole ${YELLOW} - Media player designed for the Xfce desktop environment.${NC} $(get_app_status parole)"
                echo -e "9) Pitivi ${YELLOW} - Open-source video editor with a user-friendly interface.${NC} $(get_app_status pitivi)"
                echo -e "10) Shotcut ${YELLOW} - Open-source video editor with a wide range of features.${NC} $(get_app_status shotcut)"
                echo -e "11) VLC Media Player ${YELLOW} - Popular open-source media player that supports various formats.${NC} $(get_app_status vlc)"
                echo "12) None"
                read -p "Option [1-12]: " -a options

                # Uninstall the selected video applications
                for option in "${options[@]}"; do
                    case $option in
                        1) # Avidemux
                            echo "Uninstalling Avidemux..."
                            nala remove --purge -y avidemux || { echo "Error uninstalling Avidemux"; }
                            ;;
                        2) # Blender
                            echo "Uninstalling Blender..."
                            nala remove --purge -y blender || { echo "Error uninstalling Blender"; }
                            ;;
                        3) # Celluloid
                            echo "Uninstalling Celluloid..."
                            nala remove --purge -y celluloid || { echo "Error uninstalling Celluloid"; }
                            ;;
                        4) # Gnome Videos (Totem)
                            echo "Uninstalling Gnome Videos (Totem)..."
                            nala remove --purge -y totem || { echo "Error uninstalling Gnome Videos (Totem)"; }
                            ;;
                        5) # Handbrake
                            echo "Uninstalling Handbrake..."
                            nala remove --purge -y handbrake-gtk || { echo "Error uninstalling Handbrake"; }
                            ;;
                        6) # MKVToolNix
                            echo "Uninstalling MKVToolNix..."
                            nala remove --purge -y mkvtoolnix || { echo "Error uninstalling MKVToolNix"; }
                            ;;
                        7) # MPV
                            echo "Uninstalling MPV..."
                            nala remove --purge -y mpv || { echo "Error uninstalling MPV"; }
                            ;;
                        8) # Parole
                            echo "Uninstalling Parole..."
                            nala remove --purge -y parole || { echo "Error uninstalling Parole"; }
                            ;;
                        9) # Pitivi
                            echo "Uninstalling Pitivi..."
                            nala remove --purge -y pitivi || { echo "Error uninstalling Pitivi"; }
                            ;;
                        10) # Shotcut
                            echo "Uninstalling Shotcut..."
                            nala remove --purge -y shotcut || { echo "Error uninstalling Shotcut"; }
                            ;;
                        11) # VLC Media Player
                            echo "Uninstalling VLC Media Player..."
                            nala remove --purge -y vlc || { echo "Error uninstalling VLC Media Player"; }
                            ;;
                        12) # None
                            echo "No video application will be uninstalled."
                            return
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                # Clean orphaned packages
                echo "Cleaning orphaned packages..."
                nala autoremove -y

                # Optionally, remove repositories related to uninstalled applications
                echo "Removing unnecessary repositories..."
                # Aquí puedes agregar lógica para eliminar repositorios específicos si es necesario
                # Por ejemplo, si has agregado repositorios específicos para MKVToolNix, puedes eliminarlos aquí.

                echo "Uninstallation completed."

            elif [ "$main_option" -eq 3 ]; then
                echo "Exiting the video application menu."
                return  # Esto saldrá de la función, pero no del script completo
            else
                echo "Invalid option: $main_option"
            fi  # Fin del bloque if
        else
            echo "Invalid option. Please enter a number between 1 and 3."
        fi  # Fin del bloque if
    done
sudo clear
}



# Function for multimedia application installation
install_multimedia_apps() {
    # ANSI color codes
    YELLOW='\033[38;5;178m'
    NC='\033[0m' # No Color

    while true; do
        echo "Select an option:"
        echo "1) Install multimedia applications"
        echo "2) Uninstall multimedia applications"
        echo "3) Exit"
        read -p "Option [1-3]: " main_option

        if [[ "$main_option" =~ ^[1-3]$ ]]; then
            if [ "$main_option" -eq 1 ]; then
                echo "Select the multimedia applications you want to install (enter the corresponding numbers, separated by spaces):"
                echo -e "1) Aegisub ${YELLOW} - Subtitle editor for creating and editing subtitles.${NC} $(get_app_status aegisub)"
                echo -e "2) Brasero ${YELLOW} - Disc burning application for GNOME.${NC} $(get_app_status brasero)"
                echo -e "3) ExFalso ${YELLOW} - Audio tag editor for various audio formats.${NC} $(get_app_status exfalso)"
                echo -e "4) Kodi ${YELLOW} - Open-source media center for managing and playing media.${NC} $(get_app_status kodi)"
                echo -e "5) Media-Downloader ${YELLOW} - Tool for downloading media from various sources.${NC} $(get_app_status media-downloader)"
                echo -e "6) Mediainfo ${YELLOW} - Tool for reading media file information.${NC} $(get_app_status mediainfo)"
                echo -e "7) OBS Studio ${YELLOW} - Open-source software for video recording and live streaming.${NC} $(get_app_status obs-studio)"
                echo -e "8) SimpleScreenRecorder ${YELLOW} - Easy-to-use screen recording application.${NC} $(get_app_status simplescreenrecorder)"
                echo -e "9) Stremio ${YELLOW} - Media center for streaming and organizing content.${NC} $(get_app_status stremio)"
                echo "10) None"
                read -p "Option [1-10]: " -a options

                # Install the selected multimedia applications
                for option in "${options[@]}"; do
                    case $option in
                        1) # Aegisub
                            echo "Installing Aegisub..."
                            nala install -y aegisub || { echo "Error installing Aegisub"; exit 1; }
                            ;;
                        2) # Brasero
                            echo "Installing Brasero..."
                            nala install -y brasero || { echo "Error installing Brasero"; exit 1; }
                            ;;
                        3) # ExFalso
                            echo "Installing ExFalso..."
                            nala install -y exfalso || { echo "Error installing ExFalso"; exit 1; }
                            ;;
                        4) # Kodi
                            echo "Installing Kodi..."
                            nala install -y kodi || { echo "Error installing Kodi"; exit 1; }
                            ;;
                        5) # Media-Downloader
                            echo "Installing Media-Downloader..."
                            nala install -y media-downloader || { echo "Error installing Media-Downloader"; exit 1; }
                            ;;
                        6) # Mediainfo
                            echo "Installing Mediainfo..."
                            nala install -y mediainfo || { echo "Error installing Mediainfo"; exit 1; }
                            ;;
                        7) # OBS Studio
                            echo "Installing OBS Studio..."
                            nala install -y obs-studio || { echo "Error installing OBS Studio"; exit 1; }
                            ;;
                        8) # SimpleScreenRecorder
                            echo "Installing SimpleScreenRecorder..."
                            nala install -y simplescreenrecorder || { echo "Error installing SimpleScreenRecorder"; exit 1; }
                            ;;
                        9) # Stremio
                            echo "Installing Stremio..."
                            sudo mkdir -p /usr/share/desktop-directories/
                            wget http://ftp.es.debian.org/debian/pool/main/m/mpv/libmpv1_0.32.0-3_amd64.deb
                            sudo dpkg -i libmpv1_0.32.0-3_amd64.deb || sudo apt-get install -f -y
                            wget https://dl.strem.io/shell-linux/v4.4.165/Stremio_v4.4.165.deb
                            sudo dpkg -i Stremio_v4.4.165.deb || sudo apt-get install -f -y
                            rm -f libmpv1_0.32
                            rm -f libmpv1_0.32.0-3_amd64.deb Stremio_v4.4.165.deb
                            sudo clear
                            ;;
                        10) # None
                            echo "No multimedia application will be installed."
                            return
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                echo "Installation completed. Enjoy your multimedia applications!"

            elif [ "$main_option" -eq 2 ]; then
                echo "Select the multimedia applications you want to uninstall (enter the corresponding numbers, separated by spaces):"
                echo -e "1) Aegisub ${YELLOW} - Subtitle editor for creating and editing subtitles.${NC} $(get_app_status aegisub)"
                echo -e "2) Brasero ${YELLOW} - Disc burning application for GNOME.${NC} $(get_app_status brasero)"
                echo -e "3) ExFalso ${YELLOW} - Audio tag editor for various audio formats.${NC} $(get_app_status exfalso)"
                echo -e "4) Kodi ${YELLOW} - Open-source media center for managing and playing media.${NC} $(get_app_status kodi)"
                echo -e "5) Media-Downloader ${YELLOW} - Tool for downloading media from various sources.${NC} $(get_app_status media-downloader)"
                echo -e "6) Mediainfo ${YELLOW} - Tool for reading media file information.${NC} $(get_app_status mediainfo)"
                echo -e "7) OBS Studio ${YELLOW} - Open-source software for video recording and live streaming.${NC} $(get_app_status obs-studio)"
                echo -e "8) SimpleScreenRecorder ${YELLOW} - Easy-to-use screen recording application.${NC} $(get_app_status simplescreenrecorder)"
                echo -e "9) Stremio ${YELLOW} - Media center for streaming and organizing content.${NC} $(get_app_status stremio)"
                echo "10) None"
                read -p "Option [1-10]: " -a options

                # Uninstall the selected multimedia applications
                for option in "${options[@]}"; do
                    case $option in
                        1) # Aegisub
                            echo "Uninstalling Aegisub..."
                            nala remove --purge -y aegisub || { echo "Error uninstalling Aegisub"; }
                            ;;
                        2) # Brasero
                            echo "Uninstalling Brasero..."
                            nala remove --purge -y brasero || { echo "Error uninstalling Brasero"; }
                            ;;
                        3) # ExFalso
                            echo "Uninstalling ExFalso..."
                            nala remove --purge -y exfalso || { echo "Error uninstalling ExFalso"; }
                            ;;
                        4) # Kodi
                            echo "Uninstalling Kodi..."
                            nala remove --purge -y kodi || { echo "Error uninstalling Kodi"; }
                            ;;
                        5) # Media-Downloader
                            echo "Uninstalling Media-Downloader..."
                            nala remove --purge -y media-downloader || { echo "Error uninstalling Media-Downloader"; }
                            ;;
                        6) # Mediainfo
                            echo "Uninstalling Mediainfo..."
                            nala remove --purge -y mediainfo || { echo "Error uninstalling Mediainfo"; }
                            ;;
                        7) # OBS Studio
                            echo "Uninstalling OBS Studio..."
                            nala remove --purge -y obs-studio || { echo "Error uninstalling OBS Studio"; }
                            ;;
                        8) # SimpleScreenRecorder
                            echo "Uninstalling SimpleScreenRecorder..."
                            nala remove --purge -y simplescreenrecorder || { echo "Error uninstalling SimpleScreenRecorder"; }
                            ;;
                        9) # Stremio
                            echo "Uninstalling Stremio..."
                            nala remove --purge -y stremio || { echo "Error uninstalling Stremio"; }
                            ;;
                        10) # None
                            echo "No multimedia application will be uninstalled."
                            return
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                # Clean orphaned packages
                echo "Cleaning orphaned packages..."
                nala autoremove -y

                # Optionally, remove repositories related to uninstalled applications
                echo "Removing unnecessary repositories..."
                # Aquí puedes agregar lógica para eliminar repositorios específicos si es necesario
                # Por ejemplo, si has agregado repositorios específicos para alguna de las aplicaciones, puedes eliminarlos aquí.

                echo "Uninstallation completed."

            elif [ "$main_option" -eq 3 ]; then
                echo "Exiting the multimedia application menu."
                return  # Esto saldrá de la función, pero no del script completo
            else
                echo "Invalid option: $main_option"
            fi  # Fin del bloque if
        else
            echo "Invalid option. Please enter a number between 1 and 3."
        fi  # Fin del bloque if
    done
sudo clear    
}

# Function to check if an application is installed
is_installed() {
    dpkg -l | grep -qw "$1"
}

# Function to display the application status
get_app_status() {
    if is_installed "$1"; then
        echo -e "\e[32m✅\e[0m"  # Green for installed
    else
        echo "❌"  # Red or no color for not installed
    fi
}

install_security_privacy_apps() {
    YELLOW='\033[38;5;178m'
    NC='\033[0m' # No Color

    while true; do
        echo "Select an option:"
        echo "1) Install security and privacy applications"
        echo "2) Uninstall security and privacy applications"
        echo "3) Exit"
        read -p "Option [1-3]: " main_option

        if [[ "$main_option" =~ ^[1-3]$ ]]; then
            if [ "$main_option" -eq 1 ]; then
                echo "Select the security and privacy applications you want to install (enter the corresponding numbers, separated by spaces):"
                echo -e "1) OnionShare ${YELLOW} - Anonymous file sharing tool.${NC} $(get_app_status onionshare)"
                echo -e "2) KeePassXC ${YELLOW} - Password manager.${NC} $(get_app_status keepassxc)"
                echo -e "3) GnuPG ${YELLOW} - Secure communication tool.${NC} $(get_app_status gnupg)"
                echo -e "4) VeraCrypt ${YELLOW} - Disk encryption software.${NC} $(get_app_status veracrypt)"
                echo -e "5) Tailscale ${YELLOW} - VPN service.${NC} $(get_app_status tailscale)"
                echo -e "6) Cryptsetup ${YELLOW} - Disk encryption tool.${NC} $(get_app_status cryptsetup)"
                echo -e "7) OpenVPN ${YELLOW} - VPN client.${NC} $(get_app_status openvpn)"
                echo -e "8) Riseup VPN ${YELLOW} - Privacy-focused VPN.${NC} $(get_app_status riseup-vpn)"
                echo -e "9) BleachBit ${YELLOW} - Privacy and cleaning tool.${NC} $(get_app_status bleachbit)"
                echo -e "10) ClamTk ${YELLOW} - GUI for ClamAV.${NC} $(get_app_status clamtk)"
                echo -e "11) Gufw Firewall ${YELLOW} - User-friendly firewall.${NC} $(get_app_status gufw)"
                echo -e "12) Kleopatra ${YELLOW} - Certificate manager.${NC} $(get_app_status kleopatra)"
                echo -e "13) Metadata Cleaner ${YELLOW} - Removes metadata from files.${NC} $(get_app_status metadata-cleaner)"
                echo -e "14) Syncthing ${YELLOW} - Continuous file synchronization program.${NC} $(get_app_status syncthing)"
                echo "15) None"
                read -p "Option [1-15]: " -a options

                for option in "${options[@]}"; do
                    case $option in
                        1) nala install -y onionshare || { echo "Error installing OnionShare"; exit 1; };;
                        2) nala install -y keepassxc || { echo "Error installing KeePassXC"; exit 1; };;
                        3) nala install -y gnupg || { echo "Error installing GnuPG"; exit 1; };;
                        4) cd /tmp
                        wget https://launchpad.net/veracrypt/trunk/1.26.20/+download/veracrypt-1.26.20-Debian-12-amd64.deb
                        sudo dpkg -i veracrypt-1.26.20-Debian-12-amd64.deb  
                        sudo rm -r veracrypt-1.26.20-Debian-12-amd64.deb 
                        wget https://launchpad.net/veracrypt/trunk/1.26.20/+download/veracrypt-console-1.26.20-Debian-12-amd64.deb
                        sudo dpkg -i veracrypt-console-1.26.20-Debian-12-amd64.deb 
                        sudo rm -r veracrypt-console-1.26.20-Debian-12-amd64.deb|| { echo "Error installing VeraCrypt"; exit 1; };;
                        5) nala install -y tailscale || { echo "Error installing Tailscale"; exit 1; };;
                        6) nala install -y cryptsetup || { echo "Error installing Cryptsetup"; exit 1; };;
                        7) nala install -y openvpn || { echo "Error installing OpenVPN"; exit 1; };;
                        8) nala install -y riseup-vpn || { echo "Error installing Riseup VPN"; exit 1; };;
                        9) nala install -y bleachbit || { echo "Error installing BleachBit"; exit 1; };;
                        10) nala install -y clamtk || { echo "Error installing ClamTk"; exit 1; };;
                        11) nala install -y gufw || { echo "Error installing Gufw Firewall"; exit 1; };;
                        12) nala install -y kleopatra || { echo "Error installing Kleopatra"; exit 1; };;
                        13) nala install -y metadata-cleaner || { echo "Error installing Metadata Cleaner"; exit 1; };;
                        14) nala install -y syncthing || { echo "Error installing Syncthing"; exit 1; };;
                        15) 
                            echo "No security and privacy applications will be installed."
                            ;;
                        *) 
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                echo "Installation completed. Enjoy your security and privacy applications!"

            elif [ "$main_option" -eq 2 ]; then
                echo "Select the security and privacy applications you want to uninstall (enter the corresponding numbers, separated by spaces):"
                echo -e "1) OnionShare ${YELLOW} - Anonymous file sharing tool.${NC} $(get_app_status onionshare)"
                echo -e "2) KeePassXC ${YELLOW} - Password manager.${NC} $(get_app_status keepassxc)"
                echo -e "3) GnuPG ${YELLOW} - Secure communication tool.${NC} $(get_app_status gnupg)"
                echo -e "4) VeraCrypt ${YELLOW} - Disk encryption software.${NC} $(get_app_status veracrypt)"
                echo -e "5) Tailscale ${YELLOW} - VPN service.${NC} $(get_app_status tailscale)"
                echo -e "6) Cryptsetup ${YELLOW} - Disk encryption tool.${NC} $(get_app_status cryptsetup)"
                echo -e "7) OpenVPN ${YELLOW} - VPN client.${NC} $(get_app_status openvpn)"
                echo -e "8) Riseup VPN ${YELLOW} - Privacy-focused VPN.${NC} $(get_app_status riseup-vpn)"
                echo -e "9) BleachBit ${YELLOW} - Privacy and cleaning tool.${NC} $(get_app_status bleachbit)"
                echo -e "10) ClamTk ${YELLOW} - GUI for ClamAV.${NC} $(get_app_status clamtk)"
                echo -e "11) Gufw Firewall ${YELLOW} - User-friendly firewall.${NC} $(get_app_status gufw)"
                echo -e "12) Kleopatra ${YELLOW} - Certificate manager.${NC} $(get_app_status kleopatra)"
                echo -e "13) Metadata Cleaner ${YELLOW} - Removes metadata from files.${NC} $(get_app_status metadata-cleaner)"
                echo -e "14) Syncthing ${YELLOW} - Continuous file synchronization program.${NC} $(get_app_status syncthing)"
                echo "15) None"
                read -p "Option [1-15]: " -a uninstall_options

                for option in "${uninstall_options[@]}"; do
                    case $option in
                        1) nala remove --purge -y onionshare || { echo "Error uninstalling OnionShare"; };;
                        2) nala remove --purge -y keepassxc || { echo "Error uninstalling KeePassXC"; };;
                        3) nala remove --purge -y gnupg || { echo "Error uninstalling GnuPG"; };;
                        4) nala remove --purge -y veracrypt || { echo "Error uninstalling VeraCrypt"; };;
                        5) nala remove --purge -y tailscale tailscale-archive-keyring
                           cd /etc/apt/sources.list.d
                           sudo rm -r tailscale.list || { echo "Error uninstalling Tailscale"; };;
                        6) nala remove --purge -y cryptsetup || { echo "Error uninstalling Cryptsetup"; };;
                        7) nala remove --purge -y openvpn || { echo "Error uninstalling OpenVPN"; };;
                        8) nala remove --purge -y riseup-vpn || { echo "Error uninstalling Riseup VPN"; };;
                        9) nala remove --purge -y bleachbit || { echo "Error uninstalling BleachBit"; };;
                        10) nala remove --purge -y clamtk || { echo "Error uninstalling ClamTk"; };;
                        11) nala remove --purge -y gufw || { echo "Error uninstalling Gufw Firewall"; };;
                        12) nala remove --purge -y kleopatra || { echo "Error uninstalling Kleopatra"; };;
                        13) nala remove --purge -y metadata-cleaner || { echo "Error uninstalling Metadata Cleaner"; };;
                        14) nala remove --purge -y syncthing || { echo "Error uninstalling Syncthing"; };;
                        15) 
                            echo "No security and privacy applications will be uninstalled."
                            ;;
                        *) 
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                # Clean orphaned packages
                echo "Cleaning orphaned packages..."
                nala autoremove -y

                echo "Uninstallation completed."

            elif [ "$main_option" -eq 3 ]; then
                echo "Exiting the security and privacy application menu."
                return
            else
                echo "Invalid option: $main_option"
            fi
        else
            echo "Invalid option. Please enter a number between 1 and 3."
        fi
    done
sudo clear
}

install_audit_security_apps() {
    YELLOW='\033[38;5;178m'
    NC='\033[0m' # No Color

    while true; do
        echo "Select an option:"
        echo "1) Install audit and security testing applications"
        echo "2) Uninstall audit and security testing applications"
        echo "3) Exit"
        read -p "Option [1-3]: " main_option

        if [[ "$main_option" =~ ^[1-3]$ ]]; then
            if [ "$main_option" -eq 1 ]; then
                echo "Select the audit and security testing applications you want to install (enter the corresponding numbers, separated by spaces):"
                echo -e "1) Nmap ${YELLOW} - Network exploration tool.${NC} $(get_app_status nmap)"
                echo -e "2) Wireshark ${YELLOW} - Network protocol analyzer.${NC} $(get_app_status wireshark)"
                echo -e "3) John the Ripper ${YELLOW} - Password cracking tool.${NC} $(get_app_status john)"
                echo -e "4) Nikto ${YELLOW} - Web server scanner.${NC} $(get_app_status nikto)"
                echo -e "5) SQLMap ${YELLOW} - SQL injection testing tool.${NC} $(get_app_status sqlmap)"
                echo -e "6) Ettercap ${YELLOW} - Network sniffer/interceptor/logger.${NC} $(get_app_status ettercap)"
                echo -e "7) Lynis ${YELLOW} - Security auditing tool.${NC} $(get_app_status lynis)"
                echo -e "8) Gobuster ${YELLOW} - Directory/file brute-forcer.${NC} $(get_app_status gobuster)"
                echo -e "9) Suricata ${YELLOW} - Network threat detection engine.${NC} $(get_app_status suricata)"
                echo -e "10) Recon-ng ${YELLOW} - Web reconnaissance framework.${NC} $(get_app_status recon-ng)"
                echo -e "11) Social-Engineer Toolkit (SET) ${YELLOW} - Penetration testing framework for social engineering.${NC} $(get_app_status set)"
                echo "12) None"
                read -p "Option [1-12]: " -a options

                for option in "${options[@]}"; do
                    case $option in
                        1) nala install -y nmap || { echo "Error installing Nmap"; exit 1; };;
                        2) nala install -y wireshark || { echo "Error installing Wireshark"; exit 1; };;
                        3) nala install -y john || { echo "Error installing John the Ripper"; exit 1; };;
                        4) nala install -y nikto || { echo "Error installing Nikto"; exit 1; };;
                        5) nala install -y sqlmap || { echo "Error installing SQLMap"; exit 1; };;
                        6) nala install -y ettercap || { echo "Error installing Ettercap"; exit 1; };;
                        7) nala install -y lynis || { echo "Error installing Lynis"; exit 1; };;
                        8) nala install -y gobuster || { echo "Error installing Gobuster"; exit 1; };;
                        9) nala install -y suricata || { echo "Error installing Suricata"; exit 1; };;
                        10) nala install -y recon-ng || { echo "Error installing Recon-ng"; exit 1; };;
                        11) nala install -y set || { echo "Error installing Social-Engineer Toolkit"; exit 1; };;
                        12) echo "No audit and security testing applications will be installed."
                            ;;
                        *) 
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                echo "Installation completed. Enjoy your audit and security testing applications!"

            elif [ "$main_option" -eq 2 ]; then
                echo "Select the audit and security testing applications you want to uninstall (enter the corresponding numbers, separated by spaces):"
                echo -e "1) Nmap ${YELLOW} - Network exploration tool.${NC} $(get_app_status nmap)"
                echo -e "2) Wireshark ${YELLOW} - Network protocol analyzer.${NC} $(get_app_status wireshark)"
                echo -e "3) John the Ripper ${YELLOW} - Password cracking tool.${NC} $(get_app_status john)"
                echo -e "4) Nikto ${YELLOW} - Web server scanner.${NC} $(get_app_status nikto)"
                echo -e "5) SQLMap ${YELLOW} - SQL injection testing tool.${NC} $(get_app_status sqlmap)"
                echo -e "6) Ettercap ${YELLOW} - Network sniffer/interceptor/logger.${NC} $(get_app_status ettercap)"
                echo -e "7) Lynis ${YELLOW} - Security auditing tool.${NC} $(get_app_status lynis)"
                echo -e "8) Gobuster ${YELLOW} - Directory/file brute-forcer.${NC} $(get_app_status gobuster)"
                echo -e "9) Suricata ${YELLOW} - Network threat detection engine.${NC} $(get_app_status suricata)"
                echo -e "10) Recon-ng ${YELLOW} - Web reconnaissance framework.${NC} $(get_app_status recon-ng)"
                echo -e "11) Social-Engineer Toolkit (SET) ${YELLOW} - Penetration testing framework for social engineering.${NC} $(get_app_status set)"
                echo "12) None"
                read -p "Option [1-12]: " -a uninstall_options

                for option in "${uninstall_options[@]}"; do
                    case $option in
                        1) nala remove --purge -y nmap || { echo "Error uninstalling Nmap"; };;
                        2) nala remove --purge -y wireshark || { echo "Error uninstalling Wireshark"; };;
                        3) nala remove --purge -y john || { echo "Error uninstalling John the Ripper"; };;
                        4) nala remove --purge -y nikto || { echo "Error uninstalling Nikto"; };;
                        5) nala remove --purge -y sqlmap || { echo "Error uninstalling SQLMap"; };;
                        6) nala remove --purge -y ettercap || { echo "Error uninstalling Ettercap"; };;
                        7) nala remove --purge -y lynis || { echo "Error uninstalling Lynis"; };;
                        8) nala remove --purge -y gobuster || { echo "Error uninstalling Gobuster"; };;
                        9) nala remove --purge -y suricata || { echo "Error uninstalling Suricata"; };;
                        10) nala remove --purge -y recon-ng || { echo "Error uninstalling Recon-ng"; };;
                        11) nala remove --purge -y set || { echo "Error uninstalling Social-Engineer Toolkit"; };;
                        12)echo "No audit and security testing applications will be uninstalled."
                            ;;
                        *) 
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                # Clean orphaned packages
                echo "Cleaning orphaned packages..."
                nala autoremove -y

                echo "Uninstallation completed."

            elif [ "$main_option" -eq 3 ]; then
                echo "Exiting the audit and security testing application menu."
                return
            else
                echo "Invalid option: $main_option"
            fi
        else
            echo "Invalid option. Please enter a number between 1 and 3."
        fi
    done
sudo clear
}

# Function for download manager and BitTorrent client installation
install_download_apps() {
    while true; do
        echo "Select an option:"
        echo "1) Install download managers and BitTorrent clients"
        echo "2) Uninstall download managers and BitTorrent clients"
        echo "3) Exit"
        read -p "Option [1-3]: " main_option

        if [[ "$main_option" =~ ^[1-3]$ ]]; then
            if [ "$main_option" -eq 1 ]; then
                echo "Select the download managers and BitTorrent clients you want to install (enter the corresponding numbers, separated by spaces):"
                echo "1) Deluge $(get_app_status deluge)"
                echo "2) qBittorrent $(get_app_status qbittorrent)"
                echo "3) Transmission $(get_app_status transmission-common transmission-gtk)"
                echo "4) Free Download Manager (FDM) $(get_app_status fdm)"
                echo "5) uGet $(get_app_status uget)"
                echo "6) None"
                read -p "Option [1-6]: " -a options

                # Install the selected download managers and BitTorrent clients
                for option in "${options[@]}"; do
                    case $option in
                        1) # Deluge
                            echo "Installing Deluge..."
                            nala install -y deluge || { echo "Error installing Deluge"; exit 1; }
                            ;;
                        2) # qBittorrent
                            echo "Installing qBittorrent..."
                            nala install -y qbittorrent || { echo "Error installing qBittorrent"; exit 1; }
                            ;;
                        3) # Transmission
                            echo "Installing Transmission..."
                            nala install -y transmission-common transmission-gtk || { echo "Error installing Transmission"; exit 1; }
                            ;;
                        4) # Free Download Manager (FDM)
                            echo "Installing Free Download Manager (FDM)..."
                            nala install -y fdm || { echo "Error installing Free Download Manager (FDM)"; exit 1; }
                            ;;
                        5) # uGet
                            echo "Installing uGet..."
                            nala install -y uget || { echo "Error installing uGet"; exit 1; }
                            ;;
                        6) # None
                            echo "No download manager or BitTorrent client will be installed."
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                echo "Installation completed. Enjoy your download managers and BitTorrent clients!"

            elif [ "$main_option" -eq 2 ]; then
                echo "Select the download managers and BitTorrent clients you want to uninstall (enter the corresponding numbers, separated by spaces):"
                echo "1) Deluge $(get_app_status deluge)"
                echo "2) qBittorrent $(get_app_status qbittorrent)"
                echo "3) Transmission $(get_app_status transmission-common transmission-gtk)"
                echo "4) Free Download Manager (FDM) $(get_app_status fdm)"
                echo "5) uGet $(get_app_status uget)"
                echo "6) None"
                read -p "Option [1-6]: " -a uninstall_options

                # Uninstall the selected download managers and BitTorrent clients
                for option in "${uninstall_options[@]}"; do
                    case $option in
                        1) # Deluge
                            nala remove --purge -y deluge || { echo "Error uninstalling Deluge"; }
                            ;;
                        2) # qBittorrent
                            nala remove --purge -y qbittorrent || { echo "Error uninstalling qBittorrent"; }
                            ;;
                        3) # Transmission
                            nala remove --purge -y transmission-common transmission-gtk || { echo "Error uninstalling Transmission"; }
                            ;;
                        4) # Free Download Manager (FDM)
                            nala remove --purge -y fdm || { echo "Error uninstalling Free Download Manager (FDM)"; }
                            ;;
                        5) # uGet
                            nala remove --purge -y uget || { echo "Error uninstalling uGet"; }
                            ;;
                        6) # None
                            echo "No download manager or BitTorrent client will be uninstalled."
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                # Clean orphaned packages
                echo "Cleaning orphaned packages..."
                nala autoremove -y

                # Optionally, remove repositories related to uninstalled applications
                echo "Removing unnecessary repositories..."
                echo "Uninstallation completed."

            elif [ "$main_option" -eq 3 ]; then
                echo "Exiting the download manager and BitTorrent client menu."
                return  # Esto saldrá de la función, pero no del script completo
            else
                echo "Invalid option: $main_option"
            fi  # Fin del bloque if
        else
            echo "Invalid option. Please enter a number between 1 and 3."
        fi  # Fin del bloque if
    done
    sudo clear
}

# Function to install auto-cpufreq from GitHub
install_energy_management_tool() {
    echo "Checking for 'auto-cpufreq' directory..."
    if [ -d "auto-cpufreq" ]; then
        echo "'auto-cpufreq' directory already exists. Removing it to clone fresh."
        rm -rf auto-cpufreq
    fi

    echo "Cloning auto-cpufreq from GitHub..."
    git clone https://github.com/AdnanHodzic/auto-cpufreq.git
    if [ $? -ne 0 ]; then
        echo "Error: Failed to clone auto-cpufreq repository."
        return
    fi

    cd auto-cpufreq || { echo "Error: Failed to enter 'auto-cpufreq' directory."; return; }
    
    echo "Installing auto-cpufreq..."
    sudo ./auto-cpufreq-installer
    if [ $? -ne 0 ]; then
        echo "Error: auto-cpufreq installation failed."
        return
    fi
    echo "auto-cpufreq installed successfully."

    read -p "Do you want to run 'sudo auto-cpufreq --install' now? (y/n): " run_option
    if [[ "$run_option" == "y" ]]; then
        sudo auto-cpufreq --install
        if [ $? -ne 0 ]; then
            echo "Error: Failed to configure auto-cpufreq."
            return
        fi
        echo "auto-cpufreq has been configured."
    fi

    # Return to the previous directory
    cd ..
}

# Function to install TLP normally
install_tlp() {
    echo "Updating package lists..."
    sudo nala update || { echo "Error: Failed to update package lists."; return; }
    
    echo "Installing TLP..."
    sudo nala install -y tlp || { echo "Error: Failed to install TLP."; return; }
    
    echo "TLP installed successfully."
}

# Function to install TLP for ThinkPad
install_tlp_thinkpad() {
    echo "Updating package lists..."
    sudo nala update || { echo "Error: Failed to update package lists."; return; }
    
    echo "Installing TLP and ThinkPad-specific packages..."
    sudo nala install -y tlp tlp-rdw || { echo "Error: Failed to install TLP for ThinkPad."; return; }
    
    echo "TLP for ThinkPad installed successfully."
}

# Function to uninstall auto-cpufreq
uninstall_auto_cpufreq() {
    echo "Uninstalling auto-cpufreq..."
    cd /tmp/
    git clone https://github.com/AdnanHodzic/auto-cpufreq.git
    cd auto-cpufreq || { echo "Error: Failed to enter 'auto-cpufreq' directory."; return; }
    sudo ./auto-cpufreq-installer --remove || { echo "Error: Failed to uninstall auto-cpufreq."; return; }
    echo "auto-cpufreq uninstalled successfully."
}

# Function to uninstall TLP
uninstall_tlp() {
    echo "Uninstalling TLP..."
    sudo nala remove --purge -y tlp || { echo "Error: Failed to uninstall TLP."; return; }
    echo "TLP uninstalled successfully."
}

# Function to manage energy management tools
manage_energy_tools() {
    while true; do
        echo "Select an option for energy management:"
        echo "1) Install auto-cpufreq"
        echo "2) Install TLP"
        echo "3) Install TLP for ThinkPad"
        echo "4) Go back to the main menu"
        read -p "Option [1-4]: " install_option

        case $install_option in
            1)
                install_energy_management_tool
                ;;
            2)
                install_tlp
                ;;
            3)
                install_tlp_thinkpad
                ;;
            4)
                echo "Returning to the main menu."
                return
                ;;
            *)
                echo "Invalid option. Please enter a number between 1 and 4."
                ;;
        esac
    done
}

# Function to remove energy management tools
remove_energy_tools() {
    while true; do
        echo "Select an energy management tool to remove:"
        echo "1) Remove auto-cpufreq"
        echo "2) Remove TLP"
        echo "3) Go back to the main menu"
        read -p "Option [1-3]: " remove_option

        case $remove_option in
            1)
                uninstall_auto_cpufreq
                ;;
            2)
                uninstall_tlp
                ;;
            3)
                echo "Returning to the main menu."
                return
                ;;
            *)
                echo "Invalid option. Please enter a number between 1 and 3."
                ;;
        esac
    done
}

# Function to manage energy tools
manage_energy_tools_menu() {
    check_dependencies
    while true; do
        echo "Select an option:"
        echo "1) Manage energy management tools"
        echo "2) Remove energy management tools"
        echo "3) Exit"
        read -p "Option [1-3]: " app_option

        case $app_option in
            1)
                manage_energy_tools
                ;;
            2)
                remove_energy_tools
                ;;
            3)
                echo "Exiting the energy management menu."
                sudo clear
                return
                ;;
            *)
                echo "Invalid option. Please enter a number between 1 and 3."
                ;;
        esac
    done
}

# Function to check dependencies (placeholder)
check_dependencies() {
    # Aquí puedes agregar la lógica para verificar si las dependencias necesarias están instaladas
    echo "Checking dependencies..."
    # Ejemplo de verificación de una dependencia
    if ! command -v git &> /dev/null; then
        echo "Error: git is not installed. Please install git and try again."
        return 1
    fi
    if ! command -v nala &> /dev/null; then
        echo "Error: nala is not installed. Please install nala and try again."
        return 1
    fi
    echo "All dependencies are satisfied."
}

# Function for backup application installation
install_backup_apps() {
    # ANSI color codes
    YELLOW='\033[38;5;178m'
    NC='\033[0m' # No Color

    while true; do
        echo "Select an option:"
        echo "1) Install backup applications"
        echo "2) Uninstall backup applications"
        echo "3) Exit"
        read -p "Option [1-3]: " main_option

        if [[ "$main_option" =~ ^[1-3]$ ]]; then
            if [ "$main_option" -eq 1 ]; then
                echo "Select the backup applications you want to install (enter the corresponding numbers, separated by spaces):"
                echo -e "1) Back In Time ${YELLOW} - Simple backup tool for Linux.${NC} $(get_app_status backintime-common backintime-qt)"
                echo -e "2) BorgBackup ${YELLOW} - Deduplicating backup program.${NC} $(get_app_status borgbackup)"
                echo -e "3) Deja Dup ${YELLOW} - Simple backup tool with encryption.${NC} $(get_app_status deja-dup)"
                echo -e "4) Duplicity ${YELLOW} - Encrypted bandwidth-efficient backup.${NC} $(get_app_status duplicity)"
                echo -e "5) Restic ${YELLOW} - Fast, secure, and efficient backup.${NC} $(get_app_status restic)"
                echo -e "6) rsnapshot ${YELLOW} - Filesystem snapshot utility for backups.${NC} $(get_app_status rsnapshot)"
                echo -e "7) Timeshift ${YELLOW} - System restore utility for Linux.${NC} $(get_app_status timeshift)"
                echo "8) None"
                read -p "Option [1-8]: " -a options

                # Install the selected backup applications
                for option in "${options[@]}"; do
                    case $option in
                        1) # Back In Time
                            echo "Installing Back In Time..."
                            nala install -y backintime-qt || { echo "Error installing Back In Time"; exit 1; }
                            ;;
                        2) # BorgBackup
                            echo "Installing BorgBackup..."
                            nala install -y borgbackup || { echo "Error installing BorgBackup"; exit 1; }
                            ;;
                        3) # Deja Dup
                            echo "Installing Deja Dup..."
                            nala install -y deja-dup || { echo "Error installing Deja Dup"; exit 1; }
                            ;;
                        4) # Duplicity
                            echo "Installing Duplicity..."
                            nala install -y duplicity || { echo "Error installing Duplicity"; exit 1; }
                            ;;
                        5) # Restic
                            echo "Installing Restic..."
                            nala install -y restic || { echo "Error installing Restic"; exit 1; }
                            ;;
                        6) # rsnapshot
                            echo "Installing rsnapshot..."
                            nala install -y rsnapshot || { echo "Error installing rsnapshot"; exit 1; }
                            ;;
                        7) # Timeshift
                            echo "Installing Timeshift..."
                            nala install -y timeshift || { echo "Error installing Timeshift"; exit 1; }
                            ;;
                        8) # None
                            echo "No backup application will be installed."
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                echo "Installation completed. Enjoy your backup applications!"

            elif [ "$main_option" -eq 2 ]; then
                echo "Select the backup applications you want to uninstall (enter the corresponding numbers, separated by spaces):"
                echo -e "1) Back In Time ${YELLOW} - Simple backup tool for Linux.${NC} $(get_app_status backintime-common backintime-qt)"
                echo -e "2) BorgBackup ${YELLOW} - Deduplicating backup program.${NC} $(get_app_status borgbackup)"
                echo -e "3) Deja Dup ${YELLOW} - Simple backup tool with encryption.${NC} $(get_app_status deja-dup)"
                echo -e "4) Duplicity ${YELLOW} - Encrypted bandwidth-efficient backup.${NC} $(get_app_status duplicity)"
                echo -e "5) Restic ${YELLOW} - Fast, secure, and efficient backup.${NC} $(get_app_status restic)"
                echo -e "6) rsnapshot ${YELLOW} - Filesystem snapshot utility for backups.${NC} $(get_app_status rsnapshot)"
                echo -e "7) Timeshift ${YELLOW} - System restore utility for Linux.${NC} $(get_app_status timeshift)"
                echo "8) None"
                read -p "Option [1-8]: " -a uninstall_options

                # Uninstall the selected backup applications
                for option in "${uninstall_options[@]}"; do
                    case $option in
                        1) # Back In Time
                            nala remove --purge -y backintime* || { echo "Error uninstalling Back In Time"; }
                            ;;
                        2) # BorgBackup
                            nala remove --purge -y borgbackup || { echo "Error uninstalling BorgBackup"; }
                            ;;
                        3) # Deja Dup
                            nala remove --purge -y deja-dup || { echo "Error uninstalling Deja Dup"; }
                            ;;
                        4) # Duplicity
                            nala remove --purge -y duplicity || { echo "Error uninstalling Duplicity"; }
                            ;;
                        5) # Restic
                            nala remove --purge -y restic || { echo "Error uninstalling Restic"; }
                            ;;
                        6) # rsnapshot
                            nala remove --purge -y rsnapshot || { echo "Error uninstalling rsnapshot"; }
                            ;;
                        7) # Timeshift
                            nala remove --purge -y timeshift || { echo "Error uninstalling Timeshift"; }
                            ;;
                        8) # None
                            echo "No backup application will be uninstalled."
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                # Clean orphaned packages
                echo "Cleaning orphaned packages..."
                nala autoremove -y

                # Optionally, remove repositories related to uninstalled applications
                echo "Removing unnecessary repositories..."
                echo "Uninstallation completed."

            elif [ "$main_option" -eq 3 ]; then
                echo "Exiting the backup application menu."
                return  # Esto saldrá de la función, pero no del script completo
            else
                echo "Invalid option: $main_option"
            fi  # Fin del bloque if
        else
            echo "Invalid option. Please enter a number between 1 and 3."
        fi  # Fin del bloque if
    done
sudo clear
}
# Function to check application status
is_installed() {
    dpkg -l | grep -q "^ii  $1 "
}

get_app_status() {
    if is_installed "$1"; then
        echo -e "\e[32m✅\e[0m"  # Green for installed
    else
        echo "❌"  # Red or no color for not installed
    fi
}

# Function for managing PDF readers and LibreOffice installation
manage_pdf_readers_and_libreoffice() {
    # ANSI color codes
    YELLOW='\033[1;33m'
    NC='\033[0m' # No Color

    while true; do
        echo "Select an option:"
        echo "1) Install applications"
        echo "2) Uninstall applications"
        echo "3) Exit"
        read -p "Option [1-3]: " main_option

        if [[ "$main_option" =~ ^[1-3]$ ]]; then
            if [ "$main_option" -eq 1 ]; then
                echo "Select the applications you want to install (enter the corresponding numbers, separated by spaces):"
                echo -e "1) Atril ${YELLOW} - Document viewer for PDF and other formats.${NC} $(get_app_status atril)"
                echo -e "2) Calligra Suite ${YELLOW} - Office suite with various applications.${NC} $(get_app_status calligra)"
                echo -e "3) Calibre ${YELLOW} - E-book management software.${NC} $(get_app_status calibre)"
                echo -e "4) LibreOffice (Normal) ${YELLOW} - Office suite with PDF support.${NC} $(get_app_status libreoffice)"
                echo -e "5) LibreOffice (Backports) ${YELLOW} - Office suite with PDF support from backports.${NC} $(get_app_status libreoffice-backports)"
                echo -e "6) Pdfarranger ${YELLOW} - PDF document editor.${NC} $(get_app_status pdfarranger)"
                echo -e "7) Scribus ${YELLOW} - Desktop publishing software.${NC} $(get_app_status scribus)"
                echo -e "8) Evince ${YELLOW} - Document viewer for PDF and other formats.${NC} $(get_app_status evince)"
                echo "9) None"
                read -p "Option [1-9]: " -a app_options

                # Install the selected applications
                for option in "${app_options[@]}"; do
                    case $option in
                        1) # Atril
                            if [[ $(get_app_status atril) == "❌" ]]; then
                                echo "Installing Atril..."
                                nala install -y atril || { echo "Error installing Atril"; exit 1; }
                            else
                                echo "Atril is already installed."
                            fi
                            ;;
                        2) # Calligra Suite
                            if [[ $(get_app_status calligra) == "❌" ]]; then
                                echo "Installing Calligra Suite..."
                                nala install -y calligra || { echo "Error installing Calligra Suite"; exit 1; }
                            else
                                echo "Calligra Suite is already installed."
                            fi
                            ;;
                        3) # Calibre
                            if [[ $(get_app_status calibre) == "❌" ]]; then
                                echo "Installing Calibre..."
                                nala install -y calibre || { echo "Error installing Calibre"; exit 1; }
                            else
                                echo "Calibre is already installed."
                            fi
                            ;;
4) # LibreOffice Normal
    if [[ $(get_app_status libreoffice) == "❌" ]]; then
        echo "Installing LibreOffice..."
        nala install -y libreoffice libreoffice-style-elementary libreoffice-gnome || { echo "Error installing LibreOffice"; exit 1; }

        # List available language packages
        echo "Fetching available language packages for LibreOffice..."
        language_packages=$(apt-cache search libreoffice-l10n | awk '{print $1}')
        if [ -z "$language_packages" ]; then
            echo "No language packages found."
            echo "No language package will be installed."
        else
            echo "Select the language package for LibreOffice:"
            select language_option in $language_packages "None"; do
                case $language_option in
                    "None")
                        echo "No language package will be installed."
                        break
                        ;;
                    *)  # Manejo de la opción seleccionada
                        echo "Installing the language package: $language_option..."
                        nala install -y "$language_option" || { echo "Error installing the language package: $language_option"; }
                        break
                        ;;
                esac
            done
        fi
    else
        echo "LibreOffice is already installed."
    fi
    ;;
                        5) # LibreOffice Backports
                            if [[ $(get_app_status libreoffice-backports) == "❌" ]]; then
                                echo "Adding the Backports repository..."
                                echo "deb http://deb.debian.org/debian bookworm-backports main" | sudo tee /etc/apt/sources.list.d/backports.list > /dev/null
                                echo "Updating package lists..."
                                nala update

                                echo "Installing LibreOffice from Backports..."
                                apt install -y -t bookworm-backports libreoffice libreoffice-style-elementary libreoffice-gnome || { echo "Error installing LibreOffice from Backports"; exit 1; }

                                # List available language packages
                                echo "Fetching available language packages for LibreOffice from Backports..."
                                language_packages=$(apt-cache search libreoffice-l10n | awk '{print $1}')
                                if [ -z "$language_packages" ]; then
                                    echo "No language packages found."
                                    echo "No language package will be installed."
                                else
                                    echo "Select the language package for LibreOffice:"
                                    select language_option in $language_packages "None"; do
                                        case $language_option in
                                            "None")
                                                echo "No language package will be installed."
                                                break
                                                ;;
                                            *)
                                                echo "Installing the language package: $language_option..."
                                                nala install -y "$language_option" || { echo "Error installing the language package: $language_option"; }
                                                break
                                                ;;
                                        esac
                                    done
                                fi
                            else
                                echo "LibreOffice from Backports is already installed."
                            fi
                            ;;
                        6) # Pdfarranger
                            if [[ $(get_app_status pdfarranger) == "❌" ]]; then
                                echo "Installing Pdfarranger..."
                                nala install -y pdfarranger || { echo "Error installing Pdfarranger"; exit 1; }
                            else
                                echo "Pdfarranger is already installed."
                            fi
                            ;;
                        7) # Scribus
                            if [[ $(get_app_status scribus) == "❌" ]]; then
                                echo "Installing Scribus..."
                                nala install -y scribus || { echo "Error installing Scribus"; exit 1; }
                            else
                                echo "Scribus is already installed."
                            fi
                            ;;
                        8) # Evince
                            if [[ $(get_app_status evince) == "❌" ]]; then
                                echo "Installing Evince..."
                                nala install -y evince || { echo "Error installing Evince"; exit 1; }
                            else
                                echo "Evince is already installed."
                            fi
                            ;;
                        9) # None
                            echo "No applications will be installed."
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                echo "Installation completed. Enjoy your applications!"

            elif [ "$main_option" -eq 2 ]; then
                echo "Select the applications you want to uninstall (enter the corresponding numbers, separated by spaces):"
                echo -e "1) Atril ${YELLOW} - Document viewer for PDF and other formats.${NC} $(get_app_status atril)"
                echo -e "2) Calligra Suite ${YELLOW} - Office suite with various applications.${NC} $(get_app_status calligra)"
                echo -e "3) Calibre ${YELLOW} - E-book management software.${NC} $(get_app_status calibre)"
                echo -e "4) LibreOffice (Normal) ${YELLOW} - Office suite with PDF support.${NC} $(get_app_status libreoffice)"
                echo -e "5) LibreOffice (Backports) ${YELLOW} - Office suite with PDF support from backports.${NC} $(get_app_status libreoffice-backports)"
                echo -e "6) Pdfarranger ${YELLOW} - PDF document editor.${NC} $(get_app_status pdfarranger)"
                echo -e "7) Scribus ${YELLOW} - Desktop publishing software.${NC} $(get_app_status scribus)"
                echo -e "8) Evince ${YELLOW} - Document viewer for PDF and other formats.${NC} $(get_app_status evince)"
                echo "9) None"
                read -p "Option [1-9]: " -a uninstall_options

                # Uninstall the selected applications
                for option in "${uninstall_options[@]}"; do
                    case $option in
                        1) # Atril
                            if [[ $(get_app_status atril) == "✅" ]]; then
                                echo "Uninstalling Atril..."
                                nala remove --purge -y atril || { echo "Error uninstalling Atril"; }
                            else
                                echo "Atril is not installed."
                            fi
                            ;;
                        2) # Calligra Suite
                            if [[ $(get_app_status calligra) == "✅" ]]; then
                                echo "Uninstalling Calligra Suite..."
                                nala remove --purge -y calligra || { echo "Error uninstalling Calligra Suite"; }
                            else
                                echo "Calligra Suite is not installed."
                            fi
                            ;;
                        3) # Calibre
                            if [[ $(get_app_status calibre) == "✅" ]]; then
                                echo "Uninstalling Calibre..."
                                nala remove --purge -y calibre || { echo "Error uninstalling Calibre"; }
                            else
                                echo "Calibre is not installed."
                            fi
                            ;;
                        4) # LibreOffice (Normal)
                            if [[ $(get_app_status libreoffice) == "✅" ]]; then
                                echo "Uninstalling LibreOffice..."
                                nala remove --purge -y libreoffice libreoffice-style-elementary libreoffice-gnome || { echo "Error uninstalling LibreOffice"; }
                            else
                                echo "LibreOffice is not installed."
                            fi
                            ;;
                        5) # LibreOffice (Backports)
                            if [[ $(get_app_status libreoffice-backports) == "✅" ]]; then
                                echo "Uninstalling LibreOffice from Backports..."
                                nala remove --purge -y libreoffice/bookworm-backports || { echo "Error uninstalling LibreOffice from Backports"; }
                            else
                                echo "LibreOffice from Backports is not installed."
                            fi
                            ;;
                        6) # Pdfarranger
                            if [[ $(get_app_status pdfarranger) == "✅" ]]; then
                                echo "Uninstalling Pdfarranger..."
                                nala remove --purge -y pdfarranger || { echo "Error uninstalling Pdfarranger"; }
                            else
                                echo "Pdfarranger is not installed."
                            fi
                            ;;
                        7) # Scribus
                            if [[ $(get_app_status scribus) == "✅" ]]; then
                                echo "Uninstalling Scribus..."
                                nala remove --purge -y scribus || { echo "Error uninstalling Scribus"; }
                            else
                                echo "Scribus is not installed."
                            fi
                            ;;
                        8) # Evince
                            if [[ $(get_app_status evince) == "✅" ]]; then
                                echo "Uninstalling Evince..."
                                nala remove --purge -y evince || { echo "Error uninstalling Evince"; }
                            else
                                echo "Evince is not installed."
                            fi
                            ;;
                        9) # None
                            echo "No applications will be uninstalled."
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                echo "Uninstallation completed. Enjoy your applications!"

            elif [ "$main_option" -eq 3 ]; then
                echo "Exiting the application manager."
                break
            else
                echo "Invalid option. Please select again."
            fi
        else
            echo "Invalid option. Please select again."
        fi
    done
    sudo clear
}                                                                                    

# Function for text editor installation
install_text_editors() {
    # ANSI color codes
    YELLOW='\033[38;5;178m'
    NC='\033[0m' # No Color

    while true; do
        echo "Select an option:"
        echo "1) Install text editors"
        echo "2) Uninstall text editors"
        echo "3) Exit"
        read -p "Option [1-3]: " main_option

        if [[ "$main_option" =~ ^[1-3]$ ]]; then
            if [ "$main_option" -eq 1 ]; then
                echo "Select the text editors you want to install (enter the corresponding numbers, separated by spaces):"
                echo -e "1) AbiWord ${YELLOW} - Word processor.${NC} $(get_app_status abiword)"
                echo -e "2) Bluefish ${YELLOW} - Advanced text editor for web developers.${NC} $(get_app_status bluefish)"
                echo -e "3) Gedit ${YELLOW} - Default text editor for GNOME.${NC} $(get_app_status gedit)"
                echo -e "4) Mousepad ${YELLOW} - Simple text editor for Xfce.${NC} $(get_app_status mousepad)"
                echo -e "5) Neovim ${YELLOW} - Vim-fork focused on extensibility and usability.${NC} $(get_app_status neovim)"
                echo -e "6) Pluma ${YELLOW} - Text editor for the MATE desktop environment.${NC} $(get_app_status pluma)"
                echo -e "7) Pulsar ${YELLOW} - Hackable text editor.${NC} $(get_app_status pulsar)"
                echo -e "8) VIM ${YELLOW} - Highly configurable text editor.${NC} $(get_app_status vim)"
                echo -e "9) Zim ${YELLOW} - Desktop wiki and note-taking application.${NC} $(get_app_status zim)"
                echo "10) None"
                read -p "Option [1-10]: " -a options

                # Install the selected text editors
                for option in "${options[@]}"; do
                    case $option in
                        1) # AbiWord
                            echo "Installing AbiWord..."
                            nala install -y abiword || { echo "Error installing AbiWord"; exit 1; }
                            ;;
                        2) # Bluefish
                            echo "Installing Bluefish..."
                            nala install -y bluefish || { echo "Error installing Bluefish"; exit 1; }
                            ;;
                        3) # Gedit
                            echo "Installing Gedit..."
                            nala install -y gedit || { echo "Error installing Gedit"; exit 1; }
                            ;;
                        4) # Mousepad
                            echo "Installing Mousepad..."
                            nala install -y mousepad || { echo "Error installing Mousepad"; exit 1; }
                            ;;
                        5) # Neovim
                            echo "Installing Neovim..."
                            nala install -y neovim || { echo "Error installing Neovim"; exit 1; }
                            ;;
                        6) # Pluma
                            echo "Installing Pluma..."
                            nala install -y pluma || { echo "Error installing Pluma"; exit 1; }
                            ;;
                        7) # Pulsar
                             # GitHub API URL to get the latest version of Pulsar
                             API_URL="https://api.github.com/repos/pulsar-edit/pulsar/releases/latest"

                             # Get the download URL for the .deb file
                             DOWNLOAD_URL=$(curl -s $API_URL | jq -r '.assets[] | select(.name | test("Linux.pulsar.*_amd64.deb")) | .browser_download_url')

                             # Download the file
                             if [ -n "$DOWNLOAD_URL" ]; then
                             echo "Downloading Pulsar from: $DOWNLOAD_URL"
                             curl -L -o pulsar_latest.deb "$DOWNLOAD_URL"
                                 echo "Download completed."
                             else
                                  echo "Download URL not found."
                                fi
                            echo "Installing Pulsar..."
                                sudo dpkg -i pulsar_latest.deb
                                sudo rm pulsar_latest.deb
                            ;;
                        8) # VIM
                            echo "Installing VIM..."
                            nala install -y vim || { echo "Error installing VIM"; exit 1; }
                            ;;
                        9) # Zim
                            echo "Installing Zim..."
                            nala install -y zim || { echo "Error installing Zim"; exit 1; }
                            ;;
                        10) # None
                            echo "No text editor will be installed."
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                echo "Installation completed. Enjoy your text editors!"

            elif [ "$main_option" -eq 2 ]; then
                echo "Select the text editors you want to uninstall (enter the corresponding numbers, separated by spaces):"
                echo -e "1) AbiWord ${YELLOW} - Word processor.${NC} $(get_app_status                abiword)"
                echo -e "2) Bluefish ${YELLOW} - Advanced text editor for web developers.${NC} $(get_app_status bluefish)"
                echo -e "3) Gedit ${YELLOW} - Default text editor for GNOME.${NC} $(get_app_status gedit)"
                echo -e "4) Mousepad ${YELLOW} - Simple text editor for Xfce.${NC} $(get_app_status mousepad)"
                echo -e "5) Neovim ${YELLOW} - Vim-fork focused on extensibility and usability.${NC} $(get_app_status neovim)"
                echo -e "6) Pluma ${YELLOW} - Text editor for the MATE desktop environment.${NC} $(get_app_status pluma)"
                echo -e "7) Pulsar ${YELLOW} - Hackable text editor.${NC} $(get_app_status pulsar)"
                echo -e "8) VIM ${YELLOW} - Highly configurable text editor.${NC} $(get_app_status vim)"
                echo -e "9) Zim ${YELLOW} - Desktop wiki and note-taking application.${NC} $(get_app_status zim)"
                echo "10) None"
                read -p "Option [1-10]: " -a uninstall_options

                # Uninstall the selected text editors
                for option in "${uninstall_options[@]}"; do
                    case $option in
                        1) # AbiWord
                            echo "Uninstalling AbiWord..."
                            nala remove -y abiword || { echo "Error uninstalling AbiWord"; exit 1; }
                            ;;
                        2) # Bluefish
                            echo "Uninstalling Bluefish..."
                            nala remove -y bluefish || { echo "Error uninstalling Bluefish"; exit 1; }
                            ;;
                        3) # Gedit
                            echo "Uninstalling Gedit..."
                            nala remove -y gedit || { echo "Error uninstalling Gedit"; exit 1; }
                            ;;
                        4) # Mousepad
                            echo "Uninstalling Mousepad..."
                            nala remove -y mousepad || { echo "Error uninstalling Mousepad"; exit 1; }
                            ;;
                        5) # Neovim
                            echo "Uninstalling Neovim..."
                            nala remove -y neovim || { echo "Error uninstalling Neovim"; exit 1; }
                            ;;
                        6) # Pluma
                            echo "Uninstalling Pluma..."
                            nala remove -y pluma || { echo "Error uninstalling Pluma"; exit 1; }
                            ;;
                        7) # Pulsar
                            echo "Uninstalling Pulsar..."
                            sudo dpkg -r pulsar || { echo "Error uninstalling Pulsar"; exit 1; }
                            ;;
                        8) # VIM
                            echo "Uninstalling VIM..."
                            nala remove -y vim || { echo "Error uninstalling VIM"; exit 1; }
                            ;;
                        9) # Zim
                            echo "Uninstalling Zim..."
                            nala remove -y zim || { echo "Error uninstalling Zim"; exit 1; }
                            ;;
                        10) # None
                            echo "No text editor will be uninstalled."
                            ;;
                        *)
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                echo "Uninstallation completed. If you have uninstalled any text editors, they are no longer available on your system."

            elif [ "$main_option" -eq 3 ]; then
                echo "Exiting the script. Goodbye!"
                break
            else
                echo "Invalid option. Please select a valid option."
            fi
        else
            echo "Invalid input. Please enter a number between 1 and 3."
        fi
    done
sudo clear
}
# Function for development application installation
install_development_apps() {
    # ANSI color codes
    YELLOW='\033[38;5;178m'
    NC='\033[0m' # No Color

    while true; do
        echo "Select an option:"
        echo "1) Install development applications"
        echo "2) Uninstall development applications"
        echo "3) Exit"
        read -p "Option [1-3]: " main_option

        if [[ "$main_option" =~ ^[1-3]$ ]]; then
            if [ "$main_option" -eq 1 ]; then
                echo "Select the development applications you want to install (enter the corresponding numbers, separated by spaces):"
                echo -e "1) Docker ${YELLOW} - Container platform.${NC} $(get_app_status docker)"
                echo -e "2) Emacs ${YELLOW} - Text editor and development environment.${NC} $(get_app_status emacs)"
                echo -e "3) Geany ${YELLOW} - Lightweight IDE.${NC} $(get_app_status geany)"
                echo -e "4) Git ${YELLOW} - Version control system.${NC} $(get_app_status git)"
                echo -e "5) Jupyter Notebook ${YELLOW} - Web application for creating notebooks.${NC} $(get_app_status jupyter-notebook)"
                echo -e "6) NetBeans ${YELLOW} - IDE for Java and other languages.${NC} $(get_app_status apache-netbeans)"
                echo "7) None"
                read -p "Option [1-7]: " -a options

                # Install the selected development applications
                for option in "${options[@]}"; do
                    case $option in
                        1) # Docker
                            echo "Installing Docker..."
                            nala install -y docker || { echo "Error installing Docker"; exit 1; }
                            ;;
                        2) # Emacs
                            echo "Installing Emacs..."
                            nala install -y emacs || { echo "Error installing Emacs"; exit 1; }
                            ;;
                        3) # Geany
                            echo "Installing Geany..."
                            nala install -y geany || { echo "Error installing Geany"; exit 1; }
                            ;;
                        4) # Git
                            echo "Installing Git..."
                            nala install -y git || { echo "Error installing Git"; exit 1; }
                            ;;
                        5) # Jupyter Notebook
                            echo "Installing Jupyter Notebook..."
                            nala install -y jupyter-notebook || { echo "Error installing Jupyter Notebook"; exit 1; }
                            ;;
                        6) # NetBeans
                            echo "Installing NetBeans..."
                            cd /tmp
                            wget https://dlcdn.apache.org/netbeans/netbeans-installers/24/apache-netbeans_24-1_all.deb
                            sudo dpkg -i apache-netbeans_24-1_all.deb || { echo "Error installing NetBeans"; exit 1; }
                            sudo rm -r apache-netbeans_24-1_all.deb
                            ;;
                        7) # None
                            echo "No development application will be installed."
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                echo "Installation completed. Enjoy your development applications!"

            elif [ "$main_option" -eq 2 ]; then
                echo "Select the development applications you want to uninstall (enter the corresponding numbers, separated by spaces):"
                echo -e "1) Docker ${YELLOW} - Container platform.${NC} $(get_app_status docker)"
                echo -e "2) Emacs ${YELLOW} - Text editor and development environment.${NC} $(get_app_status emacs)"
                echo -e "3) Geany ${YELLOW} - Lightweight IDE.${NC} $(get_app_status geany)"
                echo -e "4) Git ${YELLOW} - Version control system.${NC} $(get_app_status git)"
                echo -e "5) Jupyter Notebook ${YELLOW} - Web application for creating notebooks.${NC} $(get_app_status jupyter-notebook)"
                echo -e "6) NetBeans ${YELLOW} - IDE for Java and other languages.${NC} $(get_app_status apache-netbeans)"
                echo "7) None"
                read -p "Option [1-7]: " -a uninstall_options

                # Uninstall the selected development applications
                for option in "${uninstall_options[@]}"; do
                    case $option in
                        1) # Docker
                            nala remove --purge -y docker || { echo "Error uninstalling Docker"; }
                            ;;
                        2) # Emacs
                            nala remove --purge -y emacs || { echo "Error uninstalling Emacs"; }
                            ;;
                        3) # Geany
                            nala remove --purge -y geany || { echo "Error uninstalling Geany"; }
                            ;;
                        4) # Git
                            nala remove --purge -y git || { echo "Error uninstalling Git"; }
                            ;;
                        5) # Jupyter Notebook
                            nala remove --purge -y jupyter-notebook || { echo "Error uninstalling Jupyter Notebook"; }
                            ;;
                        6) # NetBeans
                            nala remove --purge -y netbeans || { echo "Error uninstalling NetBeans"; }
                            ;;
                        7) # None
                            echo "No development application will be uninstalled."
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                # Clean orphaned packages
                echo "Cleaning orphaned packages..."
                nala autoremove -y

                # Optionally, remove repositories related to uninstalled applications
                echo "Removing unnecessary repositories..."
                echo "Uninstallation completed."

            elif [ "$main_option" -eq 3 ]; then
                echo "Exiting the development application menu."
                return  # Esto saldrá de la función, pero no del script completo
            else
                echo "Invalid option: $main_option"
            fi  # Fin del bloque if
        else
            echo "Invalid option. Please enter a number between 1 and 3."
        fi  # Fin del bloque if
    done
    sudo clear
}
# Function for terminal application installation
install_terminal_apps() {
    # ANSI color codes
    YELLOW='\033[38;5;178m'
    NC='\033[0m' # No Color

    while true; do
        echo "Select an option:"
        echo "1) Install terminal applications"
        echo "2) Uninstall terminal applications"
        echo "3) Exit"
        read -p "Option [1-3]: " main_option

        if [[ "$main_option" =~ ^[1-3]$ ]]; then
            if [ "$main_option" -eq 1 ]; then
                echo "Select the terminal applications you want to install (enter the corresponding numbers, separated by spaces):"
                echo -e "1) atop ${YELLOW} - Advanced system and process monitor.${NC} $(get_app_status atop)"
                echo -e "2) bmon ${YELLOW} - Bandwidth monitor and rate estimator.${NC} $(get_app_status bmon)"
                echo -e "3) cmatrix ${YELLOW} - The Matrix in your terminal.${NC} $(get_app_status cmatrix)"
                echo -e "4) DUF ${YELLOW} - Disk Usage/Free Utility.${NC} $(get_app_status duf)"
                echo -e "5) fastfetch ${YELLOW} - Fast and simple system information tool.${NC} $(get_app_status fastfetch)"
                echo -e "6) glances ${YELLOW} - Cross-platform monitoring tool.${NC} $(get_app_status glances)"
                echo -e "7) Htop ${YELLOW} - Interactive process viewer.${NC} $(get_app_status htop)"
                echo -e "8) neofetch ${YELLOW} - Display system information in terminal.${NC} $(get_app_status neofetch)"
                echo -e "9) nload ${YELLOW} - Network traffic and bandwidth monitor.${NC} $(get_app_status nload)"
                echo -e "10) iftop ${YELLOW} - Display bandwidth usage on an interface.${NC} $(get_app_status iftop)"
                echo -e "11) nmon ${YELLOW} - Performance monitoring tool.${NC} $(get_app_status nmon)"
                echo -e "12) tcpdump ${YELLOW} - Network packet analyzer.${NC} $(get_app_status tcpdump)"
                echo -e "13) vnstat ${YELLOW} - Network traffic monitor.${NC} $(get_app_status vnstat)"
                echo -e "14) screenfetch ${YELLOW} - Display system information with ASCII art.${NC} $(get_app_status screenfetch)"
                echo "15) Install All"
                echo "16) None"
                read -p "Option [1-16]: " -a options

                # Install the selected terminal applications
                for option in "${options[@]}"; do
                    case $option in
                        1) # atop
                            echo "Installing atop..."
                            nala install -y atop || { echo "Error installing atop"; exit 1; }
                            ;;
                        2) # bmon
                            echo "Installing bmon..."
                            nala install -y bmon || { echo "Error installing bmon"; exit 1; }
                            ;;
                        3) # cmatrix
                            echo "Installing cmatrix..."
                            nala install -y cmatrix || { echo "Error installing cmatrix"; exit 1; }
                            ;;
                        4) # DUF
                            echo "Installing DUF..."
                            nala install -y duf || { echo "Error installing DUF"; exit 1; }
                            ;;
                        5) # fastfetch
                            echo "Installing fastfetch..."
                            cd /tmp
                            wget https://github.com/fastfetch-cli/fastfetch/releases/download/2.34.1/fastfetch-linux-amd64.deb
                            sudo dpkg -i fastfetch-linux-amd64.deb || { echo "Error installing fastfetch"; exit 1; }
                            sudo rm -r fastfetch-linux-amd64.deb
                            ;;
                        6) # glances
                            echo "Installing glances..."
                            nala install -y glances || { echo "Error installing glances"; exit 1; }
                            ;;
                        7) # Htop
                            echo "Installing Htop..."
                            nala install -y htop || { echo "Error installing Htop"; exit 1; }
                            ;;
                        8) # neofetch
                            echo "Installing neofetch..."
                            nala install -y neofetch || { echo "Error installing neofetch"; exit 1; }
                            ;;
                        9) # nload
                            echo "Installing nload..."
                            nala install -y nload || { echo "Error installing nload"; exit 1; }
                            ;;
                        10) # iftop
                            echo "Installing iftop..."
                            nala install -y iftop || { echo "Error installing iftop"; exit 1; }
                            ;;
                        11) # nmon
                            echo "Installing nmon..."
                            nala install -y nmon || { echo "Error installing nmon"; exit 1; }
                            ;;
                        12) # tcpdump
                            echo "Installing tcpdump..."
                            nala install -y tcpdump || { echo "Error installing tcpdump"; exit 1; }
                            ;;
                        13) # vnstat
                            echo "Installing vnstat..."
                            nala install -y vnstat || { echo "Error installing vnstat"; exit 1; }
                            ;;
                        14) # screenfetch
                            echo "Installing screenfetch..."
                            nala install -y screenfetch || { echo "Error installing screenfetch"; exit 1; }
                            ;;
                        15) # Install All
                            echo "Installing all terminal applications..."
                            nala install -y atop bmon cmatrix duf fastfetch glances htop neofetch nload iftop nmon tcpdump vnstat screenfetch || { echo "Error installing all applications"; exit 1; }
                            ;;
                        16) # None
                            echo "No terminal application will be installed."
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                echo "Installation completed. Enjoy your terminal applications!"

            elif [ "$main_option" -eq 2 ]; then
                echo "Select the terminal applications you want to uninstall (enter the corresponding numbers, separated by spaces):"
                echo -e "1) atop ${YELLOW} - Advanced system and process monitor.${NC} $(get_app_status atop)"
                echo -e "2) bmon ${YELLOW} - Bandwidth monitor and rate estimator.${NC} $(get_app_status bmon)"
                echo -e "3) cmatrix ${YELLOW} - The Matrix in your terminal.${NC} $(get_app_status cmatrix)"
                echo -e "4) DUF ${YELLOW} - Disk Usage/Free Utility.${NC} $(get_app_status duf)"
                echo -e "5) fastfetch ${YELLOW} - Fast and simple system information tool.${NC} $(get_app_status fastfetch)"
                echo -e "6) glances ${YELLOW} - Cross-platform monitoring tool.${NC} $(get_app_status glances)"
                echo -e "7) Htop ${YELLOW} - Interactive process viewer.${NC} $(get_app_status htop)"
                echo -e "8) neofetch ${YELLOW} - Display system information in terminal.${NC} $(get_app_status neofetch)"
                echo -e "9) nload ${YELLOW} - Network traffic and bandwidth monitor.${NC} $(get_app_status nload)"
                echo -e "10) iftop ${YELLOW} - Display bandwidth usage on an interface.${NC} $(get_app_status iftop)"
                echo -e "11) nmon ${YELLOW} - Performance monitoring tool.${NC} $(get_app_status nmon)"
                echo -e "12) tcpdump ${YELLOW} - Network packet analyzer.${NC} $(get_app_status tcpdump)"
                echo -e "13) vnstat ${YELLOW} - Network traffic monitor.${NC} $(get_app_status vnstat)"
                echo -e "14) screenfetch ${YELLOW} - Display system information with ASCII art.${NC} $(get_app_status screenfetch)"
                echo "15) Uninstall All"
                echo "16) None"
                read -p "Option [1-16]: " -a uninstall_options

                # Uninstall the selected terminal applications
                for option in "${uninstall_options[@]}"; do
                    case $option in
                        1) # atop
                            nala remove --purge -y atop || { echo "Error uninstalling atop"; }
                            ;;
                        2) # bmon
                            nala remove --purge -y bmon || { echo "Error uninstalling bmon"; }
                            ;;
                        3) # cmatrix
                            nala remove --purge -y cmatrix || { echo "Error uninstalling cmatrix"; }
                            ;;
                        4) # DUF
                            nala remove --purge -y duf || { echo "Error uninstalling DUF"; }
                            ;;
                        5) # fastfetch
                            nala remove --purge -y fastfetch || { echo "Error uninstalling fastfetch"; }
                            ;;
                        6) # glances
                            nala remove --purge -y glances || { echo "Error uninstalling glances"; }
                            ;;
                        7) # Htop
                            nala remove --purge -y htop || { echo "Error uninstalling Htop"; }
                            ;;
                        8) # neofetch
                            nala remove --purge -y neofetch || { echo "Error uninstalling neofetch"; }
                            ;;
                        9) # nload
                            nala remove --purge -y nload || { echo "Error uninstalling nload"; }
                            ;;
                        10) # iftop
                            nala remove --purge -y iftop || { echo "Error uninstalling iftop"; }
                            ;;
                        11) # nmon
                            nala remove --purge -y nmon || { echo "Error uninstalling nmon"; }
                            ;;
                        12) # tcpdump
                            nala remove --purge -y tcpdump || { echo "Error uninstalling tcpdump"; }
                            ;;
                        13) # vnstat
                            nala remove --purge -y vnstat || { echo "Error uninstalling vnstat"; }
                            ;;
                        14) # screenfetch
                            nala remove --purge -y screenfetch || { echo "Error uninstalling screenfetch"; }
                            ;;
                        15) # Uninstall All
                            echo "Uninstalling all terminal applications..."
                            nala remove --purge -y atop bmon cmatrix duf fastfetch glances htop neofetch nload iftop nmon tcpdump vnstat screenfetch || { echo "Error uninstalling all applications"; }
                            ;;
                        16) # None
                            echo "No terminal application will be uninstalled."
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                # Clean orphaned packages
                echo "Cleaning orphaned packages..."
                nala autoremove -y

                # Optionally, remove repositories related to uninstalled applications
                echo "Removing unnecessary repositories..."
                echo "Uninstallation completed."

            elif [ "$main_option" -eq 3 ]; then
                echo "Exiting the terminal application menu."
                return  # Esto saldrá de la función, pero no del script completo
            else
                echo "Invalid option: $main_option"
            fi  # Fin del bloque if
        else
            echo "Invalid option. Please enter a number between 1 and 3."
        fi  # Fin del bloque if
    done
}

# Function for system tool application installation
install_system_tools() {
    # ANSI color codes
    YELLOW='\033[38;5;178m'
    NC='\033[0m' # No Color

    while true; do
        echo "Select an option:"
        echo "1) Install system tool applications"
        echo "2) Uninstall system tool applications"
        echo "3) Exit"
        read -p "Option [1-3]: " main_option

        if [[ "$main_option" =~ ^[1-3]$ ]]; then
            if [ "$main_option" -eq 1 ]; then
                echo "Select the system tool applications you want to install (enter the corresponding numbers, separated by spaces):"
                echo -e "1) BleachBit ${YELLOW} - Clean up your system.${NC} $(get_app_status bleachbit)"
                echo -e "2) Discos de GNOME ${YELLOW} - Disk utility for managing disks and media.${NC} $(get_app_status gnome-disk-utility)"
                echo -e "3) GParted ${YELLOW} - Partition editor for graphically managing disk partitions.${NC} $(get_app_status gparted)"
                echo -e "4) Hardinfo ${YELLOW} - System information and benchmark tool.${NC} $(get_app_status hardinfo*)"
                echo -e "5) Stacer ${YELLOW} - System optimizer and monitoring tool.${NC} $(get_app_status stacer)"
                echo -e "6) Synaptic ${YELLOW} - Graphical package manager.${NC} $(get_app_status synaptic)"
                echo -e "7) Splitcat ${YELLOW} - Split and concatenate files.${NC} $(get_app_status splitcat)"
                echo "8) Install All"
                echo "9) None"
                read -p "Option [1-9]: " -a options

                # Install the selected system tool applications
                for option in "${options[@]}"; do
                    case $option in
                        1) # BleachBit
                            echo "Installing BleachBit..."
                            nala install -y bleachbit || { echo "Error installing BleachBit"; exit 1; }
                            ;;
                        2) # Discos de GNOME
                            echo "Installing Discos de GNOME..."
                            nala install -y gnome-disk-utility || { echo "Error installing Discos de GNOME"; exit 1; }
                            ;;
                        3) # GParted
                            echo "Installing GParted..."
                            nala install -y gparted || { echo "Error installing GParted"; exit 1; }
                            ;;
                        4) # Hardinfo
                            echo "Installing Hardinfo..."
                            nala install -y hardinfo || { echo "Error installing Hardinfo"; exit 1; }
                            ;;
                        5) # Stacer
                            echo "Installing Stacer..."
                            nala install -y stacer || { echo "Error installing Stacer"; exit 1; }
                            ;;
                        6) # Synaptic
                            echo "Installing Synaptic..."
                            nala install -y synaptic || { echo "Error installing Synaptic"; exit 1; }
                            ;;
                        7) # splitcat
                            echo "Installing splitcat..."
                            sudo nala install -y gir1.2-ayatanaappindicator3-0.1
                            wget http://ftp.es.debian.org/debian/pool/main/liba/libappindicator/gir1.2-appindicator3-0.1_0.4.92-7_amd64.deb
                            sudo dpkg -i gir1.2-appindicator3-0.1_0.4.92-7_amd64.deb
                            wget https://github.com/vogonwann/splitcat/releases/download/v0.1.16/splitcat-linux-x64.deb || { echo "Error installing splitcat"; exit 1; }
                            sudo dpkg -i splitcat-linux-x64.deb
                            sudo rm -r splitcat-linux-x64.deb
                            ;;
                        8) # Install All
                            echo "Installing all system tool applications..."
                            nala install -y bleachbit gnome-disk-utility gparted hardinfo stacer synaptic 
                            wget https://github.com/vogonwann/splitcat/releases/download/v0.1.16/splitcat-linux-x64.deb 
                            sudo dpkg -i splitcat-linux-x64.deb
                            sudo rm -r splitcat-linux-x64.deb
                            ;;
                        9) # None
                            echo "No system tool application will be installed."
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                echo "Installation completed. Enjoy your system tool applications!"

            elif [ "$main_option" -eq 2 ]; then
                echo "Select the system tool applications you want to uninstall (enter the corresponding numbers, separated by spaces):"
                echo -e "1) BleachBit ${YELLOW} - Clean up your system.${NC} $(get_app_status bleachbit)"
                echo -e "2) Discos de GNOME ${YELLOW} - Disk utility for managing disks and media.${NC} $(get_app_status gnome-disk-utility)"
                echo -e "3) GParted ${YELLOW} - Partition editor for graphically managing disk partitions.${NC} $(get_app_status gparted)"
                echo -e "4) Hardinfo ${YELLOW} - System information and benchmark tool.${NC} $(get_app_status hardinfo)"
                echo -e "5) Stacer ${YELLOW} - System optimizer and monitoring tool.${NC} $(get_app_status stacer)"
                echo -e "6) Synaptic ${YELLOW} - Graphical package manager.${NC} $(get_app_status synaptic)"
                echo -e "7) splitcat ${YELLOW} - Split and concatenate files.${NC} $(get_app_status splitcat)"
                echo "8) Uninstall All"
                echo "9) None"
                read -p "Option [1-9]: " -a uninstall_options

                # Uninstall the selected system tool applications
                for option in "${uninstall_options[@]}"; do
                    case $option in
                        1) # BleachBit
                            nala remove --purge -y bleachbit || { echo "Error uninstalling BleachBit"; }
                            ;;
                        2) # Discos de GNOME
                            nala remove --purge -y gnome-disk-utility || { echo "Error uninstalling Discos de GNOME"; }
                            ;;
                        3) # GParted
                            nala remove --purge -y gparted || { echo "Error uninstalling GParted"; }
                            ;;
                        4) # Hardinfo
                            nala remove --purge -y hardinfo || { echo "Error uninstalling Hardinfo"; }
                            ;;
                        5) # Stacer
                            nala remove --purge -y stacer || { echo "Error uninstalling Stacer"; }
                            ;;
                        6) # Synaptic
                            nala remove --purge -y synaptic || { echo "Error uninstalling Synaptic"; }
                            ;;
                        7) # splitcat
                            nala remove --purge -y splitcat || { echo "Error uninstalling splitcat"; }
                            ;;
                        8) # Uninstall All
                            echo "Uninstalling all system tool applications..."
                            nala remove --purge -y bleachbit gnome-disk-utility gparted hardinfo stacer synaptic splitcat || { echo "Error uninstalling all applications"; }
                            ;;
                        9) # None
                            echo "No system tool application will be uninstalled."
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                # Clean orphaned packages
                echo "Cleaning orphaned packages..."
                nala autoremove -y

                # Optionally, remove repositories related to uninstalled applications
                echo "Removing unnecessary repositories..."
                echo "Uninstallation completed."

            elif [ "$main_option" -eq 3 ]; then
                echo "Exiting the system tool application menu."
                return  # Esto saldrá de la función, pero no del script completo
            else
                echo "Invalid option: $main_option"
            fi  # Fin del bloque if
        else
            echo "Invalid option. Please enter a number between 1 and 3."
        fi  # Fin del bloque if
    done
}
# Function for privacy and security application installation
install_privacy_security_apps() {
    # ANSI color codes
    YELLOW='\033[38;5;178m'
    NC='\033[0m' # No Color

    while true; do
        echo "Select an option:"
        echo "1) Install privacy and security applications"
        echo "2) Uninstall privacy and security applications"
        echo "3) Exit"
        read -p "Option [1-3]: " main_option

        if [[ "$main_option" =~ ^[1-3]$ ]]; then
            if [ "$main_option" -eq 1 ]; then
                echo "Select the privacy and security applications you want to install (enter the corresponding numbers, separated by spaces):"
                echo -e "1) Aircrack-ng ${YELLOW} - Wireless security auditing tool.${NC} $(get_app_status aircrack-ng)"
                echo -e "2) BeEF ${YELLOW} - Browser Exploitation Framework.${NC} $(get_app_status beef)"
                echo -e "3) BleachBit ${YELLOW} - Privacy and disk space cleaner.${NC} $(get_app_status bleachbit)"
                echo -e "4) Cewl ${YELLOW} - Custom word list generator.${NC} $(get_app_status cewl)"
                echo -e "5) ClamTk ${YELLOW} - GUI for ClamAV antivirus.${NC} $(get_app_status clamtk)"
                echo -e "6) Cryptsetup ${YELLOW} - Disk encryption tool.${NC} $(get_app_status cryptsetup)"
                echo -e "7) Ettercap ${YELLOW} - Network sniffer/interceptor/logger.${NC} $(get_app_status ettercap-graphical)"
                echo -e "8) Firejail ${YELLOW} - Sandbox program for Linux.${NC} $(get_app_status firejail)"
                echo -e "9) Gobuster ${YELLOW} - Directory/file brute-forcer.${NC} $(get_app_status gobuster)"
                echo -e "10) GnuPG ${YELLOW} - Encryption and signing tool.${NC} $(get_app_status gnupg)"
                echo -e "11) Gufw Firewall ${YELLOW} - GUI for UFW firewall.${NC} $(get_app_status gufw)"
                echo -e "12) Hydra ${YELLOW} - Password cracking tool.${NC} $(get_app_status hydra)"
                echo -e "13) John the Ripper ${YELLOW} - Password cracking software.${NC} $(get_app_status john)"
                echo -e "14) KeePassXC ${YELLOW} - Password manager.${NC} $(get_app_status keepassxc)"
                echo -e "15) Kleopatra ${YELLOW} - Certificate manager and GUI for GnuPG.${NC} $(get_app_status kleopatra)"
                echo -e "16) Kismet ${YELLOW} - Wireless network detector.${NC} $(get_app_status kismet)"
                echo -e "17) Lynis ${YELLOW} - Security auditing tool.${NC} $(get_app_status lynis)"
                echo -e "18) Metadata Cleaner ${YELLOW} - Remove metadata from files.${NC} $(get_app_status metadata-cleaner)"
                echo -e "19) Nmap ${YELLOW} - Network exploration tool.${NC} $(get_app_status nmap)"
                echo -e "20) Nikto ${YELLOW} - Web server scanner.${NC} $(get_app_status nikto)"
                echo -e "21) OpenVPN ${YELLOW} - VPN solution.${NC} $(get_app_status openvpn)"
                echo -e "22) OnionShare ${YELLOW} - Share files securely and anonymously.${NC} $(get_app_status onionshare)"
                echo -e "23) Riseup VPN ${YELLOW} - Privacy-focused VPN service.${NC} $(get_app_status riseup-vpn)"
                echo -e "24) rkhunter ${YELLOW} - Rootkit scanner.${NC} $(get_app_status rkhunter)"
                echo -e "25) Recon-ng ${YELLOW} - Web reconnaissance framework.${NC} $(get_app_status recon-ng)"
                echo -e "26) Social-Engineer Toolkit (SET) ${YELLOW} - Penetration testing framework for social engineering.${NC} $(get_app_status set)"
                echo -e "27) Suricata ${YELLOW} - Network threat detection engine.${NC} $(get_app_status suricata)"
                echo -e "28) Syncthing ${YELLOW} - Continuous file synchronization.${NC} $(get_app_status syncthing)"
                echo -e "29) Tailscale ${YELLOW} - Zero-config VPN service.${NC} $(get_app_status tailscale)"
                echo -e "30) Tutanota ${YELLOW} - Encrypted email service.${NC} $(get_app_status tutanota)"
                echo -e "31) VeraCrypt ${YELLOW} - Disk encryption software.${NC} $(get_app_status veracrypt)"
                echo -e "32) Sirikali ${YELLOW} - GUI for managing encrypted volumes.${NC} $(get_app_status sirikali)"
                echo -e "33) Wifite ${YELLOW} - Automated wireless attack tool.${NC} $(get_app_status wifite)"
                echo -e "34) WireGuard ${YELLOW} - Modern VPN protocol.${NC} $(get_app_status wireguard)"
                echo -e "35) Wireshark ${YELLOW} - Network protocol analyzer.${NC} $(get_app_status wireshark)"
                echo -e "36) sqlmap ${YELLOW} - Automatic SQL injection tool.${NC} $(get_app_status sqlmap)"
                echo "37) None"
                read -p "Option [1-37]: " -a options

                # Install the selected privacy and security applications
                for option in "${options[@]}"; do
                    case $option in
                        1) # Aircrack-ng
                            echo "Installing Aircrack-ng..."
                            nala install -y aircrack-ng || { echo "Error installing Aircrack-ng"; exit 1; }
                            ;;
                        2) # BeEF
                            echo "Installing BeEF..."
                            nala install -y beef || { echo "Error installing BeEF"; exit 1; }
                            ;;
                        3) # BleachBit
                            echo "Installing BleachBit..."
                            nala install -y bleachbit || { echo "Error installing BleachBit"; exit 1; }
                            ;;
                        4) # Cewl
                            echo "Installing Cewl..."
                            nala install -y cewl || { echo "Error installing Cewl"; exit 1; }
                            ;;
                        5) # ClamTk
                            echo "Installing ClamTk..."
                            nala install -y clamtk || { echo "Error installing ClamTk"; exit 1; }
                            ;;
                        6) # Cryptsetup
                            echo "Installing Cryptsetup..."
                            nala install -y cryptsetup || { echo "Error installing Cryptsetup"; exit 1; }
                            ;;
                        7) # Ettercap
                            echo "Installing Ettercap..."
                            nala install -y ettercap-graphical|| { echo "Error installing Ettercap"; exit 1; }
                            ;;
                        8) # Firejail
                            echo "Installing Firejail..."
                            nala install -y firejail || { echo "Error installing Firejail"; exit 1; }
                            ;;
                        9) # Gobuster
                            echo "Installing Gobuster..."
                            nala install -y gobuster || { echo "Error installing Gobuster"; exit 1; }
                            ;;
                        10) # GnuPG
                            echo "Installing GnuPG..."
                            nala install -y gnupg || { echo "Error installing GnuPG"; exit 1; }
                            ;;
                        11) # Gufw Firewall
                            echo "Installing Gufw Firewall..."
                            nala install -y gufw || { echo "Error installing Gufw Firewall"; exit 1; }
                            ;;
                        12) # Hydra
                            echo "Installing Hydra..."
                            nala install -y hydra || { echo "Error installing Hydra"; exit 1; }
                            ;;
                        13) # John the Ripper
                            echo "Installing John the Ripper..."
                            nala install -y john || { echo "Error installing John the Ripper"; exit 1; }
                            ;;
                        14) # KeePassXC
                            echo "Installing KeePassXC..."
                            nala install -y keepassxc || { echo "Error installing KeePassXC"; exit 1; }
                            ;;
                        15) # Kleopatra
                            echo "Installing Kleopatra..."
                            nala install -y kleopatra || { echo "Error installing Kleopatra"; exit 1; }
                            ;;
                        16) # Kismet
                            echo "Installing Kismet..."
                            wget -O - https://www.kismetwireless.net/repos/kismet-release.gpg.key --quiet | gpg --dearmor | sudo tee /usr/share/keyrings/kismet-archive-keyring.gpg >/dev/null
                            echo 'deb [signed-by=/usr/share/keyrings/kismet-archive-keyring.gpg] https://www.kismetwireless.net/repos/apt/release/bookworm bookworm main' | sudo tee /etc/apt/sources.list.d/kismet.list >/dev/null
                            sudo nala update
                            sudo nala install kismet || { echo "Error installing Kismet"; exit 1; }
                            ;;
                        17) # Lynis
                            echo "Installing Lynis..."
                            nala install -y lynis || { echo "Error installing Lynis"; exit 1; }
                            ;;
                        18) # Metadata Cleaner
                            echo "Installing Metadata Cleaner..."
                            nala install -y metadata-cleaner || { echo "Error installing Metadata Cleaner"; exit 1; }
                            ;;
                        19) # Nmap
                            echo "Installing Nmap..."
                            nala install -y nmap || { echo "Error installing Nmap"; exit 1; }
                            ;;
                        20) # Nikto
                            echo "Installing Nikto..."
                            nala install -y nikto || { echo "Error installing Nikto"; exit 1; }
                            ;;
                        21) # OpenVPN
                            echo "Installing OpenVPN..."
                            nala install -y openvpn || { echo "Error installing OpenVPN"; exit 1; }
                            ;;
                        22) # OnionShare
                            echo "Installing OnionShare..."
                            nala install -y onionshare || { echo "Error installing OnionShare"; exit 1; }
                            ;;
                        23) # Riseup VPN
                            echo "Installing Riseup VPN..."
                            nala install -y riseup-vpn || { echo "Error installing Riseup VPN"; exit 1; }
                            ;;
                        24) # rkhunter
                            echo "Installing rkhunter..."
                            nala install -y rkhunter || { echo "Error installing rkhunter"; exit 1; }
                            ;;
                        25) # Recon-ng
                            echo "Installing Recon-ng..."
                            nala install -y recon-ng || { echo "Error installing Recon-ng"; exit 1; }
                            ;;
                        26) # Social-Engineer Toolkit (SET)
                            echo "Installing Social-Engineer Toolkit (SET)..."
                            nala install -y set || { echo "Error installing Social-Engineer Toolkit (SET)"; exit 1; }
                            ;;
                        27) # Suricata
                            echo "Installing Suricata..."
                            nala install -y suricata || { echo "Error installing Suricata"; exit 1; }
                            ;;
                        28) # Syncthing
                            echo "Installing Syncthing..."
                            nala install -y syncthing || { echo "Error installing Syncthing"; exit 1; }
                            ;;
                        29) # Tailscale
                            echo "Installing Tailscale..."
                            nala install -y tailscale || { echo "Error installing Tailscale"; exit 1; }
                            ;;
                        30) # VeraCrypt
                            echo "Installing VeraCrypt..."
                            nala install -y veracrypt || { echo "Error installing VeraCrypt"; exit 1; }
                            ;;
                        31) # Sirikali
                            echo "Installing Sirikali..."
                            nala install -y sirikali || { echo "Error installing Sirikali"; exit 1; }
                            ;;
                        32) # Wifite
                            echo "Installing Wifite..."
                            nala install -y wifite || { echo "Error installing Wifite"; exit 1; }
                            ;;
                        33) # WireGuard
                            echo "Installing WireGuard..."
                            nala install -y wireguard || { echo "Error installing WireGuard"; exit 1; }
                            ;;
                        34) # Wireshark
                            echo "Installing Wireshark..."
                            nala install -y wireshark || { echo "Error installing Wireshark"; exit 1; }
                            ;;
                        35) # sqlmap
                            echo "Installing sqlmap..."
                            nala install -y sqlmap || { echo "Error installing sqlmap"; exit 1; }
                            ;;
                        36) # None
                            echo "No privacy and security application will be installed."
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                echo "Installation completed. Enjoy your privacy and security applications!"

            elif [ "$main_option" -eq 2 ]; then
                echo "Select the privacy and security applications you want to install (enter the corresponding numbers, separated by spaces):"
                echo -e "1) Aircrack-ng ${YELLOW} - Wireless security auditing tool.${NC} $(get_app_status aircrack-ng)"
                echo -e "2) BeEF ${YELLOW} - Browser Exploitation Framework.${NC} $(get_app_status beef)"
                echo -e "3) BleachBit ${YELLOW} - Privacy and disk space cleaner.${NC} $(get_app_status bleachbit)"
                echo -e "4) Cewl ${YELLOW} - Custom word list generator.${NC} $(get_app_status cewl)"
                echo -e "5) ClamTk ${YELLOW} - GUI for ClamAV antivirus.${NC} $(get_app_status clamtk)"
                echo -e "6) Cryptsetup ${YELLOW} - Disk encryption tool.${NC} $(get_app_status cryptsetup)"
                echo -e "7) Ettercap ${YELLOW} - Network sniffer/interceptor/logger.${NC} $(get_app_status ettercap-graphical)"
                echo -e "8) Firejail ${YELLOW} - Sandbox program for Linux.${NC} $(get_app_status firejail)"
                echo -e "9) Gobuster ${YELLOW} - Directory/file brute-forcer.${NC} $(get_app_status gobuster)"
                echo -e "10) GnuPG ${YELLOW} - Encryption and signing tool.${NC} $(get_app_status gnupg)"
                echo -e "11) Gufw Firewall ${YELLOW} - GUI for UFW firewall.${NC} $(get_app_status gufw)"
                echo -e "12) Hydra ${YELLOW} - Password cracking tool.${NC} $(get_app_status hydra)"
                echo -e "13) John the Ripper ${YELLOW} - Password cracking software.${NC} $(get_app_status john)"
                echo -e "14) KeePassXC ${YELLOW} - Password manager.${NC} $(get_app_status keepassxc)"
                echo -e "15) Kleopatra ${YELLOW} - Certificate manager and GUI for GnuPG.${NC} $(get_app_status kleopatra)"
                echo -e "16) Kismet ${YELLOW} - Wireless network detector.${NC} $(get_app_status kismet)"
                echo -e "17) Lynis ${YELLOW} - Security auditing tool.${NC} $(get_app_status lynis)"
                echo -e "18) Metadata Cleaner ${YELLOW} - Remove metadata from files.${NC} $(get_app_status metadata-cleaner)"
                echo -e "19) Nmap ${YELLOW} - Network exploration tool.${NC} $(get_app_status nmap)"
                echo -e "20) Nikto ${YELLOW} - Web server scanner.${NC} $(get_app_status nikto)"
                echo -e "21) OpenVPN ${YELLOW} - VPN solution.${NC} $(get_app_status openvpn)"
                echo -e "22) OnionShare ${YELLOW} - Share files securely and anonymously.${NC} $(get_app_status onionshare)"
                echo -e "23) Riseup VPN ${YELLOW} - Privacy-focused VPN service.${NC} $(get_app_status riseup-vpn)"
                echo -e "24) rkhunter ${YELLOW} - Rootkit scanner.${NC} $(get_app_status rkhunter)"
                echo -e "25) Recon-ng ${YELLOW} - Web reconnaissance framework.${NC} $(get_app_status recon-ng)"
                echo -e "26) Social-Engineer Toolkit (SET) ${YELLOW} - Penetration testing framework for social engineering.${NC} $(get_app_status set)"
                echo -e "27) Suricata ${YELLOW} - Network threat detection engine.${NC} $(get_app_status suricata)"
                echo -e "28) Syncthing ${YELLOW} - Continuous file synchronization.${NC} $(get_app_status syncthing)"
                echo -e "29) Tailscale ${YELLOW} - Zero-config VPN service.${NC} $(get_app_status tailscale)"
                echo -e "30) VeraCrypt ${YELLOW} - Disk encryption software.${NC} $(get_app_status veracrypt)"
                echo -e "31) Sirikali ${YELLOW} - GUI for managing encrypted volumes.${NC} $(get_app_status sirikali)"
                echo -e "32) Wifite ${YELLOW} - Automated wireless attack tool.${NC} $(get_app_status wifite)"
                echo -e "33) WireGuard ${YELLOW} - Modern VPN protocol.${NC} $(get_app_status wireguard)"
                echo -e "34) Wireshark ${YELLOW} - Network protocol analyzer.${NC} $(get_app_status wireshark)"
                echo -e "35) sqlmap ${YELLOW} - Automatic SQL injection tool.${NC} $(get_app_status sqlmap)"
                echo "36) None"
                read -p "Option [1-36]: " -a options

                # Uninstall the selected privacy and security applications
                for option in "${uninstall_options[@]}"; do
                    case $option in
                        1) # Aircrack-ng
                            nala remove --purge -y aircrack-ng || { echo "Error uninstalling Aircrack-ng"; }
                            ;;
                        2) # BeEF
                            nala remove --purge -y beef || { echo "Error uninstalling BeEF"; }
                            ;;
                        3) # BleachBit
                            nala remove --purge -y bleachbit || { echo "Error uninstalling BleachBit"; }
                            ;;
                        4) # Bitwarden
                            nala remove --purge -y bitwarden || { echo "Error uninstalling Bitwarden"; }
                            ;;
                        5) # Cewl
                            nala remove --purge -y cewl || { echo "Error uninstalling Cewl"; }
                            ;;
                        6) # ClamTk
                            nala remove --purge -y clamtk || { echo "Error uninstalling ClamTk"; }
                            ;;
                        7) # Cryptsetup
                            nala remove --purge -y cryptsetup || { echo "Error uninstalling Cryptsetup"; }
                            ;;
                        8) # Ettercap
                            nala remove --purge -y ettercap-graphical || { echo "Error uninstalling Ettercap"; }
                            ;;
                        9) # Firejail
                            nala remove --purge -y firejail || { echo "Error uninstalling Firejail"; }
                            ;;
                        10) # Gobuster
                            nala remove --purge -y gobuster || { echo "Error uninstalling Gobuster"; }
                            ;;
                        11) # GnuPG
                            nala remove --purge -y gnupg || { echo "Error uninstalling GnuPG"; }
                            ;;
                        12) # Gufw Firewall
                            nala remove --purge -y gufw || { echo "Error uninstalling Gufw Firewall"; }
                            ;;
                        13) # Hydra
                            nala remove --purge -y hydra || { echo "Error uninstalling Hydra"; }
                            ;;
                        14) # John the Ripper
                            nala remove --purge -y john || { echo "Error uninstalling John the Ripper"; }
                            ;;
                        15) # KeePassXC
                            nala remove --purge -y keepassxc || { echo "Error uninstalling KeePassXC"; }
                            ;;
                        16) # Kleopatra
                            nala remove --purge -y kleopatra || { echo "Error uninstalling Kleopatra"; }
                            ;;
                        17) # Kismet
                            nala remove --purge -y kismet || { echo "Error uninstalling Kismet"; }
                            ;;
                        18) # Lynis
                            nala remove --purge -y lynis || { echo "Error uninstalling Lynis"; }
                            ;;
                        19) # Metadata Cleaner
                            nala remove --purge -y metadata-cleaner || { echo "Error uninstalling Metadata Cleaner"; }
                            ;;
                        20) # Nmap
                            nala remove --purge -y nmap || { echo "Error uninstalling Nmap"; }
                            ;;
                        21) # Nikto
                            nala remove --purge -y nikto || { echo "Error uninstalling Nikto"; }
                            ;;
                        22) # OpenVPN
                            nala remove --purge -y openvpn || { echo "Error uninstalling OpenVPN"; }
                            ;;
                        23) # OnionShare
                            nala remove --purge -y onionshare || { echo "Error uninstalling OnionShare"; }
                            ;;
                        24) # Riseup VPN
                            nala remove --purge -y riseup-vpn || { echo "Error uninstalling Riseup VPN"; }
                            ;;
                        25) # rkhunter
                            nala remove --purge -y rkhunter || { echo "Error uninstalling rkhunter"; }
                            ;;
                        26) # Recon-ng
                            nala remove --purge -y recon-ng || { echo "Error uninstalling Recon-ng"; }
                            ;;
                        27) # Social-Engineer Toolkit (SET)
                            nala remove --purge -y set || { echo "Error uninstalling Social-Engineer Toolkit (SET)"; }
                            ;;
                        28) # Suricata
                            nala remove --purge -y suricata || { echo "Error uninstalling Suricata"; }
                            ;;
                        29) # Syncthing
                            nala remove --purge -y syncthing || { echo "Error uninstalling Syncthing"; }
                            ;;
                        30) # Tailscale
                            nala remove --purge -y tailscale || { echo "Error uninstalling Tailscale"; }
                            ;;
                        31) # VeraCrypt
                            nala remove --purge -y veracrypt || { echo "Error uninstalling VeraCrypt"; }
                            ;;
                        32) # Sirikali
                            nala remove --purge -y sirikali || { echo "Error uninstalling Sirikali"; }
                            ;;
                        33) # Wifite
                            nala remove --purge -y wifite || { echo "Error uninstalling Wifite"; }
                            ;;
                        34) # WireGuard
                            nala remove --purge -y wireguard || { echo "Error uninstalling WireGuard"; }
                            ;;
                        35) # Wireshark
                            nala remove --purge -y wireshark || { echo "Error uninstalling Wireshark"; }
                            ;;
                        36) # sqlmap
                            nala remove --purge -y sqlmap || { echo "Error uninstalling sqlmap"; }
                            ;;
                        37) # None
                            echo "No privacy and security application will be uninstalled."
                            ;;
                        *) # Invalid option
                            echo "Invalid option: $option"
                            ;;
                    esac
                done

                # Clean orphaned packages
                echo "Cleaning orphaned packages..."
                nala autoremove -y

                # Optionally, remove repositories related to uninstalled applications
                echo "Removing unnecessary repositories..."
                echo "Uninstallation completed."

            elif [ "$main_option" -eq 3 ]; then
                echo "Exiting the privacy and security application menu."
                return  # Esto saldrá de la función, pero no del script completo
            else
                echo "Invalid option: $main_option"
            fi  # Fin del bloque if
        else
            echo "Invalid option. Please enter a number between 1 and 3."
        fi  # Fin del bloque if
          sudo clear  
    done
}

# Main menu
while true; do
# Definimos colores
YELLOW='\033[1;33m'
RESET='\033[0m'

# Función para imprimir el título "ROOTDEB" en grande
print_title() {
    echo -e "${YELLOW}"
    echo "██████╗ ██╗ ██████╗ ████████╗██████╗ ███████╗██████╗" 
    echo "██╔══██╗██║██╔═══██╗╚══██╔══╝██╔══██╗██╔════╝██╔══██╗"
    echo "██████╔╝██║██║   ██║   ██║   ██║  ██║█████╗  ██████╔╝"
    echo "██╔══██╗██║██║   ██║   ██║   ██║  ██║██╔══╝  ██╔══██╗"
    echo "██║  ██║██║╚██████╔╝   ██║   ██████╔╝███████╗██████╔╝"
    echo "╚═╝  ╚═╝╚═╝ ╚═════╝    ╚═╝   ╚═════╝ ╚══════╝╚═════╝"
    echo -e "${RESET}"
}
                   
# Imprimir el título
print_title

    echo "Select an option:"
    echo "0) Add additional Debian repositories"
    echo "1) Installing Desktop Environments"
    echo "2) Update Firmware"
    echo "3) CPU & GPU Configuration"
    echo "4) Web Browsers"
    echo "5) Messaging Applications"
    echo "6) Music Applications"
    echo "7) Video Applications"
    echo "8) Multimedia Applications"
    echo "9) Privacy and Security Applications"
    echo "10) Security Auditing and Testing Applications"
    echo "11) Download Manager and BitTorrent Client Installation"
    echo "12) Energy Management Tool Applications"
    echo "13) Backup Applications"
    echo "14) Office Applications"
    echo "15) Text Editors"
    echo "16) Development Applications"
    echo "17) Terminal Applications"    
    echo "18) System Tools"
    echo "19) Privacy and Security Applications"
    echo "20) Exit"
    read -p "Option [0-20]: " menu_option

    case $menu_option in
        0)  # Add additional Debian repositories
            manage_repositories
            ;;
        1)  # Desktop Enviromment
            install_minimal_desktop_envs
            ;;
        2)  # Update Firmware
            update_firmware
            ;;
        3)  # CPU & GPU
            manage_installations
            ;;
        4)  # Web Browsers
            install_browsers
            ;;
        5)  # Messaging Applications
            install_messaging_apps
            ;;
        6) # Music Applications  
            install_music_apps
            ;;
        7) # Video Applications  
            install_video_apps
            ;;  
        8)  # Sound & Video Applications
            install_multimedia_apps
            ;;
        9)  # Privacy and Security Applications
            install_security_privacy_apps
            ;;
        10)  # Penetration Testing Applications
            install_audit_security_apps
            ;;
        11)  # Download Manager and BitTorrent Client Installation
            install_download_apps
            ;;
        12)  # Energy Management Tool
            manage_energy_tools_menu
            ;;
        13) #Backup Applications    
            install_backup_apps
            ;;   
        14) #Office Applications
            manage_pdf_readers_and_libreoffice
            ;;     
        15) #Text Editors
            install_text_editors
            ;;           
        16) # Development Applications
            install_development_apps
            ;;
        17) #Termianl Applications
            install_terminal_apps
            ;;
        18) #System Tools
            install_system_tools
            ;;       
        19) #Privacy and Security Applications
            install_privacy_security_apps
            ;;                       
        20)  # Exit
            echo "Exiting the script. Goodbye!"
            exit 0
            ;;
        *)  # Invalid option
            echo "Invalid option. Please choose an option between 0 and 19."
            ;;
    esac
done

