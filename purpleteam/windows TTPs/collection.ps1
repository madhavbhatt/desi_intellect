<# 

The commands in this script include atomic red team TTPs. This script is meant to automate execution of TTPs as well as make it reproducible 
along with generating a log file that notes down the time at which it was executed.parameters can be replaced with appropriate binaries suitable for yor
environment 

#>

$currentdir = $(pwd).Path
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$COLLECTIONLOGO=
'
############################################################################################################################################################################################################### 
#                                                                                                                                                                                                              #   
#                                                                                                COLLECTION                                                                                                    #   
#                                                                                                                                                                                                              #
################################################################################################################################################################################################################
'

Write-Host $COLLECTIONLOGO

$T1074_bat = "$currentdir\T1074.bat"
$T1115_readme_txt = "$currentdir\T1115.txt"

$T1074_download = "https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1074/Discovery.bat"
$T1115_readme = "https://raw.githubusercontent.com/madhavbhatt/Web-Based-Command-Control/master/README.md"

Invoke-WebRequest -Uri $T1074_download -OutFile $T1074_bat
Invoke-WebRequest -Uri $T1074_download -OutFile $T1115_readme_txt


$T1074 = 
'
net user Administrator /domain >> c:\windows\temp\T1074.log
net Accounts >> c:\windows\temp\T1074.log
net localgroup administrators >> c:\windows\temp\T1074.log
net use >> c:\windows\temp\T1074.log
net share >> c:\windows\temp\T1074.log
net group "domain admins" /domain >> c:\windows\temp\T1074.log
net config workstation >> c:\windows\temp\T1074.log
net accounts >> c:\windows\temp\T1074.log
net accounts /domain >> c:\windows\temp\T1074.log
net view >> c:\windows\temp\T1074.log
sc query >> c:\windows\temp\T1074.log
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" >> c:\windows\temp\T1074.log
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce >> c:\windows\temp\T1074.log
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce >> c:\windows\temp\T1074.log
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunServices >> c:\windows\temp\T1074.log
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\RunServices >> c:\windows\temp\T1074.log
reg query HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify >> c:\windows\temp\T1074.log
reg query HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Userinit >> c:\windows\temp\T1074.log
reg query HKCU\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\\Shell >> c:\windows\temp\T1074.log
reg query HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\\Shell >> c:\windows\temp\T1074.log
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ShellServiceObjectDelayLoad >> c:\windows\temp\T1074.log
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce >> c:\windows\temp\T1074.log
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnceEx >> c:\windows\temp\T1074.log
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run >> c:\windows\temp\T1074.log
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run >> c:\windows\temp\T1074.log
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce >> c:\windows\temp\T1074.log
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run >> c:\windows\temp\T1074.log
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run >> c:\windows\temp\T1074.log
wmic useraccount list >> c:\windows\temp\T1074.log
wmic useraccount get /ALL >> c:\windows\temp\T1074.log
wmic startup list brief >> c:\windows\temp\T1074.log
wmic share list >> c:\windows\temp\T1074.log
wmic service get name,displayname,pathname,startmode >> c:\windows\temp\T1074.log
wmic process list brief >> c:\windows\temp\T1074.log
wmic process get caption,executablepath,commandline >> c:\windows\temp\T1074.log
wmic qfe get description,installedOn /format:csv >> c:\windows\temp\T1074.log
arp -a >> c:\windows\temp\T1074.log
whoami >> c:\windows\temp\T1074.log
ipconfig /displaydns >> c:\windows\temp\T1074.log
route print >> c:\windows\temp\T1074.log
netsh advfirewall show allprofiles >> c:\windows\temp\T1074.log
systeminfo >> c:\windows\temp\T1074.log
qwinsta >> c:\windows\temp\T1074.log
quser >> c:\windows\temp\T1074.log
'
 
$T1115_1 = 'cmd.exe /c "dir | clip"'
$T1115_2 = 'cmd.exe /c "clip < T1115.txt"'
$T1115_3 = 'Get-Clipboard'		
$T1115_4 = 'Get-Process | clip'
$T1115_5 = 'Get-Clipboard'

$T1119_1 = 'cmd.exe /c "dir c: /b /s .docx | findstr /e .docx"'
$T1119_2 = 'cmd.exe /c "for /R c: %f in (*.docx) do copy %f c:\temp\"'
$T1119_3 = 'Get-ChildItem -Recurse -Include *.doc | % {Copy-Item $_.FullName -destination c:\temp}'

[array]$collection_TTP_number = "T1115_1", "T1115_2", "T1115_3", "T1115_4", "T1115_5", "T1119_1", "T1119_2", "T1119_3", "T1074"
[array]$collection = $T1115_1, $T1115_2, $T1115_3, $T1115_4, $T1115_5, $T1119_1, $T1119_2, $T1119_3, $T1074


for ($i=0; $i -lt $collection.length; $i++){

    Write-Host Exeucting $collection_TTP_number[$i] -ForegroundColor Red `n
    Write-Host $collection[$i] -ForegroundColor green `n
    Write-Host Time : $(Get-Date) -ForegroundColor Cyan `n
    Write-Host -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Get-Date | Add-Content log-collection.txt 
    "                         " | Add-Content log-collection.txt
    $collection_TTP_number[$i]+ " : " + $collection[$i] | Add-Content log-collection.txt
    "                         " | Add-Content log-collection.txt
    <# Invoke-Expression $collection[$i] #>
    "---------------------------------------------------------------------------------------------------------------------------" | Add-Content log-collection.txt 
} 
