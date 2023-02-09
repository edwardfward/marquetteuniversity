# Lab Report
### Submitted By: Edward Ward (COSC 6560 701) Thursday, 8 Feb 2023

## Lab Assignment 2

## Purpose/Hypothesis
Take additional steps to secure VMware server by ensuring updates are installed automatically, log files are available for documenting intrusion attempts and other suspicious activity, adding an audit capability, and installing and configuring external monitoring components to better understand the behavior of the system.

## Equipment

For this lab, I used an Apple M1 (Mac OS Ventura 13.2 with 16GB RAM) as my workstation, Safari (version 16.3) to interact with the vSphere web client, and my workstation’s Terminal application to SSH into the Ubuntu 22.04.1 LTS Release 22.04 (64-bit) virtual machine (1 x vCPU, 1GB RAM, 16GB HD).

Here are some additional details on the VMware server:

```bash
edward@vm6560-4:~$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 22.04.1 LTS
Release:	22.04
Codename:	jammy

edward@vm6560-4:~$ uname -a
Linux vm6560-4 5.15.0-58-generic #64-Ubuntu SMP Thu Jan 5 11:43:13 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux

edward@vm6560-4:~$ free
               total        used        free      shared  buff/cache   available
Mem:          992736      191248      107164         548      694324      640968
Swap:        1897468       11612     1885856

edward@vm6560-4:~$ systemctl --type=service --state=running
  UNIT                        LOAD   ACTIVE SUB     DESCRIPTION                                                 
  cron.service                loaded active running Regular background program processing daemon
  dbus.service                loaded active running D-Bus System Message Bus
  getty@tty1.service          loaded active running Getty on tty1
  ModemManager.service        loaded active running Modem Manager
  multipathd.service          loaded active running Device-Mapper Multipath Device Controller
  networkd-dispatcher.service loaded active running Dispatcher daemon for systemd-networkd
  open-vm-tools.service       loaded active running Service for virtual machines hosted on VMware
  packagekit.service          loaded active running PackageKit Daemon
  polkit.service              loaded active running Authorization Manager
  rsyslog.service             loaded active running System Logging Service
  snapd.service               loaded active running Snap Daemon
  ssh.service                 loaded active running OpenBSD Secure Shell server
  systemd-journald.service    loaded active running Journal Service
  systemd-logind.service      loaded active running User Login Management
  systemd-networkd.service    loaded active running Network Configuration
  systemd-resolved.service    loaded active running Network Name Resolution
  systemd-timesyncd.service   loaded active running Network Time Synchronization
  systemd-udevd.service       loaded active running Rule-based Manager for Device Events and Files
  udisks2.service             loaded active running Disk Manager
  unattended-upgrades.service loaded active running Unattended Upgrades Shutdown
  upower.service              loaded active running Daemon for power management
  user@1000.service           loaded active running User Manager for UID 1000
  vgauth.service              loaded active running Authentication service for virtual machines hosted on VMware

LOAD   = Reflects whether the unit definition was properly loaded.
ACTIVE = The high-level unit activation state, i.e. generalization of SUB.
SUB    = The low-level unit activation state, values depend on unit type.
23 loaded units listed.
```

## Procedure and Results
The step-by-step procedures for this lab were outlined in the [Security Monitoring](Security%20monitoring.docx) Word document provided with the assignment.

### 1. Complex Password

I disabled password logons on my server's SSH service to prevent any brute force or dictionary attacks, but I changed my password to a complex 20-character password for this assignment using a combination of alphanumeric, upper and lower case, characters and symbols.

```bash
edward@vm6560-4:~$ passwd
Changing password for edward.
Current password: 
New password: 
Retype new password: 
passwd: password updated successfully
```

### 2. Automatically Install Updates

#### First Experiment

I chose not to install `postfix` and setup email notifications of updates or installs due to the need to store my username and password on a non-secure server. Plus, all of my email accounts have two-factor authentication. I did not want to setup another email account as I already have enough personal, work, and school email accounts to manage. I electecd to use `cron` instead to update and upgrade every evening and export the results to a log file. Here is my `/etc/crontab` configuration:

```bash
edward@vm6560-4:~$ cat /etc/crontab 
# /etc/crontab: system-wide crontab
# Unlike any other crontab you don't have to run the `crontab'
# command to install the new version when you edit this file
# and files in /etc/cron.d. These files also have username fields,
# that none of the other crontabs do.

