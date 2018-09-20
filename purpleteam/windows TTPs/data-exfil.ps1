<# 

The commands in this script include atomic red team TTPs. This script is meant to automate execution of TTPs as well as make it reproducible 
along with generating a log file that notes down the time at which it was executed.parameters can be replaced with appropriate binaries suitable for yor
environment 

#>

$currentdir = $(pwd).Path
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$DATAEXFILLOGO=
'
############################################################################################################################################################################################################### 
#                                                                                                                                                                                                              #   
#                                                                                         DATA EXFILTRATION                                                                                                    #   
#                                                                                                                                                                                                              #
################################################################################################################################################################################################################
'

Write-Host $DATAEXFILLOGO

$T1002_input = "c:\users\" + $env:username + "\downloads"
$T1002_output_archive = "c:\users\" + $env:username + "\documents\T1002-archive"
$T1002_output_rar = "c:\users\" + $env:username + "\documents\T1002-rar"


$T1002 = '
Compress-Archive -Path ' + $T1002_input + ' -DestinationPath ' + $T1002_output_archive + ' -Force'
# rar a -r ' + $T1002_output_rar + '  ' + $T1002_input


[array]$data_exfil_TTP_number = "T1002" 
[array]$data_exfil = $T1002


for ($i=0; $i -lt $data_exfil.length; $i++){
   
    Write-Host Exeucting $data_exfil_TTP_number[$i] -ForegroundColor Red `n
    Write-Host $data_exfil[$i] -ForegroundColor green `n
    Write-Host Time : $(Get-Date) -ForegroundColor Cyan `n
    Write-Host -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Get-Date | Add-Content log-data-exfil.txt 
    "                         " | Add-Content log-data-exfil.txt
    $data_exfil_TTP_number[$i]+ " : " + $data_exfil[$i] | Add-Content log-data-exfil.txt
    "                         " | Add-Content log-data-exfil.txt
    <# Invoke-Expression $data_exfil[$i] #>
    "---------------------------------------------------------------------------------------------------------------------------" | Add-Content log-data-exfil.txt 
} 
