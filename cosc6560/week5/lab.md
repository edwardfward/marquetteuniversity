# Lab Report
### Submitted By: Edward Ward (COSC 6560 701) Sunday, 19 February, 2023 

## Lab Assignment Week 5

## Purpose/Hypothesis
Gain experience with user management on a Linux operating system, define basic user access policy, and develop a basic understanding of SSH (Secure Shell).

## Equipment

For this lab, I used an Apple M1 (Mac OS Ventura 13.2 with 16GB RAM) as my workstation, Safari (version 16.3) to interact with the vSphere web client, and my workstation’s Terminal application to SSH into the Ubuntu 22.04.1 LTS Release 22.04 (64-bit) virtual machine (1 x vCPU, 1GB RAM, 16GB HD).

Here are some additional details on the VMware server:

```bash
edward@vm6560-4:~$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 22.04.2 LTS
Release:	22.04
Codename:	jammy

edward@vm6560-4:~$ uname -a
Linux vm6560-4 5.15.0-60-generic #66-Ubuntu SMP Fri Jan 20 14:29:49 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux

edward@vm6560-4:~$ free
               total        used        free      shared  buff/cache   available
Mem:          992736      206472      347208         692      439056      620140
Swap:        1897468      126604     1770864

edward@vm6560-4:~$ systemctl --type=service --state=running
  UNIT                        LOAD   ACTIVE SUB     DESCRIPTION                >
  auditd.service              loaded active running Security Auditing Service
  containerd.service          loaded active running containerd container runtime
  cron.service                loaded active running Regular background program >
  dbus.service                loaded active running D-Bus System Message Bus
  docker.service              loaded active running Docker Application Containe>
  getty@tty1.service          loaded active running Getty on tty1
  ModemManager.service        loaded active running Modem Manager
  multipathd.service          loaded active running Device-Mapper Multipath Dev>
  networkd-dispatcher.service loaded active running Dispatcher daemon for syste>
  open-vm-tools.service       loaded active running Service for virtual machine>
  packagekit.service          loaded active running PackageKit Daemon
  polkit.service              loaded active running Authorization Manager
  rsyslog.service             loaded active running System Logging Service
  snapd.service               loaded active running Snap Daemon
  splunk.service              loaded active running LSB: Start splunk
  ssh.service                 loaded active running OpenBSD Secure Shell server
  systemd-journald.service    loaded active running Journal Service
  systemd-logind.service      loaded active running User Login Management
  systemd-networkd.service    loaded active running Network Configuration
  systemd-resolved.service    loaded active running Network Name Resolution
  systemd-timesyncd.service   loaded active running Network Time Synchronization
  systemd-udevd.service       loaded active running Rule-based Manager for Devi>
  udisks2.service             loaded active running Disk Manager
  unattended-upgrades.service loaded active running Unattended Upgrades Shutdown
  upower.service              loaded active running Daemon for power management
  user@1000.service           loaded active running User Manager for UID 1000
  vgauth.service              loaded active running Authentication service for >

LOAD   = Reflects whether the unit definition was properly loaded.
ACTIVE = The high-level unit activation state, i.e. generalization of SUB.
SUB    = The low-level unit activation state, values depend on unit type.
27 loaded units listed.
```

## Procedure and Results
Before I create any new users or groups, I want to create a basic user policy for adding, removing, and managing user accounts for the class and define some password requirements to ensure users use strong, secure passwords. 

### User, Group, and Password Policy for `vm6540-4`

* All new students will be assigned to group `students` 
* Passwords  contain a minimum of 12 characters
* Passwords must contain a minimum of one (1) uppercase, one (1) lowercase, one (1) digit, and one (1) special character
* Passwords will be checked and verified against known `cracklib` dictionaries
* Passwords will not contain the user's username
* Passwords cannot contain more than three (3) repeating characters
* Passwords must be changed every 60 days
* Users cannot use any of their last (12) passwords
* New Passwords must have a mininum of four (4) diffrent characters than the previous password
* All new users will expire on the last day of the class
* All users will receive a 7-day notice prior to password expirations
* Password hashed using SHA512 with 15000 rounds

### Implement User, Group, and Password Policy

First step was to install `libpam-pwquality` and edit `/etc/security/pwquality.conf`
```bash
sudo apt install libpam-pwquality
```

