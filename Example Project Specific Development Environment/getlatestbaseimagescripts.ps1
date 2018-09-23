$repo="windows-development-environment"
$branch="develop"
$targetDir = $env:temp

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri "https://github.com/MartijnSips/$repo/archive/$branch.zip" -OutFile "$targetDir\$repo-$branch.zip"

$currentDir = (Get-Item -Path ".\").FullName
Expand-Archive -Path "$targetDir\$repo-$branch.zip" -DestinationPath "$targetDir" -Force

Copy-Item "$targetDir\$repo-$branch\Vagrantfile*" -Destination "$currentDir" -Force
Copy-Item "$targetDir\$repo-$branch\scripts*" -Destination "$currentDir" -Force -Recurse

Remove-Item "$targetDir\$repo-$branch*" -Recurse -Force
