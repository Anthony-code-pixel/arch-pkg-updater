# arch-pkg-updater
Version v1.0 (created 25th of October 2026)
My first coding project overall and on GitHub! (except for some minor Python print and HTML). It's not going to change your world, but it's my first project. It uses bash, and it's made to make your life a tiny bit easier by updating your packages from pacman, AUR and flatpak. :)
To use this program, you must have pacman enabled and present on your computer, AUR (yay) and flatpak.
I have used a tiny help of AI with terminal color setting, echo (to turn off echo) and with answer collectors, however the AI did not give me copy paste code, nor did vibe code the entire project. I did all the scripting. :)
I also used the help of AI when making Arch Updater.desktop. Again, the AI did not give me copy paste code, it didn't vibe code anything and the entire project with scripting was still done fully by me. I have learned something during my first project which I'll remember for the future without the need to use AI. :)
I have no issues with you changing the code up a little bit. :)
Enjoy! :)
PS. next update will be checking if pacman, yay and flatpak are present in PATH; if not then the installer will skip those. If present, the installation will proceed further. With the help of this, the program will be able to work on various other machines, checking for presence of APT, dnf, etc.

Update: Version v1.1 (updated 25th of October 2026)
I have learned multiple new things, so now the software checks what package managers out of 5 you have: Flatpak, Pacman, Yay, Dnf, APT. If the software detects any of these present on your software, it sends an update command to those. This means you can now use this software on multiple distros, no longer limited to Arch! However, I am still keeping its name as a symbol of originality. :)
Enjoy! :)

Slight update (also v1.1, added on the 25th of October 2026)
I added an installer that can help you properly install this script. See the source code for ArchUpdaterInstaller.bash, on the top you'll find instructions on how to use the installer. To download the zip file required for the installer, go to the main branch, click Code, and click Download ZIP. You can download the installer individually, or unzip the zipped file (which kind of breaks the point of the installer, it's recommended you install first the ZIP file, and then click ArchUpdaterInstaller.bash, then hit the Download icon. If you want, you can still manually seat the Arch Updater.bash in your home folder, and optionally, the Arch Updater.desktop in your desktop or anywhere you want. Just remember about adding executable permissions for Arch Updater.bash in terminal (chmod +x 'Arch Updater.bash').
Enjoy! :)

Bug patch (26th of October 2026)
The installer if used unzip would extract to a wrongfully named folder, causing the installer to crash. It has been now fixed by me.
There is also a known bug on Debian (didn't confirm it yet on other distros), if you right click on Arch Updater.bash and click Run as program, the color codes may break and make the updater unusable. If this happens to you, just run the program in your terminal: "./'Arch Updater.bash'". I am still thinking of fixing this. :)