SHELL=/bin/sh
# You can also override PATH, but by default, newer versions inherit it from the environment
#PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  * user-name command to be executed
17 *	* * *	root    cd / && run-parts --report /etc/cron.hourly
25 6	* * *	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.daily )
47 6	* * 7	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.weekly )
52 6	1 * *	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.monthly )

# Automatic updates

50 1 * * * root /usr/bin/apt update -q -y >> /var/log/apt/cronupdates.log
0  2 * * * root /usr/bin/apt upgrade -q -y >> /var/log/apt/cronupdates.log
```
The server will run `/usr/bin/apt update -q -y` as `root` every morning at 0150 UTC and append `STDOUT` to `/var/log/apt/cronupdates.log`. At 0200 UTC, the server will run `/usr/bin/apt upgrade -q -y` as `root` to perform the upgrades. As I want the updates and upgrades to run automatically, with no user interaction or intervention required, I ensured the `/etc/needrestart/needrestart.conf` file was configured to automatically restart any services after any update:

```bash
# Restart mode: (l)ist only, (i)nteractive or (a)utomatically.
#
# ATTENTION: If needrestart is configured to run in interactive mode but is run
# non-interactive (i.e. unattended-upgrades) it will fallback to list only mode.
#
$nrconf{restart} = 'a';
```

After a couple of days, I reviewed the log generated by `cron`:

```bash
edward@vm6560-4:~$ cat /var/log/apt/cronupdates.log | tail -20
Unpacking openssl (3.0.2-0ubuntu1.8) over (3.0.2-0ubuntu1.7) ...
Setting up openssl (3.0.2-0ubuntu1.8) ...
Processing triggers for man-db (2.10.2-1) ...
Processing triggers for libc-bin (2.35-0ubuntu3.1) ...

Running kernel seems to be up-to-date.

Restarting services...
 /etc/needrestart/restart.d/systemd-manager
 systemctl restart open-vm-tools.service packagekit.service ssh.service (more...)

Service restarts being deferred:
 systemctl restart systemd-logind.service
 systemctl restart user@1000.service

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.
```

#### Second Experiment

The first experiment solution did not seem very elegant, so I continued to research other and better ways to configure unattended security updates, but without sending emails. After some research online, I found the [DigitalOcean How to Keep Ubuntu 20.04 Servers Updated Tutorial](https://www.digitalocean.com/community/tutorials/how-to-keep-ubuntu-20-04-servers-updated) and followed it. Per the DigitalOcean tutorial, "the default configuration of unattended-upgrades will automatically retrieve bug fix and security updates for most of the packages included in the Ubuntu repositories."

```bash
# install unattended-upgrades package
sudo apt update && sudo apt install unattended-upgrades
```
Check the `unattended-upgrades.service` is running.

```bash
edward@vm6560-4:~$ sudo systemctl status unattended-upgrades.service 
● unattended-upgrades.service - Unattended Upgrades Shutdown
     Loaded: loaded (/lib/systemd/system/unattended-upgrades.service; enabled; vendor preset: enabled)
     Active: active (running) since Sat 2023-02-04 19:11:55 UTC; 4 days ago
       Docs: man:unattended-upgrade(8)
   Main PID: 891 (unattended-upgr)
      Tasks: 2 (limit: 1030)
     Memory: 8.0M
        CPU: 51ms
     CGroup: /system.slice/unattended-upgrades.service
             └─891 /usr/bin/python3 /usr/share/unattended-upgrades/unattended-upgrade-shutdown --wait-for-signal
```
I reviewed the `/etc/apt/apt.conf.d/50unattended-upgrades` configuration file in-depth and decided to keep the default settings for now. I commented out the `cron` lines from the first experiment.

```bash
# Automatic updates

