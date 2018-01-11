# Windows 10 .NET development base box

## Purpose

The scripts in this folder will create a base box to be used with vagrant, in order to create a common
.NET development image.

The base box will include:
- Windows 10
- Visual Studio 2017 

## How this is build

### Prerequisites

You need to have the following software installed. (The version within the brackets are the versions where these scripts 
are tested with.)

- Packer (1.1.0)
- Vagrant (2.0.1)
- Virtualbox (5.2.2)

#### Windows
You need to have an autounattend.xml file (exactly named like that). You can configure this via the 
Windows System Image Manager. You can get that if you download and install the Windows ADK.

#### VS2017
? 

### Building
Execute the following command 
```c:\Hashicorp\Packer\Packer.exe build windows_10.json```

This will take approximately 1 hour to build.

