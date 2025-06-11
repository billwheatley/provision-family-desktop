# provision-family-desktop

Ansible Playbooks to build my "Family" desktop.

With Windows 10 EOL approaching (Oct 14 2025), the old family desktop, lacking a TPM 2.0 chip has no other choice then to get an upgrade to linux! Okay I am aware of the registry hack to get Windows 11 to work (for now) but I am not going there. I will take the excuse when I can to move the family over to linux.

Using Ansible playbooks worked so well for [my own desktops](https://github.com/billwheatley/provision-desktop) it was quicker to copy those playbooks, make some changes then it would have been to manually install and configure the machine on my own.  Plus it gives me ability to distro hop or switch to different base versions of OpenMandriva easier. There is much less of feeling of machine setup lock-in with automation.

## Pre-Reqs

* A basic OpenMandrivaLx distro install via iso
* [Bootstrap Script](#bootstrap) run
* (Optional) Any [Local RPMs in the magic directory](#optional-local-rpms)
* Internet Connection *(recommend high bandwidth and large data allowance for initial provisioning)*

### Tested with

* OpenMandrivaLx: AMD | Wayland | Plasma 6 | Rome 2025-05-05 Shanpshot iso

*Note: These may work against other similar versions and distros with little or no modification*

## Bootstrap

Since vanilla installs of distro don't typically install Ansible or these playbooks, I have created a bash script to automate the install of required software to get started using these playbooks.  This only needs to get run one time in the life of your distro install (unless you undo something this script does).

Bootstrap Functions:

* Enable Extended OpenMandriva dnf Repos
  * Works with both x86_64 and zenver (AMD) type repos
* Install Ansible, git, sshpass, and GNU Tar (for Ansible)
* Get these playbooks on your machine
* Ensure "`python`" (without numbers) is in the path for Ansible
* Generate ssh keys for the local user

### Procedure

As your main admin/sudo user (do not sudo the call, that is done in the script):

```console
cd ~
mkdir -p ~/dev/ansible-desktop
cd ~/dev/ansible-desktop
curl -s https://raw.githubusercontent.com/billwheatley/provision-family-desktop/main/bootstrap.sh | bash -
```

## (Optional) Local RPMs

Sometimes we have those random `rpms` that are not in public repos mostly because of distribution restrictions. Short of private yum repos or a direct predicable public URL to download from, an easy solution is maintaining a local directory of these is just to drop these into a folder and this will pick up and install them.

Place your `rpms` in `$HOME/automated-install/rpm/`

If you have dependent `rpms` make sure they are also in the dir, these will be installed in a single command and `dnf` will figure out the dependencies. If your dependencies are packages in repos make sure those are added to one of the package repos. Those will be run before this.

This directory is not required if you have no `rpms` outside a repo.

NOTE: if there is a long lived public URL to pull that rpm down from, placing the rpm url in [vars/remote-non-repo-rpms.yaml](vars/remote-non-repo-rpms.yaml) maybe preferable and easier to maintain.

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
