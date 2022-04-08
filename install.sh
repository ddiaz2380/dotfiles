#!/bin/bash

green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"

function banner(){

	clear

	echo -e "${red}"

	echo " █████╗ ██╗   ██╗████████╗ ██████╗  █████╗ ██╗    ██╗███████╗███████╗ ██████╗ ███╗   ███╗███████╗"
	echo "██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗██╔══██╗██║    ██║██╔════╝██╔════╝██╔═══██╗████╗ ████║██╔════╝"
	echo "███████║██║   ██║   ██║   ██║   ██║███████║██║ █╗ ██║█████╗  ███████╗██║   ██║██╔████╔██║█████╗  "
	echo "██╔══██║██║   ██║   ██║   ██║   ██║██╔══██║██║███╗██║██╔══╝  ╚════██║██║   ██║██║╚██╔╝██║██╔══╝  "
	echo "██║  ██║╚██████╔╝   ██║   ╚██████╔╝██║  ██║╚███╔███╔╝███████╗███████║╚██████╔╝██║ ╚═╝ ██║███████╗"
	echo "╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ ╚═╝  ╚═╝ ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝"

}


function dependencias(){

echo -e "${red}[!] ${yellow}Instalando Dependencias..."
echo -e "${end}"

sudo pacman -S git --noconfirm

git clone https://aur.archlinux.org/paru-bin.git
chmod 777 paru-bin
cd paru-bin || exit
makepkg -si --noconfirm
cd ..
rm -rf paru-bin/

paru -S picom-ibhagwan-git todo-bin alacritty rofi todo-bin acpi acpid \
wireless_tools jq inotify-tools polkit-gnome xdotool xclip maim scrub bat lsd \
brightnessctl alsa-utils alsa-tools pulseaudio lm_sensors mdcat \
mpd mpc mpdris2 ncmpcpp playerctl zsh-autosuggestions zsh-syntax-highlighting zsh-sudo-git --needed --noconfirm 

mkdir /home/$USER/.todo/

systemctl --user enable mpd.service
systemctl --user start mpd.service
sudo systemctl enable acpid.service
sudo systemctl start acpid.service

echo -e "${green}[!] ${blue}Dependencias Instaladas."
clear
echo -e "${end}"

}

function build(){

echo -e "${red}[!] ${yellow}Instalando Awesome..."
echo -e "${end}"

paru -S awesome-git --needed --noconfirm

echo -e "${green}[!] ${blue}Awesome Instalado."
clear
echo -e "${end}"
}

function awesome(){

echo -e "${red}[!] ${yellow}Instalando witgets de Awesome..."
echo -e "${end}"

paru -S ttf-material-design-icons nerd-fonts-complete --needed --noconfirm

unzip files/icoonmon.zip .; sudo mv ./*.ttf /usr/share/fonts

echo -e "${green}[!] ${blue}Los temas de widgets se han instalado."
clear
echo -e "${end}"
}

function themes(){

echo -e "${red}[!] ${yellow}Instalando temas de Awesome..."
echo -e "${end}"
cp -r config/* ~/.config
mkdir ~/.local/bin/
cp -r bin/* ~/.local/bin/
cp -r misc/. ~/

echo -e "${green}[!] ${blue}Temas Instalados."
clear
echo -e "${end}"
}

function tools(){

echo -e "${red}[!] ${yellow}Instalando funciones extra..."
echo -e "${end}"


echo -e "${green}[!] ${blue}Functiones extra Instaladas."
clear
echo -e "${end}"

echo -e "${green} [!] ʕ•́ᴥ•̀ʔ Entorno instalado!!"

}


function menu(){

	banner

	echo -e "${blue}"
	sleep 0.25
	echo
	echo "1 -> Instalar dependencias"
	sleep 0.25
	echo
	echo "2 -> Instalar Awesome"
	sleep 0.25
	echo
	echo "3 -> Instalar widgets de Awesome"
	sleep 0.25
	echo
	echo "4 -> Instalar tema de Awesome"
	sleep 0.25
	echo
	echo "5 -> Instalar elementos adicionales: rofi, caja, firefox..."
	sleep 0.25
	echo
	echo "6 -> Instalar todo"
	sleep 0.25
	echo
	echo "7 -> Salir"
	sleep 0.25
	echo -e "${end}"
	echo
	read -rp "--> " comando

	if [ "$comando" == "1" ]; then
			dependencias
		fi

        if [ "$comando" == "2" ]; then
                build
                fi

        if [ "$comando" == "3" ]; then
                awesome
                fi

        if [ "$comando" == "4" ]; then
                themes
                fi

        if [ "$comando" == "5" ]; then
                tools
                fi

        if [ "$comando" == "6" ]; then
                dependencias
				build
				awesome
				themes
				tools
                fi
}

if [[ "$1" == "-p" ]];then
  echo "[!] Cuando sale la academia, Y la Silla!?!?"
  exit 0
fi

if [ "$(id -u)" == "0" ]; then
	echo -e "\n${red}[!] No hay que ser root para ejecutar la herramienta${end}"
	echo
	exit 1
else
	menu
fi

