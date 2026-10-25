LIME=$'\033[1;32m'
RESET=$'\033[0m'
echo "Welcome ${USER} to Arch Package Upgrader!"
read -p "${LIME}Do you want to automatically update all services from pacman, AUR and flatpak? Type "y" for yes, or "n" for no: ${RESET}" answer

if [ "$answer" == "y" ]; then
    read -p "${LIME}Are you sure you want to start the update sequence? This may take a while. Do not interrupt unless something glitches. If you quit this session, your terminal might remain a bold lime color. To fix it, just rerun the program or run 'echo -e "\e[0m"'. Note: all software downloaded via pacman, AUR and flatpak WILL BE updated. That may also include the Linux kernel. Are you SURE you want to update? Type "y" for yes, or "n" for no: ${RESET}" answer1
else
    echo -e "${LIME}You either typed no or typed something else. Letters and capitalization matters. This program will shut down now.${RESET}"
    sleep 3
    exit
fi
if [ "$answer1" == "y" ]; then
    echo -e "${LIME}Starting update sequence in 10 seconds. Do not interrupt unless you have to or the software glitched. This terminal session will also clear in 10 seconds.${RESET}"
    sleep 10
    clear
    if command -v pacman &> /dev/null; then
        pacman=true
    else
        pacman=false
    fi
    if command -v yay &> /dev/null; then
        yay=true
    else
        yay=false
    fi
    if command -v apt &> /dev/null; then
        apt=true
    else
        apt=false
    fi
    if command -v dnf &> /dev/null; then
        dnf=true
    else
        dnf=false
    fi
    if command -v flatpak &> /dev/null; then
        flatpak=true
    else
        flatpak=false
    fi
    if [ "$pacman" = true ]; then
        echo Pacman is present on this software. Updating
        sudo pacman -Syu --noconfirm
        echo Pacman update has finished.
    else
        echo Pacman is not installed on this software. Skipping
    fi
    if [ "$yay" = true ]; then
        echo Yay is present on this software. Updating
        yay -Syu --noconfirm
        echo Yay update has finished.
    else
        echo Yay is not installed on this software. Skipping
    fi
    if [ "$apt" = true ]; then
        echo APT is present on this software. Updating
        sudo apt-get update && sudo apt-get upgrade -y
        echo APT update has finished.
    else
        echo APT is not installed on this software. Skipping
    fi
    if [ "$dnf" = true ]; then
        echo Dnf is present on this software. Updating
        sudo dnf upgrade -y
        echo Dnf update has finished.
    else
        echo Dnf is not installed on this software. Skipping
    if [ "$flatpak" = true ]; then
        echo Flatpak is present on this software. Updating
        sudo flatpak update -y
        echo Flatpak update has finished.
    else
        echo Flatpak is not installed on this software. Skipping
    fi
    echo -e "${LIME}Updating has been completed. The software finished. Quitting...${RESET}"
    sleep 3
    exit
fi
