#!/bin/bash
#!/bin/bash

helpFunction()
{
   echo ""
   echo "Usage: $0 -p path -n name -i icon"
   echo "-p Path of the AppImage file"
   echo "-n Name of the desktop entry"
   echo "-i Icon of the AppImage file"
   exit 1 # Exit script after printing help
}

while getopts "p:n:i:" opt
do
   case "$opt" in
      p ) path="$OPTARG" ;;
      n ) name="$OPTARG" ;;
      i ) icon="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$path" ] || [ -z "$name" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

mkdir /home/$SUDO_USER/AppImages/
mkdir /home/$SUDO_USER/AppImages/icons/

cp $path /home/$SUDO_USER/AppImages/$name.AppImage
cp $icon /home/$SUDO_USER/AppImages/icons/$name.png

file_location="/usr/share/applications/$name.desktop"
if [ -e $file_location ]; then
  echo "File $name.desktop already exists!"
else
  cat > $file_location << EOF
[Desktop Entry]
Name=$name
Exec=/home/$SUDO_USER/AppImages/$name.AppImage
Icon=/home/$SUDO_USER/AppImages/icons/$name.png
Type=Application
EOF
fi
su $SUDO_USER -c "cd /$home/$SUDO_USER/"
