#Beaglebone Black Scripts - README.md

## Introduction

Scripts for the Beaglebone Black to act as a simple **webserver**.

It consists of  an **APACHE** webserver over **NO-IP.com** static IP to be accessed outside localhost domain.

All the code and the required links will be provided on this document. Bash scripts will be descripted and fully commented. Sometimes the order in which the commands must be runned is crucial to its proper functioning.

## Beaglebone Black Update

#### Pre-requisites

*	Beaglebone Black
*	SD card (4GB)


Before start, download the latest release of Debian image distribution from the **Getting Started** page of the official Beaglebone Black project:

[beagleboard.org/black](https://beagleboard.org/black) 

or, directly accessing the **Getting Started** from

[Getting Started](http://beagleboard.org/getting-started) 

Follow all the instructuons from the section **Update board with latest software**.


#### Commands and Operations (Steb-by-step)

List of commands and operations to update Beaglebone Black software.


**Get the Latest Images** - *Step 0* from the Beaglebone website
1. Enter [Getting Started](http://beagleboard.org/getting-started) and Download the lastest Debian image from [beagleboard.org/latest-images](https://beagleboard.org/latest-images).
2. Download and install [Etcher](https://etcher.io/).
3. Use Etcher to write the image to your SD card.
4. Boot your board off of the SD card: *insert SD card into your (powered-down) board, **hold down** the USER/BOOT button (if using Beaglebone Black) and apply power.*

> **More Information**
> - The USER/HOME button is located at the top side of the board, on the direction of the SD card slot.
> - If using BeagleBone Black and desire to write the image to your on-board eMMC, you'll need to follow the instructions at [Flashing_eMMC](http://elinux.org/Beagleboard:BeagleBoneBlack_Debian#Flashing_eMMC). When the flashing is complete, all 4 USRx LEDs will be steady on or off.

Power on and wait until the LEDs on the direction of the USB type-B connector (on the other side of the circuit board ) stop blinking randomly. It takes several minutes. **The latest Debian flasher images automatically power down the board upon completion.**

**First Connection to the Beaglebone Black**
This connection is performed **before** flashing the eMMC.

## USB Internet Sharing

**Browsing the Beaglebone Black**
The Beaglebone Black will have an IP address, so using **Chrome** or **Firefox**  connect to the URL:
[http://192.168.7.2](http://192.168.7.2) or
[http://192.168.6.2](http://192.168.6.2) 

*Check if there is a connection between the PC and the Beaglebone Black. If there is, one of the addresses above will point to a HTML page hosted on the Beaglebone Black itself.*

*It is possible to ping those addresses to check for the connectivity.*

**SSH on Mac and Linux**
If you are using a Mac or Linux, then open a terminal window and type the following command:
`ssh 192.168.7.2 -l debian`

and use the password **temppwd** (password = temppwd).

To erase the known device, type
`ssh-keygen -f "/home/virus/.ssh/known_hosts" -R "192.168.7.2"`

#### Connecting the BeagleBone Black to the Internet via USB Port
Direct any data destined for the internet through a gateway
1. Type the following commands in the shell prompt on the BeagleBone Black:
	`sudo ifconfig usb0 192.168.7.2`
	`sudo route add default gw 192.168.7.1`
	**After running the next script on the host machine:** edit the file */etc/resolv.conf* (`sudo nano /etc/resolv.conf`) and add the line `nameserver 8.8.8.8` to it.
2. In the linux console of host system type:
>`sudo su`
>`#wlan0 is my internet facing interface, eth5 is the BeagleBone USB connection`
>`ifconfig eth2 192.168.7.1`
>`iptables --table nat --append POSTROUTING --out-interface wlan0 -j MASQUERADE`
>`iptables --append FORWARD --in-interface eth5 -j ACCEPT`
>`echo 1 > /proc/sys/net/ipv4/ip_forward`

Commands found on the script
`/home/virus/Dropbox/PayApp/Beaglebone Black/BeagleboneScripts\HostScript.sh`

*The network interface (**eth2**) may change. Use `ifconfig` in host computer to determine the Beaglebone Black interface. See the third line of the script above (ifconfig **eth2** 192.168.7.1**).*

After running the script on the host machine, type the following in Beaglebone Black terminal:
`sudo nano /etc/resolv.conf`
and add to it the line
`nameserver 8.8.8.8`

**Test the Internet on the Beaglebone Black**
`ping www.google.com`



## First Time Only - Flashing eMMC

This section presents the required operations to replace the contents of the built-in memory of the Beaglebone Black with newer version of the Debian distribution image. *The image must be written on the SD card following the steps described on the section **Beaglebone Black Update**.*

####Flashing eMMC
The following structions are performed on the Beaglebone Black
1. At the command terminal, type `sudo nano /boot/uEnv.txt`
2. In /boot/uEnv.txt, uncomment the second line of
**\#\#enable BBB: eMMC Flasher:
 cmdline=init=/opt/scripts/tools/eMMC/init-eMMC-flasher-v3.sh**
3. Optional, update Flasher Scripts:
`cd /opt/scripts/`
`git pull`

**Boot again from the SD Card!**
Boot your board off of the SD card: *insert SD card into your (powered-down) board, **hold down** the USER/BOOT button (if using Beaglebone Black) and apply power.*

After a while, the leds will start to blink in sequence. This indicates that the memory of the Beaglebone Black is being replaced by the contents of the SD card. The Beaglebone Black will shutdown automatically when this operation terminates. **This takes about 10-15 minutes!**
4. Remove the SD card before powering on.


## Software Updates
Once the Beaglebone Black software is updated and upgraded to the latest versions (apt-get update, apt-get upgrade):
`sudo apt-get update && sudo apt-get -y upgrade`

**This may take a while.**

## Graphical Interface

GUI connection

# Ethernet Connection

## Introduction

Up to now, the connection wes estabilished via USB. In order for the Beablebone Black to be connected to the internet independently from the host machine, the Beaglebone Black will be powered by a **DC Adapter** and the internet will be provided by an **ethernet cable**.


## Powering from DC Adapter

The DC adapter must supply, at least, **2A** for proper functioning.

##Using Ethernet Cable to Connect

The configuration is performed using the USB connection to a host machine.

#### Router's Subnet (USB connected)

**Terminal on the host machine**
Type `ifconfig` to show the current network configuration of the host machine. It is important to note that this host machine *must be* connected to the *same router* which the Beaglebone Black will be connected to.

The host machine is connected via WI-FI, but **also connected via ethernet cable** (the same that is going to be connected to the Beaaglebone Black later on).

On connections starting with **en** (en0, en1, etc). These connections must have IP addresses starting with
**192.168.1.X** - this is a *local IP address*
>An example of the corresponding line is
*inet 192.168.0.138 netmask 0xffffff00 broadcast 192.168.1.255*


You will be using X between 2-255 so that no other computer in the network would be using that.

#### Static IP for the Beaglebone Black
**Log into the Beaglebone Black**
Edit the file */etc/network/interfaces*. Type the command
`sudo nano /etc/network/interfaces`
>**eth0** is the interface to be configured

Add the following lines
`auto eth0`
`iface eth0 inet static`
	`address 192.168.0.138`
	`netmask 255.255.255.0`
	`gateway 192.168.1.1`

(or add the first line right above the line *iface eth0 inet static*)

>If using Debian 8 (Jesse) then you have to remove *connman* package before the */etc/network/interfaces* file settings can take effect.
>Run command: `sudo apt-get remove connman`
>before rebooting the Beaglebone Black.

####Using Ethernet Cable and External Power Supply
**Reboot** the Beablebone Black in order for the changes in network interfaces to take effect. **eth0** interface for the physical eternet port should be configured with the IP address specified on the */etc/network/interfaces* file.

####Connect to the Beaglebone Black via SSH

Use the same address as defined in */etc/network/interfaces* on the Beaglebone Black (*address 192.168.0.138*).

`ssh 192.168.0.138 -l debian`


# No-IP Configuration

# Misc Commands
Tested temporary commands.

####Root User (su)
`sudo su`
No password needed.

>Type `exit` to return to normal user.

# Temp Commands

####Network-Manager start at boot (MAY NEED THIS)
`systemctl enable NetworkManager`

####Shutdown Command
`sudo shutdown -h now`