# 50 1 * * * root /usr/bin/apt update -q -y >> /var/log/apt/cronupdates.log
# 0  2 * * * root /usr/bin/apt upgrade -q -y >> /var/log/apt/cronupdates.log
```

### 3. Install `fail2ban`

I followed the instructions located at [How to harden a server with fail2ban](https://www.a2hosting.com/kb/security/hardening-a-server-with-fail2ban) provided in the lab procedures. Per the lab procedures, "the `fail2ban` utility monitors server log files for intrusion attempts and other suspicious activity"

Here is a printout of the last 10 lines of my `/var/log/auth.log` for reference before I installed `fail2ban`.

```bash
Feb  9 01:26:04 vm6560-4 sshd[61614]: Received disconnect from 118.194.255.199 port 48298:11: Bye Bye [preauth]
Feb  9 01:26:04 vm6560-4 sshd[61614]: Disconnected from authenticating user root 118.194.255.199 port 48298 [preauth]
Feb  9 01:27:52 vm6560-4 sudo:   edward : TTY=pts/0 ; PWD=/home/edward ; USER=root ; COMMAND=/usr/bin/cat /etc/apt/apt.conf.d/50unattended-upgrades
Feb  9 01:27:52 vm6560-4 sudo: pam_unix(sudo:session): session opened for user root(uid=0) by edward(uid=1000)
Feb  9 01:27:52 vm6560-4 sudo: pam_unix(sudo:session): session closed for user root
Feb  9 01:29:24 vm6560-4 sshd[61626]: Received disconnect from 118.194.255.199 port 26760:11: Bye Bye [preauth]
Feb  9 01:29:24 vm6560-4 sshd[61626]: Disconnected from authenticating user root 118.194.255.199 port 26760 [preauth]
Feb  9 01:30:23 vm6560-4 sudo:   edward : TTY=pts/0 ; PWD=/home/edward ; USER=root ; COMMAND=/usr/bin/vim /etc/crontab
Feb  9 01:30:23 vm6560-4 sudo: pam_unix(sudo:session): session opened for user root(uid=0) by edward(uid=1000)
Feb  9 01:36:26 vm6560-4 sudo: pam_unix(sudo:session): session closed for user root
```
I attempted to install `fail2ban` with the newer Ubuntu package manager `apt` vice `apt-get` but I received numerous timeout and network is unreachable errors.
```bash
sudo apt install fail2ban  # failed
sudo apt-get install fail2ban # worked

# copy configuration file
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

