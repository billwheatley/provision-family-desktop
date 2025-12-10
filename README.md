# provision-family-desktop

This is an **EXPERIMENTAL BRANCH** -- BEWARE

Ansible Playbooks to build my "Family" desktop.

With Windows 10 EOL having come to fruition (Oct 14 2025), the old family desktop, lacking a TPM 2.0 chip has no other choice then to get an upgrade to linux! Okay I am aware of the registry hack to get Windows 11 to work (for now) but I am not going there. I will take the excuse when I can to move the family over to linux.

Using Ansible playbooks worked so well for [my own desktops](https://github.com/billwheatley/provision-desktop) it was quicker to copy those playbooks, make some changes then it would have been to manually install and configure the machine on my own.  There is much less of feeling of machine setup lock-in with automation.

## Pre-Reqs

* A basic Debian 13 Installed via iso
  * With KDE Desktop
  * All other DESKTOPs unchecked
  * No Privileged User Account Setup (yet)
* [Bootstrap Script](#bootstrap) run
* (Optional) Any [Local RPMs in the magic directory](#optional-local-rpms)
* Internet Connection *(recommend high bandwidth and large data allowance for initial provisioning)*

### Tested with

* WORK IN PROGRESS : Debian 13 - KDE

*Note: These may work against other similar versions and distros with little or no modification*

## Bootstrap

Since vanilla installs of distro don't typically install Ansible or these playbooks, I have created a bash script to automate the install of required software to get started using these playbooks.  This only needs to get run one time in the life of your distro install (unless you undo something this script does). Additionally Debian doesn't setup privileged users so I also have a script to do that.

Root Bootstap Function:

* Setup a sudo user

Sudo Bootstrap Functions:

* Install Ansible, git, sshpass
* Get these playbooks on your machine
* Ensure "`python`" (without numbers) is in the path for Ansible
* Generate ssh keys for the local user

### Procedure

As your root user do, provide the existing user to make them sudo:

```console
apt-get install -y curl
# TODO When merging change to main branch reference
curl -s https://raw.githubusercontent.com/billwheatley/provision-family-desktop/debian-13/make-sudo.sh | bash -s myUserName

# Reboot The machine - It appears that only a reboot allows the group to take
reboot now
```

Then as your sudo user (do not sudo the call, that is done in the script):

```console
cd ~
mkdir -p ~/dev/ansible-desktop
cd ~/dev/ansible-desktop
# TODO - When merging change to main branch reference
curl -s https://raw.githubusercontent.com/billwheatley/provision-family-desktop/debian-13/bootstrap.sh | bash -
```

## Running

Do the following as your main admin/sudo user (do not sudo the call, that is done in the script):

```console
cd ~/dev/ansible-desktop/provision-family-desktop
./provision-localhost.sh
```

### (Optional) See Execution Options

The script is designed to be run without any options however there are custom behaviors, you can use the `-h` option to see a current list of options:

```console
cd ~/dev/ansible-desktop/provision-family-desktop
./provision-localhost.sh -h
```

## (Optional) Reboot / Restart when these are done

These do not do any automatic reboots of the system. I leave that decision up to the user.  Generally I recommend a reboot after the following:

* Initial provision
* Large package manager update
* Any package update to:
  * The kernel
  * KDE Plasma / QT
  * Core system libraries

Other times a simple restart of the application may be all that is necessary, especially for browser updates (you don't get promoted like Windows or Mac versions for browser restarts)
