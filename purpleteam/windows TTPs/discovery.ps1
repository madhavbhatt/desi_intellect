<# 

The commands in this script include atomic red team TTPs. This script is meant to automate execution of TTPs as well as make it reproducible 
along with generating a log file that notes down the time at which it was executed.parameters can be replaced with appropriate binaries suitable for yor
environment 

#>

$currentdir = $(pwd).Path
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$DISCOVERYLOGO=
'
############################################################################################################################################################################################################### 
#                                                                                                                                                                                                              #   
#                                                                                                 DISCOVERY                                                                                                    #   
#                                                                                                                                                                                                              #
################################################################################################################################################################################################################
'

Write-Host $DISCOVERYLOGO

$T1007_service_name = "lsass.exe"

$T1007 = '
tasklist.exe
sc query
sc query state= all
sc start '+ $T1007_service_name +'
sc stop '+ $T1007_service_name +'
wmic service where (displayname like "'+ $T1007_service_name +'") get name whoami
'

$T1012 = '
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows"
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunServices
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\RunServices
reg query HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify
reg query HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Userinit
reg query HKCU\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\\Shell
reg query HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\\Shell
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ShellServiceObjectDelayLoad
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnceEx
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
reg query hklm\system\currentcontrolset\services /s | findstr ImagePath 2>nul | findstr /Ri ".*\.sys$"
reg Query HKLM\Software\Microsoft\Windows\CurrentVersion\Run
reg save HKLM\Security security.hive
reg save HKLM\System system.hive
reg save HKLM\SAM sam.hive

' 

$T1016 = '
ipconfig /all
netsh interface show
arp -a
nbtstat -n
net config
'

$T1018_ip_range_first_3_octets = "10.0.0"

$T1018 = '
net view /domain
net view
cmd.exe /c "for /l %i in (1,1,254) do ping -n 1 -w '+ $T1018_ip_range_first_3_octets +'.%i"
'

$T1033_computer_name = "janedoe-pc"
$T1033 = '
cmd.exe /C whoami
wmic useraccount get /ALL
quser /SERVER:"'+ $T1033_computer_name +'"
quser
qwinsta.exe" /server:'+ $T1033_computer_name +'
qwinsta.exe
cmd.exe /c "for /F "tokens=1,2" %i in (''qwinsta /server:'+ $T1033_computer_name +' ^| findstr "Active Disc"'') do @echo %i | find /v "#" | find /v "console" || echo %j > usernames.txt"
cmd.exe /c "@FOR /F %n in (computers.txt) DO @FOR /F "tokens=1,2" %i in (''qwinsta /server:%n ^| findstr "Active Disc"'') do @echo %i | find /v "#" | find /v "console" || echo %j > usernames.txt"
'

$T1047_node = "janedoe-pc"
$T1047_service = "explorer"

$T1047 = '
wmic useraccount get /ALL
wmic process get caption,executablepath,commandline
wmic qfe get description,installedOn /format:csv
wmic /node:"'+ $T1047_node +'" service where (caption like "%'+ $T1047_service +' (%")
'

$T1049 = '
net use
net sessions
Get-NetTCPConnection
'

$T1063 = '
netsh.exe advfirewall firewall show all profiles
tasklist.exe
tasklist.exe | findstr /i virus
tasklist.exe | findstr /i cb
tasklist.exe | findstr /i defender
tasklist.exe | findstr /i cylance
		
powershell.exe get-process | ?{$_.Description -like "*virus*"}
powershell.exe get-process | ?{$_.Description -like "*carbonblack*"}
powershell.exe get-process | ?{$_.Description -like "*defender*"}
powershell.exe get-process | ?{$_.Description -like "*cylance*"}
'

$T1082 = '
systeminfo
reg query HKLM\SYSTEM\CurrentControlSet\Services\Disk\Enum
'

$T1083 = '
cmd.exe /c "dir /s c:\ >> %temp%\download"
cmd.exe /c "dir /s "c:\Documents and Settings" >> %temp%\download"
cmd.exe /c "dir /s "c:\Program Files\" >> %temp%\download"
cmd.exe /c "dir /s d:\ >> %temp%\download"
cmd.exe /c "dir "%systemdrive%\Users\*.*" >> %temp%\download"
cmd.exe /c "dir "%userprofile%\AppData\Roaming\Microsoft\Windows\Recent\*.*" >> %temp%\download"
cmd.exe /c "dir "%userprofile%\Desktop\*.*" >> %temp%\download"
'

$T1087 = '
cmd.exe /c "dir /s c:\ >> %temp%\download"
cmd.exe /c "dir /s "c:\Documents and Settings" >> %temp%\download"
cmd.exe /c "dir /s "c:\Program Files\" >> %temp%\download"
cmd.exe /c "dir /s d:\ >> %temp%\download"
cmd.exe /c "dir "%systemdrive%\Users\*.*" >> %temp%\download"
cmd.exe /c "dir "%userprofile%\AppData\Roaming\Microsoft\Windows\Recent\*.*" >> %temp%\download"
cmd.exe /c "dir "%userprofile%\Desktop\*.*" >> %temp%\download"
get-localuser
get-localgroupmembers -group Users
get-childitem C:\Users\
dir C:\Users\
get-aduser -filter *
get-localgroup
net localgroup
query user
'

$T1124 = '
net time \\'+ $T1047_node +'
w32tm /tz
powershell.exe Get-Date
'

$T1135 = '
smbutil view -g //'+ $T1047_node +'
showmount '+ $T1047_node +'
net view \\'+ $T1047_node +'
net view \\'+ $T1047_node +'
get-smbshare -Name '+ $T1047_node 

[array]$discovery_TTP_number = "T1007","T1012","T1016","T1018","T1033","T1047","T1049","T1063","T1082","T1083","T1087","T1124","T1135"
[array]$discovery = $T1007, $T1012, $T1016, $T1018, $T1033, $T1047, $T1049, $T1063, $T1082, $T1083, $T1087, $T1124, $T1135


for ($i=0; $i -lt $discovery.length; $i++){

    Write-Host Exeucting $discovery_TTP_number[$i] -ForegroundColor Red `n
    Write-Host $discovery[$i] -ForegroundColor green `n
    Write-Host Time : $(Get-Date) -ForegroundColor Cyan `n
    Write-Host -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Get-Date | Add-Content log-discovery.txt 
    "                         " | Add-Content log-discovery.txt
    $discovery_TTP_number[$i]+ " : " + $discovery[$i] | Add-Content log-discovery.txt
    "                         " | Add-Content log-discovery.txt
    <# Invoke-Expression $discovery[$i] #>
    "---------------------------------------------------------------------------------------------------------------------------" | Add-Content log-discovery.txt 
} 

