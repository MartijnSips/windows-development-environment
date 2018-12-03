# Windows Development environment (based on a cloud box)

Powered by [![Virtualbox](https://raw.githubusercontent.com/MartijnSips/ubuntu-development-environment/develop/Logos/virtualbox.png "Virtualbox")](http://www.virtualbox.org)
and [![Vagrant](https://raw.githubusercontent.com/MartijnSips/ubuntu-development-environment/develop/Logos/vagrant.png "Vagrant" )](http://www.vagrantup.com)

## Purpose

The purpose of these scripts are to easily create an Windows development environment which you can simply roll out multiple times and get the same image. Ready to start developing your projects.

These scripts will create an Windows 10 Professional development image (updated with all latest patches) and with at least the 
following products installed:

- IntellIJ
- Eclipse (including some plugins)
- SoapUI
- Visual Studio
- Visual Studio Code
- SQL Server
- Postgresql
- PHP
- Git
- Gitkraken
- Maven
- Postman
- Cmder
- JMeter
- ngRemote

The advantage of having these scripts, is that you can destroy your image and deploy your image again if you have broken something. The other thing is that in a team, all members have the same image with the same settings, thus the same structure. Your code will work the same on each image.

## Prerequisites

In order to use these scripts, you need the following to be installed, although it might also work with the MacOS or 
Linux equivalents. That is not tested though.

- Windows 10
- Virtual Box ([https://www.virtualbox.org](https://www.virtualbox.org/))
- Vagrant ([https://www.vagrantup.com/](https://www.vagrantup.com/))
- Git ([https://git-scm.com](https://git-scm.com/)) (Needed to download this repository.)

## How to create a new environment

First download the "Example Project Specific Development Environment" directory from this repository to a directory of your choosing on your host. Make sure you download the scripts and not the html files :-).

Follow the instructions in that README.md.

Each time after you have shutdown the image execute the following command:

```vagrant reload```

This last command will make sure that the directory mappings are also loaded.

If you want to reset your image do the following:

```vagrant destroy```

and then

```vagrant up```

<b>Note:</b> On your image the Host directory is mounted in /home/vagrant/Host. This means that if you want to keep some
files when you are going to reset your image, you can copy them in that directory and you will find them there again 
when you have reset your image from your host.

## How does it work?

The complete set of scripts is set up as modular as possible.

The Vagrantfile is the starting point for the `vagrant up` command. In that file is defined which base image vagrant should
use to download.
When that base image is downloaded it will only look whether it is the latest version if you run the `vagrant up`
command again.

Then vagrant will create an virtualbox image based on that (only once downloaded) base image and the specification in
the vagrantfile. Hyper-V or parallels can also be configured but this is not tested or implemented.

When the virtualbox image is created it will start the provisioning, also specified in the vagrant file.
This will first update all packages on the image, and then trigger the development.yml playbook in the ansible
directory.

That development.yml playbook will then install all required packages needed for general linux development.

### Vagrantfile

The vagrant file is where it all begins when you do ```vagrant up```. It will first download a base box only once. Each 
next time it will check whether there is a new version of that base box.

Then it will create a new image of that base box in virtualbox.

After that it will install all the required common (as we think) development tools ans preferences.

#### Host directory

The Host directory located in the c:\users\vagrant\Hosts directory on the guest system is mapped to the Hosts directory 
in this directory of the Readme.md file on the host system. Via this way you can easily share multiple files with your 
image and vice versa. 

If you want to use this mapping, you'll have to use the ```vagrant reload``` command though after the first time you 
created the development environment.

### Vagrantfile.user.sample

The Vagrantfile.user.sample is an example file where we can specify your specific custom configuration, like your 
preferred ide installation, background image or other specific windows settings.  

Also, your own public ssh keys for example can be created in this file.

<b>Note</b>: Before you can use this copy it to Vagrantfile.user 

### Vagrantfile.project.sample

The Vagrantfile.project is the place where we can specify our project specific things to be downloaded.
For example all git repositories needed for this project. 

<b>Note</b>: Before you can use this copy it to Vagrantfile.project