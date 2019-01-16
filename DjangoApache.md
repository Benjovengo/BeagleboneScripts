#Django Apache Webserver Setup

## Introduction

Tutorial on how to setup a Django webserver using Apache on a Beaglebone Black.

The Beaglebone Black is an interesting choice because it runs a Debian distribution, not a Debian-like distribution as a Raspberry Pi. So migrating from a Beaglebone Black to a more robust server is hoped to be smoother.

## Software Updates and General Software Installation

First of all, update and upgrade all packages.

`sudo apt-get update`
`sudo apt-get upgrade`

Or, as a single command line

`sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade`

### Install Python

If not yet installed, install Python ([Installing Python 3 on Linux](https://docs.python-guide.org/starting/install3/linux/))

`sudo apt-get install python3.6`
>After updating system packages (`sudo apt-get update`).

If you’re using another version of Ubuntu (e.g. the latest LTS release), we recommend using the deadsnakes PPA to install Python 3.6:

> `sudo apt-get install software-properties-common`
> `sudo add-apt-repository ppa:deadsnakes/ppa`
> `sudo apt-get update`
> `sudo apt-get install python3.6`

### Setuptools and Pip

Python 2.7.9 and later (on the python2 series), and Python 3.4 and later include pip by default. To see if **pip** is installed, open a command prompt and run:

`python3`
>this will launch the Python 3 interpreter.

`command -v pip`

Note that on some Linux distributions including Ubuntu and Fedora the *pip command is meant for Python 2*, while the ***pip3** command is meant for Python 3*. Hence, to see if **pip3** is installed, open a command prompt and run:

`command -v pip3`


## Specific Packages Installation

This section covers installing **Django**, **Apache**, **Python Setup Tools** and **Mod WSGI**.

#### Terminal Commands
To install the packages, open a terminal window and run: (**REVIEW COMMANDS**)
> `sudo pip install Django==1.6`
> `sudo apt-get install apache2`
> `sudo apt-get install python-setuptools`
> `sudo apt-get install libapache2-mod-wsgi`

Optional
> `sudo apt-get install tree` (tree structure of folders)

*The tutorial uses Django 1.6.*

After all the installation, check if the folder */etc/apache2/* was created.

## Django Application

Create a simple Django application.
1. Go to folder */var/www/*: `cd /var/www`. There should be a file called *index.html* in that folder.
2. Start Django project: `sudo django-admin.py startproject mysite`
> The project name is *mysite*
> May need to use **sudo** because of the permissions.
> This creates a folder called *mysite*

**Folder Structure**
On */var/www*, run `tree .` to see the folder structure.

#### Run This Project

Go to */var/www/mysite*, either by
> `cd /var/www/mysite`
or
> `cd mysite` (if already in */var/www/*).

Run *manage.py* script.
> `python manage.py runserver`

Copy the address on the terminal console and paste in web browser.
> A page should open saying **It worked!** (on the next line it says something like "Congratulations on your first Django-powered page.")

**Stop the server**
> Press `CONTROL-C` in the terminal.

## Apache Configuration

There should be a folder called *apache2* in */etc* directory. Navigate there running `cd /etc/apache2` and list the contents of it by typing `ls`.

#### apache2.conf

Edit */etc/apache2/apache2.conf* file
> `cd /etc/apache2`
> `nano apache2.conf` (may need to be **su** or use `sudo` at the beginning)


https://www.youtube.com/watch?v=VNBpdT0N8hw
6:52



# Install FTP Server on the Beaglebone Black

## Part 1: FTP Server

### Step 1: Update the Repositories

Type `sudo apt-get update`

### Step 2: Install vsftpd

Type `sudo apt-get install vsftpd`

### Step 3: Configure vsftpd

Edit the configuration file */etc/vsftpd.conf*.
Type: `sudo nano /etc/vsftpd.conf`

**Important Configurations**
Make sure to have this on */etc/vsftpd.conf*:

* anonymous_enable=YES
* local_enable=YES
* write_enable=YES

**Save and exit *nano*.**

### Step 4: Restart vsftpd Service

Type `sudo service vsftpd restart`

## Part 2: FTP Client

Now that the FTP server is installed, configured and running, let's use it.

### Step 1: Get the IP Address of the Host Machine

On the host machine, type `ifconfig`


### Step 2: Filezilla - Connect to the FTP Server

Setup **Filezilla** on the client machine.
> **HOST**: 192.168.0.6 (IP address shown by ìfconfig` on the host machine).
> **Username**: debian
> **Password**: temppwd (password for the user *debian*)
> **Port**: blank (default: 21)

And click on `Quick Connect`.
