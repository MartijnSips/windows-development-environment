[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri "https://github.com/MartijnSips/ubuntu-development-environment/archive/development.zip" -OutFile "ubuntu-development-environment-development.zip"

Expand-Archive -Path ubuntu-development-environment-development.zip -DestinationPath . -Force

Copy-Item "ubuntu-development-environment-development\Vagrantfile*" -Destination . -Force
Copy-Item "ubuntu-development-environment-development\Ansible" -Recurse -Destination . -Force

Remove-Item ubuntu-development-environment-development* -Recurse -Force