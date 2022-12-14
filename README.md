# Carbon-Ptero

The only aim in Rust is to survive. To do this you will need to overcome struggles such as hunger, thirst and cold. Build a fire. Build a shelter. Kill animals for meat. Protect yourself from other players, and kill them for meat. Create alliances with other players and form a town. Do whatever it takes to survive.

Adds variables to install carbon, Restart to run install

The variable `CARBON` was added, default 1, set to 0 to Install a vanilla Rust server or 1 to install Carbon.

A drop down list `BUILD` was also added to give you the option of which Carbon build you want to run, default is Release.

## Minimum RAM warning

The server requires at least 4096MB to run properly.
This is mostly needed for the startup only, once it is running (depending on your world size) it should consume less.

## Server Ports

Default ports required to run the server are listed below.

| Port    | default |
|---------|---------|
| Game and Query | 28015 UDP |
| RCON | 28016 TCP |
| Rust+ | 28082 TCP |

I would also suggest that as some Pterodactyl installs do not show in the in game server list adding the additional argument of +server.queryport 28015 to your rust variables.

### Information about server updates can be found [here](https://steamdb.info/app/258550/depots/?branch=staging)

### Information about Carbon can be found [here](https://github.com/Carbon-Modding/Carbon.Core)
