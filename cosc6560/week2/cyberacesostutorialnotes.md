# Cyber Aces Ooperating Systems Tutorials - Linux

[SANS Cyber Aces Tutorials](https://www.sans.org/cyberaces/)
[SANS Cyber Aces Tutorial Module 1: Operating Systems](https://www.sans.org/cyberaces/introduction-to-operating-systems/?_ga=2.84156569.1003770690.1675039000-874828486.1675038999)

## VMWare Installation and Configuration
[Video](https://youtu.be/ACHRL-orkAo)  
[Handout](https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/blt5c09750eebfcf1d0/625458ace4b2fd4fda37ab9d/CyberAces_Module1-Linux_1_VMwareInstallation.pdf)

### Notes

* Need to install VMware virtualization software
* Number of other virtualization techgnologies
* Need a lab without affecting host operating system
* Host is operating system running on your machine
* VMs or guest run inside your virtualization technology
* A lot of virtualization technologies out there (Qemu, VirtualBox)
* Videos will not cover Linux or BSD and only support VMware products
* **Installing on Windows** [VMware Player](https://www.vmware.com/go/downloadplayer/)
* Run the setup executable and use default options
* Start VMware Player. Do not need to update to VMware Workstation. 
* VMware Player is free.
* **Installing on Mac** [VMware Fusion](https://vmware.com/fusion)
* Download free trial. VMware Fusion is not a free product but you can use it free for 30-days
* Open .dmg file and install.
* Launch VMware Fusion

## OS Background and Building the Linux VM

[Video](https://youtu.be/GNScr5bRG70)  
[Handout](https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/blt7202dbf5253b086d/625458b3c9aa404b76ddc239/CyberAces_Module1-Linux_2_BuildingTheVM.pdf)

### Notes

* Building the Linux VM
* An operating system is software that manages and controls a computer's core functions
* OS is the interface between the hardware and the end user
* All smart devices have some kind of OS
* Core Tasks
	* Manage the processor
	* Memory management
	* Device management
	* Storage management
	* Application interface
	* User interace
* User mode vs. Kernel Mode
* Kernel is Ring 0
* User is Ring 3 where applications run
* Attackers would love control of Ring 0 or escalate from Ring 3 to Ring 0
* Popular Operating System
	* Microsoft Windowss
	* Linux / BSD (Similar but different, very popular for servers or applicances)
	* Mac OS X
* Linux is an open-source operating system with a kernel based on Unix.
* Linux kernel developed by Linus Torvalds
* Linux is not a complete operating system without user-space utilities
* Linux Distributions (Distro)
	* Fedora (Open-source similar to CentOS)
	* Red Hat (Common in enterprise due to support packages)
	* Ubuntu 
* CentOS is the free clone of Red Hat Enterprise Linux (RHEL)
* CentOS long support cycle (10 years). Support cycle shorter with Ubuntu.
* Download CentOS [CentOS](https://redsiege.com/ca/centos8) (None of these links work)
* *Installation for Mac*
* Add a new VM, select the downloaded ISO, uncheck easy install.
* Customize settings if you want to adjust settings
* Would not advise going any smaller than 10GB
* *Install the Operating System*
* Same steps regardless of virtualization platform
* Nothing new, I've setup 100s of Linux servers with ISOs
* username: cyberaces
* uncheck 'require a password to use this account' only for lab purposes
* do not set the root password
* Agree to the user agreement, finish configuration, and wait for reboot
* Finalize the installation

## Core Commands

[Video](https://youtu.be/RQ-TQRlBNfY)  
[Handout](https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/bltdec2a9cd13ad8ea7/625458b298a5e44ea785170b/CyberAces_Module1-Linux_3_CoreCommands.pdf)

### Notes

* Many differences between Linux distributions
* Core set of commands the same on all Linux distributions, including BSD, and Mac
* Use the `man` command to learn more about a certain command
* Essential Commands
	* `ls` - list files 
	* `cd` - change directory
	* `pwd` - print the current working directory
	* `cp` - copy file 
	* `mv` - move or rename a file
	* `rm` - delete a file
	* `cat` - concatenate to view files
	* `grep` - search for text within a file or STDIN
	* `file` - identify file type (looks for the magic inside the file)
	* `head` - display the first X lines of a file
	* `tail` - display lines at the end of a file 
	* `tail -F` - follow the file, see the last few lines, good for logs
	* `less` - display text from STDIN or a file one screen at a time
	* `ps` - show information on running process
	* `lsof` - list open files
	* `netstat` - look at existing connections
	* `ifconfig` - display information about your network
	* `su` - substitute user (skipping name goes to root, need password)
	* `sort` - sort a file
	* `uniq` - remove duplicate lines from a sorted file or sorted STDIN
	* `chmod` - change the permissions of a file or directory
	* `stat` - view detailed information about a file
	* `ping` - test network connectivity
	* `whoami` - display current username
	* `passwd` - change user password
	* `kill` - used to terminate a process
	* `ln` - create a link to a file or directory
	* `/` - directory separator
	* `\` - escape character
	* `.` - current directory
	* `..` - parent directory
	* `~` - user's home directory
	* `&` - execute a command in the background
	* `*` - represents 0 or more characters
	* `?` - represents a single character
	* `[]` - represents a range of values
	* `;` - command separator
	* `&&` - command separator run sequentially (logical and)
	* `||` - command separator run sequentially (logical or)
	* `STDIN` - Input, file descriptor 0
	* `STDOUT` - Output from command, file descriptor 1	
	* `STDERR` - Error from command, file descriptor 2
	* Need to use number when redirecting `STDERR`
	* `>>` - append to a file
	* `>` - replace file and previous content
	* `command > file 2>&1` - save `STDERR` to `STDOUT`
	* `command < infile > outfile 2>> errorlog`
	* `|` - take output of one command and feed it to another
	* `PATH` - environment variable that determines where the shell looks for executable programs
	* Any executable in the current directory in Linux is not in the `PATH`
	* `./myprog` - to execute program in current directory
	* A number of command shells in Linux. Bash is the most popular. zsh, ksh, etc.

## Users and Groups

[Video](https://youtu.be/Uw7Fr0xOV3U)  
[Handout](https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/blt3f5717350ede5fd4/625458ad02d8144fd4daa9e3/CyberAces_Module1-Linux_4_UsersAndGroups.pdf)

### Notes

* Linux designed to support multi users from the start
* Each user has a UID, username, and home directory
* Root user is special, UID of 0, highest privelages of any user on the file system
* Root home directory is `/root`
* Ill-advised to use `root` in your daily activities
* Each user belongs to at least one group. Private group after username in some distributions
* Any user of the `wheel` group has higher permissions (i.e. root access)
* `useradd [username]` to add a new user (cannot log in until passwd set)
* `passwd [username]` to set a user's password
* `groupadd [name]` to create a new group
* `gpasswd -a [user] [group]` to add a user to a group
* Linux stores user information in `/etc/passwd` and `/etc/shadow`
* Every user can read `/etc/passwd`. Password hashes have been moved to `/etc/shadow`
* Each line `username:password:UID:GID:GECOS:home_dir:shell`. Password usually `x` or `*` using `/etc/shadaow`
* GECOS is a comment field
* Typical shell is `/bin/bash`
* `/etc/shadow` contains username, password hash, and other password info
* `$1$` indicates `MD5` hash
* `$6$` indicates `SHA-512` hash
* `/etc/group` contains a list of groups on the system
* Check `man shadow` for more information
* Group passwords are rarely used
* `su` and `sudo` means substitute user. Need users password unless root.
* Typically have to be member of `wheel` group to use `su`
* `sudo` lets you run a command as a different user
* `sudo` will ask for your password, not root password
* `sudo -i` gets you a full root shell
* If you see a `$`, you are a regular user. `#` is root.
* `grep :0: /etc/passwd` find all accounts with root privileges
* `useradd -u 0 -o` is an override that could create multiple root accounts
* `userdel -rf EvilHacker1` to delete accounts
* Only use elevated permissions when needed

## Applications and Services

[Video](https://youtu.be/x9oLHTKH36I)  
[Handout](https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/blt1d2f7b61847e2cf1/625458a97e7b344b2534e435/CyberAces_Module1-Linux_5_AppsAndServices.pdf)

### Notes

* Two types of software - applications and services
* Applications are software started and interacted with by the user
* Services are software started by the OS that run in the background
* An example of a service or a daemon would be Apache Web Server
* BIOS kicks off the bootloader
* Kernel mounts disks/partitions and start system daemon
* System daemon starts services
* Services are configured using `systemctl`
* Service configuration files are plaintext 'unit' files
* Services can be enabled or disable `systemctl [enable|disable| servicename`
* `systemctl [start|stop|restart|reload] servicename`
* Restart vs. Reload. Restart stops and starts. Reload keep running, reread configuration
* `sudo yum install ntsysv` if you want a GUI
* Disabled just means the service will not launch on boot
* Bad guys can configure own service to start at each boot
* `cat << EOF >>` to type a file in the shell
* `rm /etc/systemd/system/EvilHackerBackdoor.service`

## Files and Permissions

[Video](https://youtu.be/b839Hk_1X6U)  
[Handout](https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/blt5ecbe77a3230f55a/625458abe4b2fd4fda37ab99/CyberAces_Module1-Linux_6_FilesAndPermissions.pdf)

### Notes

* On Linux, directory structure determines where certain files are located
* There are no drive letters on Linux
* Files with a `.` are hidden by default. Viewable using `ls -a`.
* `/bin` & `/usr/bin` contain executable files
* `/sbin` & `/user/sbin` executables typically for root, not for regular users
* `/lib` & `/usr/lib` similar to DLL on Windows
* `/etc` contains most configuration files
* `/usr` contains files for programs installed on the system
* `/usr/local` default for software install from source
* `/var` variable data used by programs, such as logs
* `/tmp` & `/var/tmp` contains temporary files. `/tmp` is cleared regularly. `/var/tmp` is not.
* `/boot` contains kernel and other files for boot
* `/home` contains user's home directory except root `/root`
* `/mnt` & `/media` CDs or DVDs or external drives
* `/dev` contains files that represent hardware devices. Everything in Linux is a file!
* `/proc` files give direct access to system and kernel information
* File permissions in Linux are rather simple 3 x 3 (user, group, other) (write, read, execute)
* View permissions `ls -l`
* `d` is a directory. `-` is a file. `l` is a link.
* User `chmod` to change permissions. `ugo` or `a` for all three
* `chmod o-rwx somefile.txt` remove read, write, and execute from `other`
* Can also specify permissions in octal (r=4, w=2, x=1)  
* `SUID` bit specifies that an executable should run as its owner instead of the user executing it
* `ping` command has SUID to send ICMP packets
* `find / -uid 0 -perm -4000 2>/dev/null` will find all SUID bits on filesystem
* Attackers nest directories, adding spaces to filename, making the name a single space or multiple spaces, add `...`
* Look for weird directories 

## Installing Software

[Video](https://youtu.be/gHdfO-wd3j8)  
[Handout](https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/blt385e8817ca4a7e48/625458acbb3f724c520e8669/CyberAces_Module1-Linux_7_InstallingSoftware.pdf)

### Notes

* Most packages are available on the Internet
* Two different forms - source (requires compiling) and packages (generally distro-specific)
* `./configure && make && sudo make install` is typical for building from source
* Package Mangers
	* Red Hat-based distros use RPM
	* Debian-based distros use APT
	* Much faster than compiling
* `rpm -Uvh NewApplication-3.2.1.rpm` to install on Red Hat-based
* `rpm -e NewApplication` to delete
* `rpm -Va | sort` can help detect tampered files on a Red Hat system
* Linux vendors maintain online repos
* On Red Hat, use `yum`
* `sudo yum install nmap` to install
* `sudo yum erase nmap` to erase
* `yum install` to install from online repo
* `rpm -qa | grep tcpdump` to detect package install in RPM database
* `yum update` updates everything, need to be run as root
* `yum update tcpdump`
* `yum update --exclude tcpdump`
