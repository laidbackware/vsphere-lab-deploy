# vsphere-nsx-lab-deploy
Ansible playbook to automate deployment of vCenter, nested ESXi hosts

# Fork
Cut down features to build a single host with 1 local disk and 3 networks for a single node NSX-T install.
Main differences to upstream masters:
- Sped up with async tasks to build hosts and vCenter in parallel. 
- Added support for vSphere 7.0. 
- Switched to deploy the vCenter to another vCenter only (may add ESXi host support back later). 
- Removed options for external PSC topologies as EOL feature and removed 6.0 code.
- Updated Ansible playbook to remove Ansible features which will be depricated.
- Refactored prepare ISO to not need root and dynamically generate the KS file

Validated on Ubuntu 16.04 with Ansible 2.9.

## Fork Todo
Fix prepare_iso task so that a proper error is generated if the ISO is in use.
Add back ability to create more than 1 disk.


# Table of Contents

- [vsphere-nsx-lab-deploy](#vsphere-nsx-lab-deploy)
- [Fork](#fork)
  - [Fork Todo](#fork-todo)
- [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [Setup](#setup)
    - [Dependencies](#dependencies)
    - [Edit answersfile.yml](#edit-answersfileyml)
  - [Usage](#usage)
  - [Limitations](#limitations)
  - [Development](#development)

## Description

This repository will be used to hold an Ansible Playbook to deploy and configure vCenter and nested ESXi VMs 

## Setup

Validated on Ubuntu 16.04 and 18.04 deploying vSphere 6.5 and vSphere 6.7

### Dependencies

apt-get install xorriso sshpass python-pip git <br/>
pip install pyvmomi <br/>
git clone https://github.com/yasensim/vsphere-nsx-lab-deploy.git <br/>

Place the ESXi and VCSA ISOs in the directory matching the yaml <br/>


### Edit answersfile.yml

Edit answersfile.yml according to your infrastructure!

## Usage

```
export PARENT_VCENTER_USERNAME="administrator@vsphere.local"
export PARENT_VCENTER_PASSWORD="VMware1!"
TMPDIR=$(mktemp -d) || exit 1
echo "Temp dir is ${TMPDIR}"

# Customize ESXi ISO and upload the the datastore to be used. Run once per version of the ISO.
ansible-playbook playbooks/prepare_esxi_iso_installer.yml \
    --extra-vars="@answerfile.yml" --extra-vars "tmp_dir=${TMPDIR}"

# Deploy vCenter and host/s
ansible-playbook deploy.yml --extra-vars="@answerfile.yml"  --extra-vars "tmp_dir=${TMPDIR}"
```

## Limitations
Ansible => 2.7 is required <br/>
ESXi version 6.0 and above is supported <br/>
VCSA version 6.0U2 and above is supported <br/>

## Development
TODO: External PSC for vSphere 6.5
VMware internal

