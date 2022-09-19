#!/bin/bash
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $(NF);exit}'`

# Update Rust Server
./steamcmd/steamcmd.sh +force_install_dir /home/container +login anonymous +app_update 258550 +quit

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Install Carbon 
if [ -f CARBON_FLAG ] || [ "${CARBON}" = 1 ]; then
    echo "Updating Carbon..."
    curl -sSL "https://github.com/Carbon-Modding/Carbon.Core/releases/latest/download/Carbon.Patch-Unix.zip" > Carbon.zip
    unzip -o -q Carbon.zip
    rm Carbon.zip
    echo "Patching Rust systems with Carbon..."
    chmod +x ./carbon_prepatch.sh
    sh ./carbon_prepatch.sh
    echo "Done Patching Rust!"
fi

curl -sSL "https://raw.githubusercontent.com/jondpugh/Carbon-Ptero/main/run.sh"
chmod +x ./run.sh


# Fix for Rust not starting
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(pwd)

# Run the Server
node /wrapper.js "${MODIFIED_STARTUP}"