Implement password change policy.
```bash
sudo vim /etc/login.defs

# Enable logging of successful logins
#
LOG_OK_LOGINS           yes

# Password aging controls:
#
#       PASS_MAX_DAYS   Maximum number of days a password may be used.
#       PASS_MIN_DAYS   Minimum number of days allowed between password changes.
#       PASS_WARN_AGE   Number of days warning given before a password expires.
#
PASS_MAX_DAYS   60
PASS_MIN_DAYS   0
PASS_WARN_AGE   7

# Max number of login retries if password is bad. This will most likely be
# overriden by PAM, since the default pam_unix module has it's own built
# in of 3 retries. However, this is a safe fallback in case you are using
# an authentication module that does not enforce PAM_MAXTRIES.
#
LOGIN_RETRIES           3

ENCRYPT_METHOD SHA512

#
# Only used if ENCRYPT_METHOD is set to SHA256 or SHA512.
#
# Define the number of SHA rounds.
# With a lot of rounds, it is more difficult to brute forcing the password.
# But note also that it more CPU resources will be needed to authenticate
# users.
#
# If not specified, the libc will choose the default number of rounds (5000).
# The values must be inside the 1000-999999999 range.
# If only one of the MIN or MAX values is set, then this value will be used.
# If MIN > MAX, the highest value will be used.
#
SHA_CRYPT_MIN_ROUNDS 15000
SHA_CRYPT_MAX_ROUNDS 15000
```

Implement password policy.

```bash
sudo vim /etc/security/pwquality.conf

# Configuration for systemwide password quality limits
# Defaults:
#
# Number of characters in the new password that must not be present in the
# old password.
difok = 4
#
# Minimum acceptable size for the new password (plus one if
# credits are not disabled which is the default). (See pam_cracklib manual.)
# Cannot be set to lower value than 6.
minlen = 14
#
# The maximum credit for having digits in the new password. If less than 0
# it is the minimum number of digits in the new password.
# dcredit = 0
#
# The maximum credit for having uppercase characters in the new password.
# If less than 0 it is the minimum number of uppercase characters in the new
# password.
# ucredit = 0
#
# The maximum credit for having lowercase characters in the new password.
# If less than 0 it is the minimum number of lowercase characters in the new
# password.
# lcredit = 0
#
# The maximum credit for having other characters in the new password.
# If less than 0 it is the minimum number of other characters in the new
# password.
# ocredit = 0
#
# The minimum number of required classes of characters for the new
# password (digits, uppercase, lowercase, others).
 minclass = 4
#
# The maximum number of allowed consecutive same characters in the new password.
# The check is disabled if the value is 0.
maxrepeat = 3
#
# The maximum number of allowed consecutive characters of the same class in the
# new password.
# The check is disabled if the value is 0.
# maxclassrepeat = 0
#
# Whether to check for the words from the passwd entry GECOS string of the user.
# The check is enabled if the value is not 0.
# gecoscheck = 0
#
# Whether to check for the words from the cracklib dictionary.
# The check is enabled if the value is not 0.
dictcheck = 1
#
# Whether to check if it contains the user name in some form.
# The check is enabled if the value is not 0.
usercheck = 1
#
# Length of substrings from the username to check for in the password
# The check is enabled if the value is greater than 0 and usercheck is enabled.
# usersubstr = 0
#
# Whether the check is enforced by the PAM module and possibly other
# applications.
# The new password is rejected if it fails the check and the value is not 0.
enforcing = 1
#
# Path to the cracklib dictionaries. Default is to use the cracklib default.
# dictpath =
#
# Prompt user at most N times before returning with error. The default is 1.
retry = 3
#
# Enforces pwquality checks on the root user password.
# Enabled if the option is present.
enforce_for_root
#
# Skip testing the password quality for users that are not present in the
# /etc/passwd file.
# Enabled if the option is present.
# local_users_only
```

### Create `students` Group

Before adding users, I created the group defined in the policy above.

```bash
sudo groupadd -g 10000 students
```

### Check group was created

```bash
sudo tail /etc/group | grep students
students:x:10001:
```

### Create the following users

```bash
cat users.txt
golam
paullin
gu
abualrahi
bruno
velupillaimeikandan
mallett
voudrie
kong
sarumi
```

### Install password generator capable of meeting password requirements

```bash
sudo apt install pwgen
```

Generate secure passwords for each user in `users.txt` using the following script and `pwgen`.

