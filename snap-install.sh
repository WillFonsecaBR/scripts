PROGRAMAS=("Beekeeper-studio" 
            "disk-space-saver" 
            "kturtle" 
            "krita" 
            "inkscape" 
            "red-app"  
            "audacity"  
            "skype")

for item in $PROGRAMAS
do
  sudo snap install $item
done
