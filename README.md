# vsphere-lab-deploy
Ansible playbook to automate deployment of vCenter, nested ESXi hosts

## Description

This repository will be used to hold an Ansible Playbook to deploy and configure vCenter and nested ESXi VMs 

## Breaking Changes
The playbooks and the answerfile has been refactored to make them more flexible. The previous versions are available on the `pre-refactor` branch. You must update your answer file following the example to use the playbooks. Note the updated playbooks require an extra vsphere sdk to be installed.

# Table of Contents

- [vsphere-lab-deploy](#vsphere-lab-deploy)
  - [Description](#description)
  - [Breaking Changes](#breaking-changes)
- [Table of Contents](#table-of-contents)
- [Fork Differences](#fork-differences)
  - [Fork Todo](#fork-todo)
- [Setup](#setup)
  - [Dependencies](#dependencies)
  - [Edit answersfile.yml](#edit-answersfileyml)
  - [Usage](#usage)
- [Limitations](#limitations)

# Fork Differences
Cut down features to build a single host with 1 local disk and 3 networks for a single node NSX-T install.
Main differences to upstream masters:
- Sped up with async tasks to build hosts and vCenter in parallel. 
- Added support for vSphere 7.0. 
- Switched to deploy the vCenter to another vCenter only (may add ESXi host support back later). 
- Removed options for external PSC topologies as EOL feature and removed 6.0 code.
- Updated Ansible playbook to remove Ansible features which will be depricated.
- Refactored prepare ISO to not need root and dynamically generate the KS file
- Refactored answers and playbook to simplify deployment
- Removed all VSAN tasks

## Fork Todo
- Fix prepare_iso task so that a proper error is generated if the ISO is in use.
- Awaiting Ansible 2.10 to allow datastore tagging and creation of storage profiles for vSphere 7 with K8s.

# Setup

Validated on Ubuntu 16.04 and 20.04 deploying vSphere 6.7 and vSphere 7.0

## Dependencies
Assuming running from a debian based system.
- Ansible must be 2.9 or higher with python3
- `apt-get install xorriso sshpass python-pip git`
- `pip3 install pyvmomi`
- Install [vSphere Automation SDK](https://github.com/vmware/vsphere-automation-sdk-python)
    `pip install --upgrade pip setuptools`
    `pip install --upgrade git+https://github.com/vmware/vsphere-automation-sdk-python.git`
- `git clone https://github.com/laidbackware/vsphere-nsx-lab-deploy.git`
- 

Place the ESXi and VCSA ISOs in the directory matching the yaml <br/>

## Edit answersfile.yml

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

# Limitations
Ansible => 2.9 is required <br/>
ESXi version 6.7 and above is supported <br/>
VCSA version 6.7 and above is supported <br/>