# review head of new configuration file
cat /etc/fail2ban/jail.local | head -10
#
# WARNING: heavily refactored in 0.9.0 release.  Please review and
#          customize settings for your setup.
#
# Changes:  in most of the cases you should not modify this
#           file, but provide customizations in jail.local file,
#           or separate .conf files under jail.d/ directory, e.g.:
#
# HOW TO ACTIVATE JAILS:
```

I reviewed the full configuration file and kept the default configurations per the lab procedure.

### 4. Adding Auditing Capability to Ubuntu

I followed the installation steps at [Linux Hint - Auditd Linux Tutorial](https://linuxhint.com/auditd_linux_tutorial/) to install the `auditd` daemon.

```bash
sudo apt install auditd audispd-plugins
sudo service auditd start
```
Check to verify `auditd` service is installed and running.

```bash
● auditd.service - Security Auditing Service
     Loaded: loaded (/lib/systemd/system/auditd.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2023-02-09 02:17:07 UTC; 1min 1s ago
       Docs: man:auditd(8)
             https://github.com/linux-audit/audit-documentation
    Process: 62934 ExecStart=/sbin/auditd (code=exited, status=0/SUCCESS)
    Process: 62938 ExecStartPost=/sbin/augenrules --load (code=exited, status=0/SUCCESS)
   Main PID: 62935 (auditd)
      Tasks: 2 (limit: 1030)
     Memory: 480.0K
        CPU: 24ms
     CGroup: /system.slice/auditd.service
             └─62935 /sbin/auditd

Feb 09 02:17:07 vm6560-4 augenrules[62948]: enabled 1
Feb 09 02:17:07 vm6560-4 augenrules[62948]: failure 1
Feb 09 02:17:07 vm6560-4 augenrules[62948]: pid 62935
Feb 09 02:17:07 vm6560-4 augenrules[62948]: rate_limit 0
Feb 09 02:17:07 vm6560-4 augenrules[62948]: backlog_limit 8192
Feb 09 02:17:07 vm6560-4 augenrules[62948]: lost 0
Feb 09 02:17:07 vm6560-4 augenrules[62948]: backlog 4
Feb 09 02:17:07 vm6560-4 augenrules[62948]: backlog_wait_time 60000
Feb 09 02:17:07 vm6560-4 augenrules[62948]: backlog_wait_time_actual 0
Feb 09 02:17:07 vm6560-4 systemd[1]: Started Security Auditing Service.
```

Review the `/lib/systemd/system/auditd.service` file to gain familiarity with the new service.

```bash
[Unit]
Description=Security Auditing Service
DefaultDependencies=no
## If auditd is sending or recieving remote logging, copy this file to
## /etc/systemd/system/auditd.service and comment out the first After and
## uncomment the second so that network-online.target is part of After.
## then comment the first Before and uncomment the second Before to remove
## sysinit.target from "Before".
After=local-fs.target systemd-tmpfiles-setup.service
##After=network-online.target local-fs.target systemd-tmpfiles-setup.service
Before=sysinit.target shutdown.target
##Before=shutdown.target
Conflicts=shutdown.target
ConditionKernelCommandLine=!audit=0
Documentation=man:auditd(8) https://github.com/linux-audit/audit-documentation

[Service]
Type=forking
PIDFile=/run/auditd.pid
ExecStart=/sbin/auditd
## To not use augenrules, copy this file to /etc/systemd/system/auditd.service
## and comment/delete the next line and uncomment the auditctl line.
## NOTE: augenrules expect any rules to be added to /etc/audit/rules.d/
ExecStartPost=-/sbin/augenrules --load
#ExecStartPost=-/sbin/auditctl -R /etc/audit/audit.rules
# By default we don't clear the rules on exit. To enable this, uncomment
# the next line after copying the file to /etc/systemd/system/auditd.service
#ExecStopPost=/sbin/auditctl -R /etc/audit/audit-stop.rules
Restart=on-failure
# Do not restart for intentional exits. See EXIT CODES section in auditd(8).
RestartPreventExitStatus=2 4 6

### Security Settings ###
MemoryDenyWriteExecute=true
LockPersonality=true
ProtectControlGroups=true
ProtectKernelModules=true
ProtectHome=true
RestrictRealtime=true

[Install]
WantedBy=multi-user.target
```

### 5. Adding External Monitoring

For this step, we are going to install external monitoring software to enable the SOC (Security Operations Center) to monitor the server. I followed the procedures to monitor and send specific logs to the Splunk server (Splunk Enterprise) in the SOC.

install the Splunk Forwarder package

```bash
wget -O splunkforwarder-8.2.4-87e2dda940d1-linux-2.6-amd64.deb  'https://download.splunk.com/products/universalforwarder/releases/8.2.4/linux/splunkforwarder-8.2.4-87e2dda940d1-linux-2.6-amd64.deb'
Resolving download.splunk.com (download.splunk.com)... 13.249.85.42, 13.249.85.113, 13.249.85.41, ...
Connecting to download.splunk.com (download.splunk.com)|13.249.85.42|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 25948752 (25M) [binary/octet-stream]
Saving to: ‘splunkforwarder-8.2.4-87e2dda940d1-linux-2.6-amd64.deb’

splunkforwarder-8.2.4-87e2dda940d1-linux 100%[==================================================================================>]  24.75M  95.9MB/s    in 0.3s    

2023-02-09 02:27:11 (95.9 MB/s) - ‘splunkforwarder-8.2.4-87e2dda940d1-linux-2.6-amd64.deb’ saved [25948752/25948752]

# Typically never install a .deb package off the internet without verifying its signature
sudo dpkg -i splunkforwarder-8.2.4-87e2dda940d1-linux-2.6-amd64.deb
```

Once installed configure and verify permissions.

```bash
sudo chown -R splunk:splunk /opt/splunkforwarder/
ls -al /opt
drwxr-xr-x  9 splunk splunk 4096 Feb  9 02:28 splunkforwarder
```

Enable Splunk Forwarder on start.

```bash
sudo /opt/splunkforwarder/bin/splunk enable boot-start

(Long License Agreement)

This appears to be your first time running this version of Splunk.

Splunk software must create an administrator account during startup. Otherwise, you cannot log in.
Create credentials for the administrator account.
Characters do not appear on the screen when you type in credentials.

Please enter an administrator username: edwardadmin
Password must contain at least:
   * 8 total printable ASCII character(s).
Please enter a new password: 
Please confirm new password: 
Init script installed at /etc/init.d/splunk.
Init script is configured to run at boot.
```

Start the service.

```bash
sudo /opt/splunkforwarder/bin/splunk start
Splunk> Australian for grep.

Checking prerequisites...
	Checking mgmt port [8089]: open
		Creating: /opt/splunkforwarder/var/lib/splunk
		Creating: /opt/splunkforwarder/var/run/splunk
		Creating: /opt/splunkforwarder/var/run/splunk/appserver/i18n
		Creating: /opt/splunkforwarder/var/run/splunk/appserver/modules/static/css
		Creating: /opt/splunkforwarder/var/run/splunk/upload
		Creating: /opt/splunkforwarder/var/run/splunk/search_telemetry
		Creating: /opt/splunkforwarder/var/spool/splunk
		Creating: /opt/splunkforwarder/var/spool/dirmoncache
		Creating: /opt/splunkforwarder/var/lib/splunk/authDb
		Creating: /opt/splunkforwarder/var/lib/splunk/hashDb
New certs have been generated in '/opt/splunkforwarder/etc/auth'.
	Checking conf files for problems...
	Done
	Checking default conf files for edits...
	Validating installed files against hashes from '/opt/splunkforwarder/splunkforwarder-8.2.4-87e2dda940d1-linux-2.6-x86_64-manifest'
	All installed files intact.
	Done
All preliminary checks passed.

Starting splunk server daemon (splunkd)...  
Done
```

The server is running, now configure the forwarder to send the logs to lab server accepting the logs

```bash
# ip masked for security
sudo /opt/splunkforwarder/bin/splunk add forward-server XXX.XXX.XXX.XXX:PPPP
Splunk username:
Password:
Added forwarding to: XXX.XXX.XXX.XXX:PPPP
```

Forward logs.

```bash
# this log contains many entries reflecting system operations
sudo /opt/splunkforwarder/bin/splunk add monitor /var/log/syslog -index main -sourcetype Systemlogs

# this log contains information about all login attempts
sudo /opt/splunkforwarder/bin/splunk add monitor /var/log/auth.log -index main -sourcetype Authlog

# this log contains information about software installations using the standard package manager (dpkg)
sudo /opt/splunkforwarder/bin/splunk add monitor /var/log/dpkg.log -index main -sourcetype dpkglogs

# by default, this log contains information about events, changes to auditd, all authentication events, changes to sensitive data such as passwords, and incoming and outgoing information to and from the server.
sudo /opt/splunkforwarder/bin/splunk add monitor /var/log/audit/audit.log -index main -sourcetype Auditlog

# restart splunk forwarder after configuration changes
sudo /opt/splunkforwarder/bin/splunk restart
Stopping splunkd...
Shutting down.  Please wait, as this may take a few minutes.

Stopping splunk helpers...

Done.

Splunk> Australian for grep.

Checking prerequisites...
	Checking mgmt port [8089]: open
	Checking conf files for problems...
	Done
	Checking default conf files for edits...
	Validating installed files against hashes from '/opt/splunkforwarder/splunkforwarder-8.2.4-87e2dda940d1-linux-2.6-x86_64-manifest'
	All installed files intact.
	Done
All preliminary checks passed.

Starting splunk server daemon (splunkd)...  
Done
```

## Analysis

Overall, good lab. I did not encounter any issues executing the step-by-step procedures. Securing a production server, outside a complex password, manual security updates, and locking down the SSH daemon, is much more involved than I anticipated. I am confident this lab represents only a fraction of the steps needed to properly configure and secure a production server.  

### `unattended-upgrades`
Configuring and enabling automatic and unattended security updates with `unattended-upgrades` allows system administrators to be more proactive patching vulnerabilities once they are identified and corrected. `unattended-upgrades` can save system administrators a great deal of time and energy. Managing and patching 1000s of servers quickly would be untenable without tools like `unattended-upgrades`. I did not configure the email notifications due to my account requiring two-factor authentication and my general reluctance with saving any password on a machine I do not fully control, but the ability to forward `unattended-upgrades` log files to a remote monitoring servers seems to be the more effective option than email notifications. Again, it would be untenable for a system administrator to receive notification from 1000s of servers.

### `auditd` 
I did not get an opportunity to dig deep into the logs `auditd` generates, but I did read up and learned a great deal about the commands `ausearch` and `aureport` reviewed each command's `man` page to learn more about how each is used and the options available.

```bash
NAME
       aureport - a tool that produces summary reports of audit daemon logs

SYNOPSIS
       aureport [options]

DESCRIPTION
       aureport  is  a tool that produces summary reports of the audit system logs. The aureport utility can also take input from stdin as long as the input is
       the raw log data. The reports have a column label at the top to help with interpretation of the various fields. Except for the main summary report,  all
       reports  have  the  audit  event  number. You can subsequently lookup the full event with ausearch -a event number. You may need to specify start & stop
       times if you get multiple hits. The reports produced by aureport can be used as building blocks for more complicated analysis.
```

```bash
AUSEARCH(8)                                                     System Administration Utilities                                                     AUSEARCH(8)

NAME
       ausearch - a tool to query audit daemon logs

SYNOPSIS
       ausearch [options]

DESCRIPTION
       ausearch  is  a  tool that can query the audit daemon logs based for events based on different search criteria. The ausearch utility can also take input
       from stdin as long as the input is the raw log data. Each commandline option given forms an "and" statement. For example,  searching  with  -m  and  -ui
       means  return  events  that  have both the requested type and match the user id given. An exception is the -m  and -n options; multiple record types and
       nodes are allowed in a search which will return any matching node and record.

       It should also be noted that each syscall excursion from user space into the kernel and back into user space has one event ID that is  unique.  Any  au‐
       ditable event that is triggered during this trip share this ID so that they may be correlated.

       Different  parts of the kernel may add supplemental records. For example, an audit event on the syscall "open" will also cause the kernel to emit a PATH
       record with the file name. The ausearch utility will present all records that make up one event together. This could mean that even  though  you  search
       for a specific kind of record, the resulting events may contain SYSCALL records.

       Also be aware that not all record types have the requested information. For example, a PATH record does not have a hostname or a loginuid.
```

### `fail2ban`

I dove into `fail2ban` to learn more about the command and server configuration files and found a bevy options available to customize `fail2ban` Here are the abbreviated `man` pages I explored. Important to not edit the `jail.conf` file as it may change. Make a copy and edit the copy.

```bash
FAIL2BAN(1)                                                         General Commands Manual                                                         FAIL2BAN(1)

NAME
       fail2ban - a set of server and client programs to limit brute force authentication attempts.

DESCRIPTION
       Fail2Ban consists of a client, server and configuration files to limit brute force authentication attempts.

       The server program fail2ban-server is responsible for monitoring log files and issuing ban/unban commands.  It gets configured through a simple protocol
       by fail2ban-client, which can also read configuration files and issue corresponding configuration commands to the server.
```

```bash
JAIL.CONF(5)                                                         Fail2Ban Configuration                                                        JAIL.CONF(5)

NAME
       jail.conf - configuration for the fail2ban server
```

### `splunkforwader`

The last tool we configured in the lab is perhaps the most intriguing. In addition to forwarding standard log files, this  service could be used by database administrators, application developers, and cybersecurity forensic, etc. to monitor all aspects of a server or an entire data center. The lab mentioned the SOC. I will make it a point to try and visit the SOC the next time I am on campus. As this tool is new to me, I have more research to do.

```bash
/opt/splunkforwarder/bin/splunk --help
Welcome to Splunk's Command Line Interface (CLI).

    Type these commands for more help:

        help [command]             type a command name to access its help page
        help [object]              type an object name to access its help page
        help [topic]               type a topic keyword to get help on a topic
        help commands              display a full list of CLI commands
        help clustering            commands that can be used to configure the clustering setup
        help shclustering          commands that can be used to configure the Search Head Cluster setup
        help control, controls     tools to start, stop, manage Splunk processes
        help datastore             manage Splunk's local filesystem use
        help distributed           manage distributed configurations such as
                                   data cloning, routing, and distributed search
        help forwarding            manage deployments
        help input, inputs         manage data inputs
        help licensing             manage licenses for your Splunk server
        help settings              manage settings for your Splunk server
        help simple, cheatsheet    display a list of common commands with syntax
        help tools                 tools to help your Splunk server
        help search                help with Splunk searches

```

