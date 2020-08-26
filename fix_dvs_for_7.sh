#!/bin/bash
# This script will update the ansbile vmware_dvswitch to allow creation
# of version 7.0.0 VDS

FILES="$(find / -name vmware_dvswitch.py 2>/dev/null)"
for file in "$FILES"
do
    sed -i "s/'6.6.0']/'6.6.0', '7.0.0']/g" $file
done