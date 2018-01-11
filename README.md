# Windows Development environment

The scripts in this repository will create you a local Windows development environment.

Default installed on this image is:
- Windows 10 Pro
- Visual Studio 2017
...

In order to use these scripts you'll need the following:
- Virtualbox
- Vagrant
- Git (not required but handy)

## Which type?

There are two ways to create a new Windows Development environment. 

### Based on a cloud box (from scratch)

This means that a default, already existing box from the cloud is used to create your initial image. Then 
all additional software like visual studio is installed on top of that. This might take a while to complete.

### Based on a custom cloud box

To speed things up, we have created a packer project to create a base box on your system.
You should create this box only once.

Then vagrant will use that box to create your initial image. As the software is in this case already added to the base box, only the project specific stuff then needs to be deployed.
This is the faster way.




