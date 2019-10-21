# vsphere-nsx-lab-deploy
Ansible playbook to automate deployment of vCenter, nested ESXi hosts

# Fork
Cut down features to build a single host with 1 local disk and 3 networks for a single node NSX-T install.
Main differences to upstream masters:
- Sped up with async tasks to build hosts and vCenter in parallel. 
- Added support for vSphere 6.7. 
- Switched to deploy the vCenter to another vCenter (may add ESXi host support back later). 
- Removed options for external PSC topologies as EOL feature and removed 6.0 code.
- Updated Ansible playbook to remove features which will be depricated.
- Refactored prepare ISO to not need root and dynamically generate the KS file

Validated on Ubuntu 16.04 with Ansible 2.7.

## Fork Todo
Fix prepare_iso task so that a proper error is generated if the ISO is in use.


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

apt-get install sshpass python-pip git <br/>
pip install pyvmomi <br/>
git clone https://github.com/yasensim/vsphere-nsx-lab-deploy.git <br/>

Place the ESXi and VCSA ISOs in /root/ISOs <br/>


### Edit answersfile.yml

Edit answersfile.yml according to your infrastructure!

## Usage

ansible-playbook deploy.yml


## Limitations
Ansible => 2.7 is required <br/>
ESXi version 6.0 and above is supported <br/>
VCSA version 6.0U2 and above is supported <br/>

## Development
TODO: External PSC for vSphere 6.5
VMware internal

