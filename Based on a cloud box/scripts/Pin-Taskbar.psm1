function Pin-Taskbar([string]$Item = "",[string]$Action = ""){
    if($Item -eq ""){
        Write-Error -Message "You need to specify an item" -ErrorAction Stop
    }
    if($Action -eq ""){
        Write-Error -Message "You need to specify an action: Pin or Unpin" -ErrorAction Stop
    }
    if((Get-Item -Path $Item -ErrorAction SilentlyContinue) -eq $null){
        Write-Error -Message "$Item not found" -ErrorAction Stop
    }
    $Shell = New-Object -ComObject "Shell.Application"
    $ItemParent = Split-Path -Path $Item -Parent
    $ItemLeaf = Split-Path -Path $Item -Leaf
    $Folder = $Shell.NameSpace($ItemParent)
    $ItemObject = $Folder.ParseName($ItemLeaf)
    $Verbs = $ItemObject.Verbs()
    switch($Action){
        "Pin"   {$Verb = $Verbs | Where-Object -Property Name -EQ "Pin to Tas&kbar"}
        "Unpin" {$Verb = $Verbs | Where-Object -Property Name -EQ "Unpin from Tas&kbar"}
        default {Write-Error -Message "Invalid action, should be Pin or Unpin" -ErrorAction Stop}
    }
    if($Verb -eq $null){
        Write-Error -Message "That action is not currently available on this item" -ErrorAction Stop
    } else {
        $Result = $Verb.DoIt()
    }
}