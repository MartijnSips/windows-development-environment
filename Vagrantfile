# -*- mode: ruby -*-
# vi: set ft=ruby :

def install_missing_plugins(plugins_to_install:)
  plugins_to_install.select! { |plugin| not Vagrant.has_plugin? plugin }
  puts "Missing plugins are: #{plugins_to_install}" unless plugins_to_install.empty?
  plugins_to_install.each { |plugin|
    if system "vagrant plugin install #{plugin}"
	  exec "vagrant #{ARGV.join(' ')}"
    else
	  abort "Installation of plugin #{plugin} has failed. Aborting."
    end
  }
end

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  required_plugins = %w(vagrant-reload vagrant-vbguest)
  install_missing_plugins(plugins_to_install: required_plugins)

  # Guest additions plugin config
  config.vbguest.auto_update = true
  config.vbguest.no_remote = false

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "vdelarosa/windows-10"

  config.vm.guest = :windows
  config.vm.communicator = "winrm"
  config.vm.boot_timeout = 600
  config.vm.graceful_halt_timeout = 600

  #config.vm.network :forwarded_port, guest: 3389, host: 3389
  #config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true

  config.vm.provider "virtualbox" do |vb|
    vb.name = "Windows Development Environment"
    vb.gui = true
    vb.cpus = 1
    vb.memory = 2086
	
    # Disable 3d acceleration because some programs crash on it.
    vb.customize ["modifyvm", :id, "--accelerate3d", "off"]

    # Enabling copy/paste to/from VM
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]

    # Set the correct ostype
    vb.customize ["modifyvm", :id, "--ostype", "Windows10_64"]

    # Set the correct description
    vb.customize ["modifyvm", :id, "--description", "Windows Development Environment"]

    # Add cdrom disk
    vb.customize ["storageattach", :id, "--storagectl", "IDE Controller", "--port", "0", "--device", "1", "--type", "dvddrive", "--medium", "emptydrive"]

    # Currently there is a problem. Because we use the reload plugin second time the vm boots, the disk is created again. (Which we do not want). Damn!
    # Add a data hard disk
    #disk = 'DataDiskD.vdi'
    #unless File.exist?(disk)
    #  vb.customize ['createhd', '--filename', disk, '--size', 40*1024]
    #  vb.customize ['storageattach', :id, '--storagectl', 'IDE Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk]
    #end

    #file_to_disk = "diskd.vdi"
    #vb.customize ["createhd", "--filename", file_to_disk, "--size", 40 * 1024] unless File.exist?(file_to_disk)
    #vb.customize ["storageattach", :id, "--storagectl", "IDE Controller", "--port", 1, "--device", 0, "--type", "hdd", "--medium", file_to_disk]

  end

  #config.vm.synced_folder "#{ENV['USERPROFILE']}\Documents", 'c:\users\vagrant\Documents', owner: "vagrant", group: "vagrant", create: true
  #config.vm.synced_folder "#{ENV['USERPROFILE']}\Downloads", 'c:\users\vagrant\Downloads', owner: "vagrant", group: "vagrant", create: true

  config.vm.synced_folder "scripts", 'c:\users\vagrant\scripts', owner: "vagrant", group: "vagrant"
  config.vm.synced_folder "Host", 'c:\users\vagrant\Host', create: true, owner: "vagrant", group: "vagrant"

  config.vm.provision "shell", privileged: true, inline: <<-SHELL

	# Desktop icons can be a little bit smaller
    Write-Host ">>> Changing the desktop icons ..." -foreground Green
	Import-Module "c:\\users\\vagrant\\scripts\\ChangeDesktopIconSize.psm1"
	ChangeDesktopIconSize -IconSize 24

	# Use small taskbar icons
    Write-Host ">>> Using small taskbar icons ..." -foreground Green
	Import-Module "c:\\users\\vagrant\\scripts\\UseSmallTaskbarIcons.psm1"
	UseSmallTaskbarIcons

	Write-Host ">>> Switch keyboard layout ..." -foreground Green
	Set-WinUserLanguageList -LanguageList en-US -force

	#Write-Host ">>> Formatting Data Disk ..." -foreground Green
	#Get-Disk | Where PartitionStyle -eq 'raw' | Initialize-Disk -PartitionStyle MBR -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Data Disk"
  SHELL

  config.vm.provision :reload

  config.vm.provision "shell", privileged: true, inline: <<-SHELL
    # Install all latest windows updates
    Write-Host ">>> Running all windows updates ..." -foreground Green
    Write-Host "    Installing PSWindowsUpdate ..." -foreground Green
    Install-Module PSWindowsUpdate -force
    Write-Host "    Performing windows update ..." -foreground Green
    Get-WUInstall -AcceptAll -MicrosoftUpdate -Verbose
  SHELL

  config.vm.provision :reload

  config.vm.provision "shell", privileged: true, inline: <<-SHELL
    Write-Host ">>> Enabling some windows features ..." -foreground Green
	Enable-WindowsOptionalFeature -online -featurename IIS-WebServerRole -All -NoRestart
    Enable-WindowsOptionalFeature -online -featurename IIS-ManagementScriptingTools -All -NoRestart
    Enable-WindowsOptionalFeature -online -featurename IIS-HttpRedirect -All -NoRestart
    Enable-WindowsOptionalFeature -online -featurename WCF-HTTP-Activation45 -All -NoRestart
    Enable-WindowsOptionalFeature -online -featurename WCF-TCP-Activation45 -All -NoRestart
    Enable-WindowsOptionalFeature -online -featurename WCF-Pipe-Activation45 -All -NoRestart
    Enable-WindowsOptionalFeature -online -featurename WCF-MSMQ-Activation45 -All -NoRestart
  SHELL

  config.vm.provision :reload

  config.vm.provision "shell", privileged: true, inline: <<-SHELL
    Write-Host ">>> Installing chocolatey ..." -foreground Green
	iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
  SHELL

  config.vm.provision "shell", privileged: true, inline: <<-SHELL
    Write-Host ">>> Installing development tools ..." -foreground Green
    Invoke-Expression "c:\\users\\vagrant\\scripts\\SetupDevelopmentSoftware.ps1"
  SHELL

  config.vm.provision :reload

end

# Load the file with user specific stuff
user_vagrantfile = File.expand_path('../Vagrantfile.user', __FILE__)
load user_vagrantfile if File.exists?(user_vagrantfile)

# Load the file with project specific stuff
project_vagrantfile = File.expand_path('../Vagrantfile.project', __FILE__)
load project_vagrantfile if File.exists?(project_vagrantfile)
