# If a text editor opened and you're seeing this, it's most likely you haven't given this script executable permissions.
# To run this script, prepare your "arch-pkg-updater-main.zip" and this installer file in your **home Downloads folder**. If you run it in another folder, it might corrupt and not work properly, leaving a mess on your computer.
# Open terminal and cd into your Downloads folder. You may also paste the below command (paste it without the hashtag #)
# cd && cd Downloads && chmod +x ArchUpdaterInstaller.bash && ./ArchUpdaterInstaller.bash
# Follow the instructions on screen
# Make sure to read README.md!
# Enjoy! :)

echo "Welcome to Arch Updater Installer!"
if [ "$(id -u)" -eq 0 ]; then
echo "You're root. Run this installer as non-root. Stopping."
exit 1
else
echo "You're non root. The installer can proceed normally."
fi
echo "This installer will help you move the files where they should be."
read -p "Do you want to proceed? Warning, if you have a file in your home Downloads folder named the same as "arch-pkg-updater-main.zip", it will be wrongfully transferred. extracted and deleted. Your downloaded "arch-pkg-updater-main.zip" must be in your home Downloads folder, or else the installer will fail. Type "y" for yes, and "n" for no." answer
if [ "$answer" == "y" ]; then
further=true
else
further=false
fi
if [ "$further" = false ]; then
echo "Cannot continue further. Stopping."
exit 1
else
echo "Agreed to continue. Starting setup."
fi
if [ -f "/home/${USER}/Downloads/arch-pkg-updater-main.zip" ]; then
echo "Folder exists."
folder=true
else
echo "Folder doesn't exist. Cannot continue further. Stopping."
exit 1
fi
if [ "$folder" = true ]; then
echo "Checking if supported programs like Ark or unzip are installed."
if command -v ark &> /dev/null; then
echo "Found Ark. Attempting to depack folder."
ark -b -o /home/${USER}/Downloads/arch-pkg-updater-main-unarchived /home/${USER}/Downloads/arch-pkg-updater-main.zip
else
if command -v unzip &> /dev/null; then
echo "Found unzip. Attempting to unzip folder."
unzip /home/${USER}/Downloads/arch-pkg-updater-main.zip -d /home/${USER}/Downloads/arch-pkg-updater-main-unarchived
else
echo "No supported program (Ark or unzip) found. Terminating progress."
exit 1
fi
fi
fi
if [ -d "/home/${USER}/Downloads/arch-pkg-updater-main" ]; then
echo "Decompression went succesfully! Moving files"
mv "/home/${USER}/Downloads/arch-pkg-updater-main/Arch Updater.bash" /home/${USER}/
mv "/home/${USER}/Downloads/arch-pkg-updater-main/Arch Updater.desktop" /home/${USER}/Desktop/
else
echo "Decompression failed. Stopping"
exit 1
fi
if [ -f "/home/${USER}/Arch Updater.bash" ]; then
archhome=true
chmod +x "/home/${USER}/Arch Updater.bash"
echo "Issued permissions chmod +x for Arch Updater.bash"
echo "Arch Updater is in home directory, checking desktop"
else
archhome=false
echo "Arch Updater is not in home directory. This is important, as Arch Updater depends on it. Exiting with error."
exit 1
fi
if [ -f "/home/${USER}/Desktop/Arch Updater.desktop" ]; then
archdesktop=true
echo "Arch Updater is in desktop"
else
archdesktop=false
echo "Arch Updater is not in desktop. This matters less than Arch Updater not being in home directory, because you can run Arch Updater from terminal or make a new file that runs Arch Updater."
fi
echo "===DOWNLOAD SUMMARY==="
if [ "$archhome" = false ]; then
echo "Arch Updater in home is not present (critical)"
else
echo "Arch Updater is in home"
fi
if [ "$archdesktop" = false ]; then
echo "Arch Updater is not in Desktop. This is not critical as you can create a new shortcut or run Arch Updater from terminal."
else
echo "Arch Updater is in desktop."
fi
echo "===SETUP COMPLETED, CLOSING WITH CODE 0==="
exit
