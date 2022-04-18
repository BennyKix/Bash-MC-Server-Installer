#!/bin/bash
echo "Select a server package:";
echo "1: Vanilla";
echo "2: Hyperspeed";
echo "3: Enhanced Vanilla";
read p;
echo "How much RAM, in megabytes, would you like to allow your server to use?";
read xmx;
sudo apt install zip unzip;
if [ $p = 1 ]
then
  mkdir vanilla;
  cd vanilla;
  wget https://dl.dropboxusercontent.com/s/9dfosfjhx6ed43j/eula.txt;
  wget https://launcher.mojang.com/v1/objects/c8f83c5655308435b3dcf03c06d9fe8740a77469/server.jar;
fi

if [ $p = 2 ]
then
  mkdir hyperspeed;
  cd hyperspeed;
  wget https://dl.dropboxusercontent.com/s/9dfosfjhx6ed43j/eula.txt;
  curl -OJ https://meta.fabricmc.net/v2/versions/loader/1.18.2/0.13.3/0.10.2/server/jar;
  mv fabric-server-mc.1.18.2-loader.0.13.3-launcher.0.10.2.jar server.jar;
  mkdir mods;
  cd mods;
  wget https://dl.dropboxusercontent.com/s/40j5zvzunf98drg/hyperserver2.zip;
  unzip hyperserver2.zip;
  rm hyperserver2.zip;
  echo "Install Village Spawnpoint? (Mod that, on world creation, sets the spawnpoint to the village closest to 0,0)[y/n]";
  read hsvs;
  if [ $hsvs = y ] || [$hsvs = Y]
  then
    wget https://dl.dropboxusercontent.com/s/eqh8yy0edtdnwr6/villagespawnpoint-fabric_1.18.x-1.8.jar;
    wget https://dl.dropboxusercontent.com/s/q1nqf3ozn1184p6/collective-fabric-1.18.x-4.26.jar;
  fi
  cd ..;
fi

if [ $p = 3 ]
then
  mkdir enhancedvanilla;
  cd enhancedvanilla;
  wget https://dl.dropboxusercontent.com/s/9dfosfjhx6ed43j/eula.txt;
  curl -OJ https://meta.fabricmc.net/v2/versions/loader/1.18.2/0.13.3/0.10.2/server/jar;
  mv fabric-server-mc.1.18.2-loader.0.13.3-launcher.0.10.2.jar server.jar;
  mkdir mods;
  cd mods;
  wget https://dl.dropboxusercontent.com/s/3938q2le02fanwb/enhancedvanillaserverpack.zip;
  unzip enhancedvanillaserverpack.zip;
  rm enhancedvanillaserverpack.zip;
  cd ..;
fi

mkdir world;
mkdir world/datapacks;
echo "Install Terralith? [y/n]";
read vtyn;
if [ $vtyn = y ] || [$vtyn = Y]
then
  cd world/datapacks;
  wget https://dl.dropboxusercontent.com/s/6itod6feig0mdfo/terralith-v2-2-1a.zip;
  cd ../..;
fi

echo "Install Better Villages? [y/n]";
read vvyn;
if [ $vvyn = y ] || [$vvyn = Y]
then
  cd world/datapacks;
  wget https://dl.dropboxusercontent.com/s/91lycz3xs7buo0z/Better-Villages.zip;
  cd ../..;
fi

echo "Install Lush Cave Upgrades? [y/n]";
read vlyn;
if [ $vlyn = y ] || [$vlyn = Y]
then
  cd world/datapacks;
  wget https://dl.dropboxusercontent.com/s/3d9qq4sxyak6sww/lush-cave-upgrades.zip;
  cd ../..;
fi

sudo ufw allow 25565;
if [[ $(command -v java) ]]; then
    echo "Java already installed, skipping that part.";
else
    echo "You haven't installed Java! I'm about to change that.";
    sudo add-apt-repository ppa:openjdk-r/ppa;
    sudo apt update;
    sudo apt install openjdk-17-jre-headless;
fi

if [ $p = 1 ]
then
    cd vanilla;
    echo "java -Xmx${xmx}M -jar server.jar nogui" > startserver.txt;
    cd ..;
    echo "All set! To run your server, CD to the server's folder (vanilla) and enter:";
    echo "java -Xmx${xmx}M -jar server.jar nogui";
    echo "If you forget that, don't worry! I've saved it to startserver.txt in your server folder :)";
    echo "Your server IP: ";
    curl https://ipinfo.io/ip;
    echo " ";
fi

if [ $p = 2 ]
then
    cd hyperspeed;
    echo "java -Xmx${xmx}M -jar server.jar nogui" > startserver.txt;
    cd ..;
    echo "All set! To run your server, CD to the server's folder (hyperspeed) and enter:";
    echo "java -Xmx${xmx}M -jar server.jar nogui";
    echo "If you forget that, don't worry! I've saved it to startserver.txt in your server folder :)";
    echo "Your server IP: ";
    curl https://ipinfo.io/ip;
    echo " ";
fi

if [ $p = 3 ]
then
    cd enhancedvanilla;
    echo "java -Xmx${xmx}M -jar server.jar nogui" > startserver.txt;
    cd ..;
    echo "All set! To run your server, CD to the server's folder (enhancedvanilla) and enter:";
    echo "java -Xmx${xmx}M -jar server.jar nogui";
    echo "If you forget that, don't worry! I've saved it to startserver.txt in your server folder :)";
    echo "Your server IP: ";
    curl https://ipinfo.io/ip;
    echo " ";
fi
