Import-Module "c:\\users\\vagrant\\scripts\\Set-RvShortcutToRunAsAdministrator.psm1"

# Desktop icons can be a little bit smaller
Write-Host ">>> Changing the desktop icons ..." -foreground Green
Import-Module "c:\\users\\vagrant\\scripts\\ChangeDesktopIconSize.psm1"
ChangeDesktopIconSize -IconSize 24
Stop-Process -name explorer

# Use small taskbar icons
Write-Host ">>> Using small taskbar icons ..." -foreground Green
Import-Module "c:\\users\\vagrant\\scripts\\UseSmallTaskbarIcons.psm1"
UseSmallTaskbarIcons

# Install all latest windows updates
Write-Host ">>> Running all windows updates ..." -foreground Green
Write-Host "    Installing PSWindowsUpdate ..." -foreground Green
Install-Module PSWindowsUpdate -force
Write-Host "    Performing windows update ..." -foreground Green
Get-WUInstall -AcceptAll -MicrosoftUpdate -Verbose

Write-Host ">>> Installing chocolatey ..." -foreground Green
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

echo "- Command prompt adjustments ..."
Invoke-Expression "c:\users\vagrant\scripts\taskbarpin.vbs 'c:\windows\system32\cmd.exe'"

echo "- Powershell ..."
Invoke-Expression "c:\users\vagrant\scripts\taskbarpin.vbs 'c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe'"
Set-RvShortcutToRunAsAdministrator -Path 'C:\Users\vagrant\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Windows PowerShell.lnk' -Verbose

# Currently there is a problem with the deployment of Notepad++ via chocolatey
echo "- Notepad++ ..."
choco install notepadplusplus -y
Invoke-Expression "c:\users\vagrant\scripts\taskbarpin.vbs 'C:\Program Files\Notepad++\notepad++.exe'"

echo "- SoapUI ..."
choco install soapui -y
Invoke-Expression "c:\users\vagrant\scripts\taskbarpin.vbs 'C:\Program Files\SmartBear\SoapUI-5.5.0\bin\SoapUI-5.5.0.exe'"

echo "- Git ..."
choco install git -y

echo "- OpenSSH ..."
choco install openssh -y

echo "- Google Chrome ..."
choco install google-chrome-x64 -y
Invoke-Expression "c:\users\vagrant\scripts\taskbarpin.vbs 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'"

echo "- Firefox ..."
choco install firefox -y
Invoke-Expression "c:\users\vagrant\scripts\taskbarpin.vbs 'C:\Program Files\Mozilla Firefox\firefox.exe'"

echo "- Firefox Developer Edition ..."
Invoke-WebRequest -Uri https://download.mozilla.org/?product=firefox-devedition-stub -OutFile "c:\\users\\vagrant\\Downloads\\FireFoxDeveloperEdition.exe"
Invoke-Expression "c:\\users\\vagrant\\Downloads\\FireFoxDeveloperEdition.exe /S"
Invoke-Expression "c:\users\vagrant\scripts\taskbarpin.vbs 'C:\Program Files\Firefox Developer Edition\firefox.exe'"

echo "- Paint.NET ..."
choco install paint.net -y

choco install postman -y

# Fiddler
Invoke-WebRequest -Uri https://telerik-fiddler.s3.amazonaws.com/fiddler/FiddlerSetup.exe -OutFile "c:\\users\\vagrant\\Downloads\\FiddlerSetup.exe"
Invoke-Expression "c:\\users\\vagrant\\Downloads\\FiddlerSetup.exe /S"
Invoke-Expression "c:\users\vagrant\scripts\taskbarpin.vbs 'C:\Users\vagrant\AppData\Local\Programs\Fiddler\Fiddler.exe'"

# Winmerge
choco install winmerge -y

choco install nodejs -y
Invoke-Expression "& 'c:\Program Files\nodejs\npm' i -g azure-functions-core-tools"
Invoke-Expression "& 'c:\Program Files\nodejs\npm' i -g bower"
Invoke-Expression "& 'c:\Program Files\nodejs\npm' i -g grunt-cli"

# Visual studio code.
choco install visualstudiocode -y
code --install-extension ms-dotnettools.csharp # C# Language Support
code --install-extension ms-vscode.powershell              # Powershell Language Support
code --install-extension mads-hartmann.bash-ide-vscode     # Bash IDE
code --install-extension tomaciazek.ansible                # Ansible Language Support
code --install-extension puppet.puppet-vscode              # Puppet
code --install-extension amillard98.specflow-tools         # Specflow tools
code --install-extension ms-azure-devops.azure-pipelines   # Azure pipelines
code --install-extension yzhang.markdown-all-in-one        # Markdown
code --install-extension hsse-development.gitversionview   # GitVersion view
code --install-extension polymer.polymer-ide               # Polymer IDE
code --install-extension ms-mssql.mssql                    # SQL Server (mssql)
code --install-extension redhat.vscode-yaml                # YAML
code --install-extension ms-azuretools.vscode-docker       # Docker
code --install-extension ms-python.python                  # Python
code --install-extension 4ops.terraform                    # Terraform

# Install keepass
choco install keepass -y
Invoke-Expression "c:\users\vagrant\scripts\taskbarpin.vbs 'C:\Program Files (x86)\KeePass Password Safe 2\keepass.exe'"

# Cmder
choco install cmder -y
Invoke-Expression "c:\users\vagrant\scripts\taskbarpin.vbs 'C:\tools\cmder\cmder.exe'"

# Draw.io
choco install drawio -y