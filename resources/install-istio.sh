#¡/bin/bash
set -e
echo "In order to install istio , you need to have istioctl tool "
read -p "Do you have istioctl installed(Y/N):" installed

echo "input is $installed"

if [ $installed == "N" ] || [ $installed == "n" ]; then
    echo "Please install istioctl and try again"
    exit -1
fi

echo "We are about to install the default profile"

istioctl install
