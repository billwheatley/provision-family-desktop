# provision-family-desktop
Ansible Playbooks to build my "Family" desktop

## Bootstrap

Since vanilla installs of distro don't typically install Ansible or these playbooks, I have created a bash script to automate the install of required software to get started using these playbooks.  This only needs to get run one time in the life of your distro install (unless you undo something this script does).

Bootstrap Functions:

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
curl -s https://raw.githubusercontent.com/billwheatley/provision-family-desktop/master/bootstrap.sh | bash -
```
