Import-Module "c:\\users\\vagrant\\scripts\\Set-RvShortcutToRunAsAdministrator.psm1"

Write-Host ">>> Enabling some windows features ..." -foreground Green
Enable-WindowsOptionalFeature -online -featurename IIS-WebServerRole -All -NoRestart
Enable-WindowsOptionalFeature -online -featurename IIS-ManagementScriptingTools -All -NoRestart
Enable-WindowsOptionalFeature -online -featurename IIS-HttpRedirect -All -NoRestart
Enable-WindowsOptionalFeature -online -featurename WCF-HTTP-Activation45 -All -NoRestart
Enable-WindowsOptionalFeature -online -featurename WCF-TCP-Activation45 -All -NoRestart
Enable-WindowsOptionalFeature -online -featurename WCF-Pipe-Activation45 -All -NoRestart
Enable-WindowsOptionalFeature -online -featurename WCF-MSMQ-Activation45 -All -NoRestart

echo "- IIS ..."
Invoke-Expression "c:\users\vagrant\scripts\taskbarpin.vbs 'c:\windows\system32\inetsrv\InetMgr.exe'"

echo "- SQL Server Express + Management studio ..."
choco install vcredist2017 -y
choco install sql-server-express -y
choco install sql-server-management-studio -y
Invoke-Expression "c:\users\vagrant\scripts\taskbarpin.vbs 'C:\Program Files (x86)\Microsoft SQL Server\140\Tools\Binn\ManagementStudio\Ssms.exe'"

# Visual Studio 2017 and its plugins
choco install visualstudio2017enterprise -y
choco install visualstudio2017-workload-netweb -y
choco install visualstudio2017-workload-manageddesktop -y
choco install visualstudio2017-workload-azure -y
choco install visualstudio2017-workload-universal -y
choco install visualstudio2017-workload-webbuildtools -y
Invoke-Expression "c:\users\vagrant\scripts\taskbarpin.vbs 'C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\devenv.exe'"
Set-RvShortcutToRunAsAdministrator -Path 'C:\Users\vagrant\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Visual Studio 2017.lnk' -Verbose

# Extensions
#cinst batch-install-vsix -params "c:\users\vagrant\scripts\vs2017extensions.xml"

# Specflow
# Productivity Power Tools
# Powershell Tools
# Wix Toolset Visual Studio 2017 Extension
# Web Essentials
# EF Core Power Tools

# Resharper plugin for visual studio
choco install resharper -y

choco install azure-cli -y
