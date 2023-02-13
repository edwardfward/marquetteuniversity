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

### Users and Groups

### Policies and Credential Storage

### Registry

### Networking and Sharing

### Services and Processes
