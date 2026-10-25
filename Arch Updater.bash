stty -echo
LIME=$'\033[1;32m'
RESET=$'\033[0m'
read -p "${LIME}Do you want to automatically update all services from pacman, AUR and flatpak? Type "y" for yes, or "n" for no: ${RESET}" answer

if [ "$answer" == "y" ]; then
    read -p "${LIME}Are you sure you want to start the update sequence? This may take a while. Do not interrupt unless something glitches. If you quit this session, stty -echo might remain on together with a bold lime color. To fix it, just rerun the program. Note: all software downloaded via pacman, AUR and flatpak WILL BE updated. That may also include the Linux kernel. Are you SURE you want to update? Type "y" for yes, or "n" for no: ${RESET}" answer1
else
    echo -e "${LIME}You either typed no or typed something else. Letters and capitalization matters. This program will shut down now.${RESET}"
    sleep 3
    stty echo
    exit
fi
if [ "$answer1" == "y" ]; then
    echo -e "${LIME}Starting update sequence in 10 seconds. Do not interrupt unless you have to or the software glitched. This terminal session will also clear in 10 seconds.${RESET}"
    sleep 10
    clear
    sudo pacman -Syu --noconfirm
    echo -e "${LIME}Pacman update has been completed. Starting AUR update.${RESET}"
    yay -Syu --noconfirm
    echo -e "${LIME}AUR update has been completed. Starting flatpak update.${RESET}"
    flatpak update -y
    echo -e "${LIME}Flatpak update has been completed. The software finished. Quitting...${RESET}"
    sleep 3
    stty echo
    exit
fi
