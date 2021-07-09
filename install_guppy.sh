sudo apt-get update
sudo apt-get install wget lsb-release curl

BASE_URL=https://us.download.nvidia.com/tesla
DRIVER_VERSION=450.80.02
curl -fSsl -O $BASE_URL/$DRIVER_VERSION/NVIDIA-Linux-x86_64-$DRIVER_VERSION.run
sudo sh NVIDIA-Linux-x86_64-$DRIVER_VERSION.run

pkg-config` utility and the X.Org SDK/development package for your distribution and reinstall the driver.
export PLATFORM=$(lsb_release -cs)
wget -O- https://mirror.oxfordnanoportal.com/apt/ont-repo.pub | sudo apt-key add -
echo "deb http://mirror.oxfordnanoportal.com/apt ${PLATFORM}-stable non-free" | sudo tee /etc/apt/sources.list.d/nanoporetech.sources.list
sudo apt update
sudo apt install ont-guppy



