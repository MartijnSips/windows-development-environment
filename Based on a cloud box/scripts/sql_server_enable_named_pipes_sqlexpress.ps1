[reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")
[reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.SqlWmiManagement")

$server = '127.0.0.1';
$Mc = New-Object ('Microsoft.SQLServer.Management.SMO.WMI.ManagedComputer')"$server"

Write-Host "Enabling Named Pipes for the SQL Service Instance on $server"
# Enable the named pipes protocol for the default instance.
$uri = "ManagedComputer[@Name='$server']/ ServerInstance[@Name='SQLEXPRESS']/ServerProtocol[@Name='Np']"
$Np = $Mc.GetSmoObject($uri)
$Np.IsEnabled = $true
$Np.Alter()
$Np

Restart-Service -InputObject $(Get-Service -ComputerName $server -Name "MSSQL`$SQLEXPRESS") -Verbose
