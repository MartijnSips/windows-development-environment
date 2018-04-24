$repo="windows-development-environment"
$branch="develop"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri "https://github.com/MartijnSips/$repo/archive/$branch.zip" -OutFile "$repo-$branch.zip"

Expand-Archive -Path $repo-$branch.zip -DestinationPath . -Force

Copy-Item "$repo-$branch\Vagrantfile*" -Destination . -Force
Copy-Item "$repo-$branch\scripts*" -Destination . -Force -Recurse

Remove-Item $repo-$branch* -Recurse -Force
