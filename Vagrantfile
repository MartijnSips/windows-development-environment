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
  config.vm.box = "martijnsips/Win10Pro"

  config.vm.guest = :windows
  config.vm.communicator = "winrm"
  config.vm.boot_timeout = 600
  config.vm.graceful_halt_timeout = 600

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

  end

  config.vm.provider "parallels" do |prl|
    prl.name = "Windows Development Environment"
    prl.gui = true
    prl.cpus = 1
    prl.memory = 2086
  end

  config.vm.synced_folder "scripts", 'c:\users\vagrant\scripts', owner: "vagrant", group: "vagrant"
  config.vm.synced_folder "Host", 'c:\users\vagrant\Host', create: true, owner: "vagrant", group: "vagrant"

  config.vm.provision :reload

  config.vm.provision "shell", privileged: true, inline: <<-SHELL
    Invoke-Expression "c:\\users\\vagrant\\scripts\\SetupCommonDevelopmentSoftware.ps1"
    Invoke-Expression "c:\\users\\vagrant\\scripts\\SetupJavaDevelopmentSoftware.ps1"
    Invoke-Expression "c:\\users\\vagrant\\scripts\\SetupWindowsDevelopmentSoftware.ps1"
  SHELL

  config.vm.provision :reload

end

# Load the file with user specific stuff
user_vagrantfile = File.expand_path('../Vagrantfile.user', __FILE__)
load user_vagrantfile if File.exists?(user_vagrantfile)

# Load the file with project specific stuff
project_vagrantfile = File.expand_path('../Vagrantfile.project', __FILE__)
load project_vagrantfile if File.exists?(project_vagrantfile)
