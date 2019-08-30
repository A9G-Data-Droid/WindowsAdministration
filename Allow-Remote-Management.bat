@ECHO OFF
REM Allow-Remote-Management v1.1 by Adam Kauffman 2019-7-24
ECHO Start Required Services
sc.exe start LanmanServer start= auto
sc.exe start RemoteRegistry start= auto
sc.exe start Winmgmt start= auto
sc.exe start RpcSs start= auto
sc.exe start DcomLaunch start= auto

::ECHO Enable WinRM
::sc.exe config "WinRM" start= auto
::net start WinRM
::winrm quickconfig

ECHO Open Firewall Ports ...
NETSH.EXE FIREWALL SET SERVICE remoteadmin enable
NETSH.EXE ADVFIREWALL FIREWALL SET RULE GROUP="Remote Administration" NEW ENABLE=YES
NETSH.EXE ADVFIREWALL FIREWALL SET RULE GROUP="Windows Management Instrumentation (WMI)" NEW ENABLE=YES
NETSH.EXE ADVFIREWALL FIREWALL SET RULE NAME="Windows Management Instrumentation (ASync-In)" NEW ENABLE=YES
NETSH.EXE ADVFIREWALL FIREWALL SET RULE NAME="Windows Management Instrumentation (WMI-Out)" NEW ENABLE=YES
NETSH.EXE ADVFIREWALL FIREWALL SET RULE NAME="Windows Management Instrumentation (WMI-In)" NEW ENABLE=YES
NETSH.EXE ADVFIREWALL FIREWALL SET RULE NAME="Windows Management Instrumentation (DCOM-In)" NEW ENABLE=YES
NETSH.EXE ADVFIREWALL FIREWALL SET RULE GROUP="File and Printer Sharing" NEW ENABLE=YES
NETSH.EXE ADVFIREWALL FIREWALL SET RULE NAME="File and Printer Sharing (Echo Request - ICMPv4-In)" NEW ENABLE=YES

ECHO Disable UAC remote restrictions
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f

gpupdate.exe /force /wait:0
