#!/bin/bash

# This is script for installation Defold for linux systems.
# 1. Downloading Defold-x86_64-linux.tar.gz from GitHub Releases.
# 2. Extract the archive to $HOME/.local/share/Defold/
# 3. Creating a .desktop file in the $HOME/.local/share/applications/


# Variables
share="$HOME/.local/share"	; # - main directory
who=`whoami` ; # - username

OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
WARN="$(tput setaf 5)[WARN]$(tput sgr0)"


# MESSAGE AND CHOICE
	printf "\nHi. This is install script made for installing or not-fully reinstalling the Defold game engine with .desktop file (Shortcut)! \n \n"

	read -p "$(tput setaf 6)Do you want to start? [y/n]: $(tput sgr0)" proceed
	printf "\n%.0s" {1..2}
# CHECK ANSWER..
if [ "$proceed" != "y" ]; then
	echo "Installation aborted."
	printf "\n%.0s" {1..2}
	exit 1
fi


# MOVING us TO $HOME/.local/share/, THEN DOWNLOADING THE ARCHIVE
	printf "\n$(tput setaf 2)[ Starting installation ]$(tput sgr0) \n \n"

cd $share ;
rm -rf $share/Defold-x86_64-linux.tar.gz && wget https://github.com/Defold/defold/releases/download/1.9.6/Defold-x86_64-linux.tar.gz || if [ -a ]; then echo "$ERROR maybe wget just didn't installed" ; exit 1; fi;
rm -rf $share/Defold/
	
# EXTRACTing the ARCHIVE, AND ALSO DELETing an USED ARCHIVE
if [ -e $share/Defold-x86_64-linux.tar.gz ]; then	
	printf "\n$(tput setaf 3)[[ Extract the archive ]]$(tput sgr0)\n"	&& tar -xvf Defold-x86_64-linux.tar.gz
	printf "\n$(tput setaf 3)[[ Delete an used archive ]]$(tput sgr0)\n"	&& rm -rf Defold-x86_64-linux.tar.gz
else
	echo "$ERROR Archive doesn't exist. Maybe the archive is have removed."
fi

# CREATING a Defold.desktop FILE IN THE $HOME/.local/share/applications/
	printf "\n$(tput setaf 3)\n[[ Creating a desktop file ]]$(tput sgr0)\n" 

rm -rf $share/applications/Defold.desktop

echo "[Desktop Entry]
Type=Application
Terminal=false
Exec=env "$share/Defold/Defold"
Name=Defold
Path=$share/Defold/
Icon=$share/Defold/logo_blue.png
Categories=Development; " >> $share/applications/Defold.desktop ;


# MAKE A FILE EXECUTABLE:
chmod +x $share/applications/Defold.desktop ;


	printf "\n$(tput setaf 2)[[ Done ]]$(tput sgr0)\n"