```bash
#!/bin/bash
if [ $# -eq 0 ]; then
  echo "-- createusers [line delimited file of user to create]"
  exit 0
fi

while read user; do
  echo "-----------------------"
  # generate password
  Password=$(pwgen -c -n -y -B -s  14 1)
  echo "User: $user             $Password" >> userpasswords.bin
  useradd -G students -M $user
  echo "User added...set passwd"
done < $1
```

```bash
sudo ./createusers.sh users.txt
```

Set passwords for each user and verify proper group.

```bash
sudo passwd golam
New password: 
Retype new password: 
passwd: password updated successfully

id golam
uid=1002(golam) gid=1002(golam) groups=1002(golam),10001(students)

# remaining students removed for brevity
```

Logon in the user to demonstrate no home directory and ability to login. I had to change my `sshd` config to allow password logons, which I would normally NOT permit. I would secure all of my `sshd` daemons with public / private SSH keys vice passwords.  

I submitted this lab late so I was unable to notify each member of the class via email with their username and password so I demonstrated a logon from my computer using their username.

```bash
ssh golam@134.48.13.234
golam@134.48.13.234's password: 
Welcome to Ubuntu 22.04.2 LTS (GNU/Linux 5.15.0-60-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Mon Feb 20 05:35:00 AM UTC 2023

  System load:                      0.02490234375
  Usage of /:                       82.4% of 9.75GB
  Memory usage:                     35%
  Swap usage:                       0%
  Processes:                        211
  Users logged in:                  1
  IPv4 address for br-16e4b51db574: 10.9.0.1
  IPv4 address for docker0:         172.17.0.1
  IPv4 address for ens160:          134.48.13.234

 * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
   just raised the bar for easy, resilient and secure K8s cluster deployment.

   https://ubuntu.com/engage/secure-kubernetes-at-the-edge

 * Introducing Expanded Security Maintenance for Applications.
   Receive updates to over 25,000 software packages with your
   Ubuntu Pro subscription. Free for personal use.

     https://ubuntu.com/pro

Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.


The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

Could not chdir to home directory /home/golam: No such file or directory
```

Check the authorization logs.

```bash
Feb 20 05:35:00 vm6560-4 sshd[1940]: Accepted password for golam from 184.100.5.251 port 57373 ssh2
Feb 20 05:35:00 vm6560-4 sshd[1940]: pam_unix(sshd:session): session opened for user golam(uid=1002) by (uid=0)
Feb 20 05:35:00 vm6560-4 systemd-logind[828]: New session 4 of user golam.
Feb 20 05:35:00 vm6560-4 systemd: pam_unix(systemd-user:session): session opened for user golam(uid=1002) by (uid=0)
Feb 20 05:35:43 vm6560-4 sshd[2005]: Disconnected from user golam 184.100.5.251 port 57373
Feb 20 05:35:43 vm6560-4 sshd[1940]: pam_unix(sshd:session): session closed for user golam
```

### Delete Student Users

Used the following script to remove all traces of the student users from the system.

```bash
#!/bin/bash
if [ $# -eq 0 ]; then
  echo "-- delusers [line delimited file of user to delete]"
  exit 0
fi

while read -r user; do
  echo "-----------------------"
  deluser --remove-home --remove-all-files "$user" "students"
  echo "$user deleted"
done < "$1"
```
Execute the script.
```bash
sudo ./delusers.sh users.txt 
-----------------------
Removing user `golam' from group `students' ...
Done.
golam deleted
-----------------------
Removing user `paullin' from group `students' ...
Done.
paullin deleted
-----------------------
Removing user `gu' from group `students' ...
Done.
gu deleted
-----------------------
Removing user `abualrahi' from group `students' ...
Done.
abualrahi deleted
-----------------------
Removing user `bruno' from group `students' ...
Done.
bruno deleted
-----------------------
Removing user `velupillaimeikandan' from group `students' ...
Done.
velupillaimeikandan deleted
-----------------------
Removing user `mallett' from group `students' ...
Done.
mallett deleted
-----------------------
Removing user `voudrie' from group `students' ...
Done.
voudrie deleted
-----------------------
Removing user `kong' from group `students' ...
Done.
kong deleted
-----------------------
Removing user `sarumi' from group `students' ...
Done.
sarumi deleted
```

### Add Superuser

Add professor as a extra superuser [account name removed].

```bash
sudo useradd -G sudo [user]
pwgen -c -n -y -B -s  14 1
[redacted]

```