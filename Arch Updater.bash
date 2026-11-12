LIME=$'\033[1;32m'
RED=$'\033[1;31m'
BLUE=$'\033[1;34m'
RESET=$'\033[0m'
echo "Welcome ${USER} to Arch Package Upgrader!"
read -p "${LIME}Do you want to automatically update all services from APT, Dnf, Pacman, Yay and Flatpak? Type y for yes, or n for no. Note, the program will check what package managers you have installed and update from them: ${RESET}" answer

if [ "$answer" == "y" ]; then
    read -p "${RED}Are you sure you want to start the update sequence? This may take a while. Do not interrupt unless something glitches. If you quit this session, your terminal might remain a bold lime color. To fix it, just rerun the program or run 'echo -e "\e[0m"'. Note: all software downloaded via detected package managers WILL BE updated. That may also include the Linux kernel. Are you SURE you want to update? Type "y" for yes, or "n" for no: ${RESET}" answer1
else
    echo -e "${RED}You either typed no or typed something else. Letters and capitalization matters. This program will shut down now. Press any key to continue...${RESET}"
    read -n 1 -s
    exit 1
fi
if [ "$answer1" == "y" ]; then
    echo -e "${LIME}Starting update sequence. Do not interrupt unless you have to or the software glitched. This terminal session will also clear. To continue and approve this operation, press any key to continue.${RESET}"
    read -n 1 -s
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
else
    echo -e "${RED}You either typed no or typed something else. Letters and capitalization matters. This program will shut down now. Press any key to continue...${RESET}"
    read -n 1 -s
    exit 1
    fi
    if [ "$pacman" = true ]; then
        echo -e "${LIME}Pacman is present on this software. Updating${RESET}"
        if sudo pacman -Syu --noconfirm; then
            pacmaninstall=pass
        else
            pacmaninstall=fail
        fi
        echo -e "${LIME}Pacman update ended with status: ${pacmaninstall}.${RESET}"
    else
        echo "${LIME}Pacman is not installed on this software. Skipping${RESET}"
        pacmanexist=no
    fi
    if [ "$yay" = true ]; then
        echo "${LIME}Yay is present on this software. Updating${RESET}"
        if yay -Syu --noconfirm; then
            yayinstall=pass
        else
            yayinstall=fail
        fi
        echo "${LIME}Yay update ended with status: ${yayinstall}.${RESET}"
    else
        echo "${LIME}Yay is not installed on this software. Skipping${RESET}"
        yayexist=no
    fi
    if [ "$apt" = true ]; then
        echo "${LIME}APT is present on this software. Updating${RESET}"
        if sudo apt-get update -y; then
            apt1install=pass
            if sudo apt-get upgrade -y; then
                apt2install=pass
            else
                apt2install=fail
            fi
        else
            apt1install=fail
            apt2install=not_run
        fi
        echo "${LIME}APT update ended with status: ${apt1install} and ${apt2install} (this will be clarified in summary).${RESET}"
    else
        echo "${LIME}APT is not installed on this software. Skipping${RESET}"
        aptexist=no
    fi
    if [ "$dnf" = true ]; then
        echo "${LIME}Dnf is present on this software. Updating${RESET}"
        if sudo dnf upgrade -y; then
            dnfinstall=pass
        else
            dnfinstall=fail
        fi
        echo "${LIME}Dnf update ended with status: ${dnfinstall}.${RESET}"
    else
        echo "${LIME}Dnf is not installed on this software. Skipping${RESET}"
        dnfexist=no
    fi
    if [ "$flatpak" = true ]; then
        echo "${LIME}Flatpak is present on this software. Updating${RESET}"
        if sudo flatpak update -y; then
            flatpakinstall=pass
        else
            flatpakinstall=fail
        fi
        echo "${LIME}Flatpak update ended with status: ${flatpakinstall}.${RESET}"
    else
        echo "${LIME}Flatpak is not installed on this software. Skipping${RESET}"
        flatpakexist=no
    fi
    echo -e "${LIME}Printing summary...${RESET}"
    echo -e "${LIME}===SUMMARY===${RESET}"
    echo -e "${LIME}Segregated by:${RESET}"
    echo -e "${LIME}Exists?${RESET}"
    echo -e "${LIME}Succesful?${RESET}"
    echo -e "${LIME}Pacman:${RESET}"
    if [ "$pacmanexist" = no ]; then
        echo -e "${BLUE}No${RESET}"
    else
        echo -e "${LIME}Yes${RESET}"
        if [ "$pacmaninstall" = fail ]; then
        echo -e "${RED}Failed${RESET}"
        else
        echo -e "${LIME}Succesful${RESET}"
        fi
    fi
    echo -e "${LIME}Yay${RESET}"
    if [ "$yayexist" = no ]; then
        echo -e "${BLUE}No${RESET}"
    else
        echo -e "${LIME}Yes${RESET}"
        if [ "$yayinstall" = fail ]; then
        echo -e "${RED}Failed${RESET}"
        else
        echo -e "${LIME}Succesful${RESET}"
        fi
    fi
    echo -e "${LIME}APT${RESET}"
    if [ "$aptexist" = no ]; then
        echo -e "${BLUE}No${RESET}"
    else
        echo -e "${LIME}Yes${RESET}"
        if [ "$apt1install" = fail ]; then
        echo -e "${RED}Update: Failed${RESET}"
        else
        echo -e "${LIME}Update: Succesful${RESET}"
        fi
        if [ "$apt2install" = fail ]; then
        echo -e "${RED}Upgrade: Failed${RESET}"
        else
        if [ "$apt2install" = not_run ]; then
        echo -e "${BLUE}Upgrade: Not run (this may have occured because apt update failed).${RESET}"
        else
        echo -e "${LIME}Upgrade: Succesful${RESET}"
        fi
    fi
    fi
    echo -e "${LIME}Dnf${RESET}"
    if [ "$dnfexist" = no ]; then
        echo -e "${BLUE}No${RESET}"
    else
        echo -e "${LIME}Yes${RESET}"
        if [ "$dnfinstall" = fail ]; then
        echo -e "${RED}Failed${RESET}"
        else
        echo -e "${LIME}Succesful${RESET}"
        fi
    fi
    echo -e "${LIME}Flatpak${RESET}"
    if [ "$flatpakexist" = no ]; then
        echo -e "${BLUE}No${RESET}"
    else
        echo -e "${LIME}Yes${RESET}"
        if [ "$flatpakinstall" = fail ]; then
        echo -e "${RED}Failed${RESET}"
        else
        echo -e "${LIME}Succesful${RESET}"
        fi
    fi
    echo -e "${LIME}This program has finished! Press any key to exit...${RESET}"
    read -n 1 -s
    exit 0
fi
