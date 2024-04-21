## AltServerd (AltServer Docker)
Docker & docker-compose solutions for the combo [AltServer](https://github.com/NyaMisty/AltServer-Linux) and [netmuxd](https://github.com/jkcoxson/netmuxd). It provides an environment to build **netmuxd** and also an image/docker-compose to run everything in its own environment with all the dependencies met.

### Usage
```bash
# To enter in "config" mode to pair a device with "usbmuxd"
# Will run bash inside prepared environment
docker-compose run config

# To bring up AltServer
# Recomendation: First refresh via USB
docker-compose up -d daemon

# To build netmuxd 
# Version: commit/315131a271961721189dd228bddfa863ba6376d2
docker-compose run netmuxd

# To build altserver 
# Version: tags/v0.0.5
docker-compose run altserver
```
> A `bin` folder will be created upon any build, holding the just built executable.

### DietPi Environment Setup
```bash
# docker, docker-compose, git, avahi-daemon
dietpi-software install 162 134 17 152
```

### Raspberry PI OS Environment Setup
```bash
# Install docker
curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh
sudo usermod -aG docker $USER # Requires restart/logout for changes to take effect
sudo systemctl enable --now docker
sudo systemctl start docker

# Install git, docker-compose, avahi-daemon
sudo apt update; sudo apt install -y git docker-compose avahi-daemon
```
### powenn/AltServer-Linux-ShellScript
You can use this repo with **[powenn/AltServer-Linux-ShellScript](https://github.com/powenn/AltServer-Linux-ShellScript)**. **@powenn** has implemented wifi refresh for *x86_64* but not for other platforms as [netmuxd](https://github.com/jkcoxson/netmuxd/releases) is not built by **@jkcoxson** for all the platforms. Using this repo and its dockerfile (see above) you can build **netmuxd** for your environment and use 
[x64-run.sh](https://raw.githubusercontent.com/powenn/AltServer-Linux-ShellScript/main/x64-run.sh) script from @powenn repo to have wifi refresh.

## Credits
- https://github.com/NyaMisty/AltServer-Linux @NyaMisty
- https://github.com/Dadoum/Provision @Dadoum
- https://github.com/jkcoxson/netmuxd @jkcoxson





## Darderik adds
- Can avahi-daemon be executed outside the docker? (systemctl doesn't work thus starting avahi on startup it's not possible) Yes it can. I'm running avahi-daemon outside docker on the main host
- Usbmuxd and netmuxd can coexists? On ARM64 they seem to work
- Run daemon and let it build, then plug your phone and authorize (usbmuxd and netmuxd running together ). Remove your device after and launch docker again.
- Wipe your /var/lib/lockdown if everything is working shit (Usbmuxd keys are in this folder, heartbeat error could be related to screwed plists)
- on a Pine64 the usbmuxd docker image + altserver + netmuxd spent 5 hours to compile everything for the first time (got sick of prebuilt packages in repos)
- config is no longer needed

