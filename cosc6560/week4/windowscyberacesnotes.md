# Cyberaces - Introduction to Operating Systems

## Windows Notes

### Virtual Machine Installation

[Tutorial Video](https://youtu.be/hlPEJ051HkM)  
[Handout](https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/blt1ca7d5ec85f98871/62545817d22f554a53ca8a6c/CyberAces_Module1-Windows_1_InstallingWindows.pdf)

#### Introduction to Operating Systems - Installing Windows

* Windows initially released in 1985
* Standard OS for home and business applications
* Runs on servers, desktops, laptops, mobile devices, and embedded devices
* Installed by default on many computers
* Microsoft OS family, server, workstation, IoT, and Mobile (deprecated)
* Exercise uses Windows 10 Enterprise
* Using Windows 10 Enterprise because it is used by majority of enterprises
* Not free, trial version lasts 90-days
* No license required for exercise
* Download the software, create a VM, install Windows 10, and patch OS
* [Windows ISO](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-10-enterprise)
* Use VM Fusion
* Change disk size to a minimum of 20GB (recommended minimum)
* Play VM. Build complete.
* Boot from the CD/DVD image
* Select region and keyboard layout (keyboard layout most important)
* Select domain join, do not use Microsoft account
* Use username of `student` and select password and security questions.
* No help needed from the digital assistant.
* Lock down privacy settings
* 90 days until license expires

### Patching and Updating Windows
[Tutorial Video](https://youtu.be/reTZ24w-ars)  
[Handout](https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/blt2b92c21dd7dc0397/6254581101fc7752fb532cbf/CyberAces_Module1-Windows_2_Patching.pdf)

* An important step to keep your systems secure is to install the latest patches
* Microsoft releases patches on the second Tuesday of each month
* Sometimes new patches get released outside normal cycle
* Gives system administrators some predictability
* Bad guys make money off of exploited systems
* Staying up-to-date with patches is increasingly important
* Important to patch vulnerabilities as fast as possible
* Make sure system configures and downloads updates automatically
* Receive updates for other Microsoft products besides Windows
* Search for updates, 'Check for Updates' and apply
* Reboot and repeat until no new updates required

### Command Line Basics
[Tutorial Video](https://youtu.be/_82XgpupKeo)  
[Handout](https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/bltb533842e9738e39a/6254580d98a5e44ea7851705/CyberAces_Module1-Windows_3_CommandLineBasics.pdf)  

* Attackers rarely have access to the GUI
* Most have access to command shell
* Defenders, command line is faster, easier to automate, and can be scripted
* Launched via `cmd.exe`
* Powershell `powershell.exe`
* List files and directories with `dir`
* Look for hidden files `dir /ah`
* Change drive or director with `c:` and `cd`
* Create a directory with `md`, remove directory `rd`
* `del` `copy` `ren` is rename, view type with `type`, make a file hidden `attrib a.txt +h` or `attrib a.txt -h`
* List running processes with `tasklist`
* Terminate running process with `taskkill` (Process ID) or /IM (image name)
* `ipconfig` network config
* `netstat` active network connection, listen to ports `-a`, process id `-o`
* `ping` and `tracert` network command line operations

### File System
[Tutorial Video](https://youtu.be/Zvsv46_x4Jk)    
[Handout](https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/blta390a061069afd9e/6254580c7e7b344b2534e42d/CyberAces_Module1-Windows_4_FileSystem.pdf)

* Drive hosting typically on C:
* Root folder is C:\ (backslash - Windows, forward slash Linux)
* Removeable media D:, E:, and so on
* Network resources can be mapped to drive letters
* Applications are in C:\Program Files (64-bits)
* Applications are 32-bits in C:\Program Files (x86)
* C:\Users
* Who the heck has Windows XP?
* Default user directories are pretty straightforward
* AppData is a hidden folder in home directory. A lot of applications store data here.
* Alternate Data Stream (ADS) First used by Apple. Originally used to store metadata.
* Internet Explorer attaches "Zone.identifier" to each file downloaded from the internet
* Most applicatiosn will ignore ADS
* Attackers can use it to hide files
* Warning - This file was downloaded from the internet
* `echo I need to hide this > hideme.txt`
* `type hideme.txt`
* `type hideme.txt > logo.png:myads.txt`
* Delete the original file `del hideme.txt`
* `dir /r` to identify alternate data streams
* `more < c:\main.txt:strm.txt` allows you to view the alternate data stream
* Mandatory Integrity Controls. Prevents one trust level from modifying those of another.
* System, High, Medium, Low integrity levels
* Lower trust cannot modify higher trust
* DACL (Discretionary Access Control List) (Read, Write, Full Control, Read & Execute, Modify)
* DACLs are independent of each other
* Each object has an owner who can always modify permission and access
* Inherited permissions, permissions cascade down. 
* Allow vs. Deny
* Permissions Precedence - Explicit Deny, Allow, Inherited Deny, Inherited Allow (Strongest to weakess)

### Users and Groups
[Tutorial Video](https://youtu.be/zpzjY_Dzzl4)  
[Handout](https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/bltcc3635fed191304c/62545810d22f554a53ca8a68/CyberAces_Module1-Windows_5_UsersAndGroups.pdf)

* Newer versions of Windows have made it more difficult to get to the user management interface
* `LUSRMGR.MSC` to get quick access
* `NET USER` from the command line
* Need elevated permissions to modify users, "Run as Administrator"
* A lot of options for adding users via Net User
* `net user shemp * /add` will prompt for a password
* `net user larry /delete` to delete with `/active:no /active:yes` disabled, enabled
* `net accounts` basic account permissions 
* Windows Groups
* Administrators have full control over the file system
* Network Configuration Operators
* Users `netlocalgroup [group name] /add /del`
* RUNAS to be run as another user 
* `runas /user:john_admin secpol.msc` (Prompt for other user's credentials)
* User Account Control (Access is split into two tokens)

### Policies and Credential Storage
[Tutorial Video](https://youtu.be/4Gc81jPfiG8)
[Handout](https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/bltc4c971e230183655/62545817e4b2fd4fda37ab8d/CyberAces_Module1-Windows_6_PoliciesAndCredStorage.pdf)

* Credentials are stored in the SAM Security Accounts Manager
* Stores usernames and password "hashes"
* Need elevated permissions to access SAM
* Part of the registry C:\Windows\System32\config
* Stores users password in two formats LANMAN(LM) and NT hashes (also known as NTLM)
* LM is unsecure and not used in later Windows editions
* `fgdump` `pwdump` `Metasploit`
* Tools for brute-force with `John the Ripper` `HashCat` (Most commonly used)
* Mimikatz can retrieve clear text credentials from RAM without cracking!
* Windows added protection to Windows 10 and later editions to mitigate Mitikatz
* User Rights & Security Permissions
* Audit Policy, User Rights, Security Options
* Local Security Policy MMC `secpol.msc`
* Logs are viewable with event viewer
* Security Policy - User Rights
* Security Policy - Security Options
* Password expiration, minimum password length, password complexity requirement
* Every Windows account has Administrator account

### Registry
[Tutorial Video](https://youtu.be/4vkUkhU1-xE)  
[Handout](https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/bltd8270bc0d5b88826/62545805d22f554a53ca8a64/CyberAces_Module1-Windows_7_Registry.pdf)

* Stored in a binary format, faster parsing than text files, strongly typed data
* Must edit with special programs `REGEDIT.EXE` `REG.EXE` or Windows API
* `HKEY_Local_Machine (HKLM)`
* `HKEY_Users (HKU)`
* `HKEY_Current_User (HKCU)`
* `HKEY_Current_Config (HKCC)`
* `HKEY_Classes_Root (HKCR)`
* `REG_SZ, REG_MULTI_SZ, REG_DWORD, REG_BINARY`
* `reg /?` look at options to modify registry
* `reg query hkcu`

### Networking and Sharing
[Tutorial Video](https://youtu.be/OrMXwdcGzls)  
[Handout](https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/bltd4c91ae34e9fe150/625458168159d551ca3b4642/CyberAces_Module1-Windows_8_Net.pdf)

* Server Message Block (SMB) to share files, printers, and other resources
* `net view \\servername` (whack whack)
* `net use /?` mounts or connects to remote shares
* `net use z: \\srvr\pub * /user:john`
* `net use z: /delete` or delete mapping `net use \\srvr\sharename /delete`

### Services and Processes
[Tutorial Video](https://youtu.be/DNixle0yguk)  
[Handout](https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/blt0af0b418703ed887/62545811c9aa404b76ddc22b/CyberAces_Module1-Windows_9_ServicesAndProcesses.pdf)  

* Windows services run in the background, can be configured to start automatically on boot
* Managed via `services.msc` snap-in
* `NET START` and `NET STOP` can manipulate services.
* `SC` is another tool
* Automatic, manual, disabled, and automatic (delayed) speeds boot time
* `sc query` services controller 
* `sc query` only shows running
* `sc query start= inactive` spacing is critical (crazy stupid syntax)
* `sc query state= all` all running and disabled services available
* `sc qc spooler`
* Services Snap-In GUI
* `sc config spooler start= auto`
* Processes (Application), applications usually interact with the user
* GUI Management `taskmgr.ext`
* Command line management allows scripting, enable and kill processes from the command line
* Speed and automation versus slower and manual with GUI
* `tasklist` all processes 
* `tasklist /fi "imagename eq calc.exe"`
* Manage processes with `wmic` `wmic process call create calc.exe`
* Remote WMIC with `/node:servername or /node:192.168.1.1`
* Very powerful tool able to run programs on multiple computers
* Scheduled applications `SCHTASKS`. `AT` deprecated.

### Conclusion

I was unable to load Windows 10 Enterprise ISO on my VM Workstation. I was able to follow the exercises and command shell exercises in the last couple of videos, but I could never get past the following error attempting to install and configure automatic updates. I attempted multiple updates and configuration options but could not get past the following, which was extremely frustrating.  

![Install failed](Screenshot%202023-02-13%20212433.png)
