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

# Release,Nightly,Beta
if [ -f CARBON_FLAG ] || [ "${CARBON}" = 1 ]; then
    echo "Updating Carbon..."
    if [ -f BUILD_FLAG ] || [ "${BUILD}" = "Develop" ]; then 
        echo "Downloading Develop Build..."
        curl -sSL "https://github.com/CarbonCommunity/Carbon.Core/releases/download/develop_build/Carbon.DebugUnix.tar.gz"> Carbon.tar.gz
    elif [ -f BUILD_FLAG ] || [ "${BUILD}" = "Production" ]; then
        echo "Downloading Production Build..."
        curl -sSL "https://github.com/CarbonCommunity/Carbon.Core/releases/download/production_build/Carbon.ReleaseUnix.tar.gz" > Carbon.zip
    elif [ -f BUILD_FLAG ] || [ "${BUILD}" = "Staging" ]; then
        echo "Downloading Staging Build..."
        curl -sSL "https://github.com/CarbonCommunity/Carbon.Core/releases/download/staging_build/Carbon.DebugUnix.tar.gz" > Carbon.zip
    fi
    tar -xvf Carbon.tar.gz
    rm Carbon.tar.gz
    echo "Patching Rust systems with Carbon..."
    cmod +x carbon/tools/environment.sh
    sh ./carbon/tools/environment.sh
    cmod +x carbon/tools/environment.sh
    echo "Done Patching Rust!"
fi

curl -LJO "https://raw.githubusercontent.com/jondpugh/Carbon-Ptero/main/run.sh"
chmod +x ./run.sh


# Fix for Rust not starting
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(pwd)

# Run the Server
node /wrapper.js "${MODIFIED_STARTUP}"
