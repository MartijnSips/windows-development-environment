#The sample scripts are not supported under any Microsoft standard support 
#program or service. The sample scripts are provided AS IS without warranty  
#of any kind. Microsoft further disclaims all implied warranties including,  
#without limitation, any implied warranties of merchantability or of fitness for 
#a particular purpose. The entire risk arising out of the use or performance of  
#the sample scripts and documentation remains with you. In no event shall 
#Microsoft, its authors, or anyone else involved in the creation, production, or 
#delivery of the scripts be liable for any damages whatsoever (including, 
#without limitation, damages for loss of business profits, business interruption, 
#loss of business information, or other pecuniary loss) arising out of the use 
#of or inability to use the sample scripts or documentation, even if Microsoft 
#has been advised of the possibility of such damages.

Function ChangeDesktopIconSize
{
    Param
    (
        [int] $IconSize = 68
    )
    IF(Test-Path -Path HKCU:\Software\Microsoft\Windows\Shell\Bags\1\Desktop)
    {
        Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\Shell\Bags\1\Desktop -Name IconSize -Value $IconSize
    }
    ELSEIF(Test-Path -Path 'HKCU:\Control Panel\Desktop\WindowMetrics')
    {
        Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop\WindowMetrics' -Name 'Shell Icon Size' -Value $IconSize
    }  
    #Restart Explorer to change it immediately  
    #Stop-Process -name explorer

}


