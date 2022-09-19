#!/bin/sh

chmod +x carbon/tools/NStrip

./carbon/tools/NStrip -p -cg --keep-resources -n --unity-non-serialized ./RustDedicated_Data/Managed/Assembly-CSharp.dll ./RustDedicated_Data/Managed/Assembly-CSharp.dll

./RustDedicated -batchmode +server.port $1 +server.identity "rust" +rcon.port $2 +rcon.web true +server.hostname "${3}" +server.level "${4}" +server.description "${5}" +server.url ${6} +server.headerimage ${7} +server.logoimage $8 +server.maxplayers $9 +rcon.password ${10} +server.saveinterval ${11} +app.port ${12} $( [ -z ${16} ] && printf %s "+server.worldsize \"${13}\" +server.seed \"${14}\"" || printf %s "+server.levelurl " ) ${15}
