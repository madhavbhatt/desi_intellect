<# 

The commands in this script include atomic red team TTPs. This script is meant to automate execution of TTPs as well as make it reproducible 
along with generating a log file that notes down the time at which it was executed.parameters can be replaced with appropriate binaries suitable for yor
environment 

#>

$currentdir = $(pwd).Path
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$C2LOGO = 
'
############################################################################################################################################################################################################### 
#                                                                                                                                                                                                              #   
#                                                                                       COMMAND AND CONTROL                                                                                                    #   
#                                                                                                                                                                                                              #
################################################################################################################################################################################################################
'

Write-Host $C2LOGO

$T1069_user = "clamay"

$T1069 = '
net localgroup
net group /domain
get-localgroup
Get-ADPrincipalGroupMembership '+ $T1069_user +' | select name
'

[array]$c2_TTP_number = "T1069"
[array]$c2 = $T1069


for ($i=0; $i -lt $c2.length; $i++){

    Write-Host Exeucting $c2_TTP_number[$i] -ForegroundColor Red `n
    Write-Host $c2[$i] -ForegroundColor green `n
    Write-Host Time : $(Get-Date) -ForegroundColor Cyan `n
    Write-Host -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Get-Date | Add-Content log-c2.txt 
    "                         " | Add-Content log-c2.txt
    $c2_TTP_number[$i]+ " : " + $c2[$i] | Add-Content log-c2.txt
    "                         " | Add-Content log-c2.txt
    <# Invoke-Expression $c2[$i] #>
    "---------------------------------------------------------------------------------------------------------------------------" | Add-Content log-c2.txt 
} 