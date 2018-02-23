Function Set-RvShortcutToRunAsAdministrator
{
    <#
	.SYNOPSIS
        Modify existing shortcuts (links) to run application in elevated mode (Run as administrator).

    .DESCRIPTION
        Developer
            Developer: Rudolf Vesely, http://rudolfvesely.com/
            Copyright (c) Rudolf Vesely. All rights reserved
            License: Free for private use only

            "RV" are initials of the developer's name Rudolf Vesely and distingue names of Rudolf Vesely's cmdlets from the other cmdlets.

        Description
            Modify existing shortcuts (links) to start application in elevated mode (Run as administrator).

    .EXAMPLE
        'Single file: Modify link to Run as administrator (elevate)'
        Set-RvShortcutToRunAsAdministrator -Path 'C:\Temporary\my link.lnk' -Verbose

    .EXAMPLE
        'All files: Modify link to Run as administrator (elevate)'
        Get-ChildItem -Path 'C:\Temporary\test' -Filter *.lnk | Set-RvShortcutToRunAsAdministrator -Verbose

    .INPUTS

    .OUTPUTS

    .LINK
        https://techstronghold.com/
    #>

    [CmdletBinding(
        DefaultParametersetName = 'Path',
        SupportsShouldProcess = $true,
        PositionalBinding = $false,
        HelpURI = 'https://techstronghold.com/',
        ConfirmImpact = 'Medium'
    )]

    Param
    (
        [Parameter(
            Mandatory = $false,
            Position = 0,
            ParameterSetName = 'Path',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateLength(1, 255)]
        [Alias('FullName')]
        [string[]]$Path
    )

    Begin
    {
        $ErrorActionPreference = 'Stop'
        Set-PSDebug -Strict
        Set-StrictMode -Version Latest
    }

    Process
    {
        foreach ($pathItem in $path)
        {
            if (Test-Path -Path $pathItem -PathType Leaf)
            {
                $fileItem = Get-Item -Path $pathItem

                if ($fileItem.Extension -eq '.lnk')
                {
                    Write-Verbose -Message ('        - Path: {0}' -f $fileItem.FullName)

                    $newFilePath = Join-Path `
                        -Path $fileItem.Directory.FullName `
                        -ChildPath ('{0} - Copy {1}{2}' -f $fileItem.BaseName, (Get-Random -Minimum 9999 -Maximum 99999999), $fileItem.Extension)

                    $writer = New-Object -TypeName System.IO.FileStream `
                        -ArgumentList $newFilePath, ([System.IO.FileMode]::Create)

                    $reader = $fileItem.OpenRead()

                    while ($reader.Position -lt $reader.Length)
                    {
                        $byte = $reader.ReadByte()
                        if ($reader.Position -eq 22)
                        {
                            $byte = 34
                        }
                        $writer.WriteByte($byte)
                    }

                    $reader.Close()
                    $writer.Close()

                    $fileItem | Remove-Item
                    Rename-Item -Path $newFilePath -NewName (Split-Path -Path $pathItem -Leaf)
                }
                else
                {
                    Write-Warning -Message ('The file has to have LNK extension: {0}' -f $pathItem)
                }
            }
            else
            {
                Write-Warning -Message ('The file does not exists: {0}' -f $pathItem)
            }
        }
    }

    End
    {
    }
}