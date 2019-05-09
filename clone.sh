#!/bin/bash
vm_number=3
for t in {0..$vm_number};
    do virt-clone -o leap15.1 -n runner0$t --auto-clone;
done
for t in {0..$vm_number};
    do virsh start runner0$t;
done

ansible all -i hosts -m raw -a "zypper install -y python python-xml" -u samsul --become --become-user root --ask-become-pass
