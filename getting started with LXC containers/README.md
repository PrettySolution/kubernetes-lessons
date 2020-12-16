#### requirements
1. $ `sudo apt-get install sshpass python3-venv python3-pip -y`

#### list of commands
1. $ `lsb_release -dirc` - show OS version
1. $ `which lxc` - on Ubuntu 18 is already installed
1. $ `which lxd` - on Ubuntu 18 is already installed
1. $ `dpkg -l | grep lxd` - show versions of packages installed
1. $ `sudo apt-get install lxd` - run if not installed
1. $ `systemctl enable lxd`
1. $ `systemctl start lxd`
1. $ `getent group lxd`
1. $ `gpasswd -a dmx lxd` - Adding user dmx to group lxd
1. $ `lxd init` - init the daemon (select dir)
#### edit default lxd profile
1. $ `lxc profile copy default k8s`
1. $ `lxc profile edit k8s` and add the following to the config section
```
config:
  limits.cpu: "2"
  limits.memory: 2GB
  limits.memory.swap: "false"
  linux.kernel_modules: ip_tables,ip6_tables,netlink_diag,nf_nat,overlay
  raw.lxc: "lxc.apparmor.profile=unconfined\nlxc.cap.drop= \nlxc.cgroup.devices.allow=a\nlxc.mount.auto=proc:rw
    sys:rw"
  security.privileged: "true"
  security.nesting: "true"
```
#### start containers

```shell script
lxc launch ubuntu:18.04 node1 --profile k8s && \
lxc launch ubuntu:18.04 node2 --profile k8s && \
lxc launch ubuntu:18.04 node3 --profile k8s && \
lxc launch ubuntu:18.04 node4 --profile k8s
```
#### configure container
```shell script
cat k8s-config.sh | lxc exec node1 bash && \
cat k8s-config.sh | lxc exec node2 bash && \
cat k8s-config.sh | lxc exec node3 bash && \
cat k8s-config.sh | lxc exec node4 bash
```
1. $ `echo "StrictHostKeyChecking no" > ~/.ssh/config`
#### run for each node
1. $ `sshpass -p kubeadmin ssh-copy-id root@10.146.110.200`

1. $ `git clone -b release-2.14 --single-branch https://github.com/kubernetes-sigs/kubespray.git`
1. $ `cd kubespray`
1. $ `python3 -m venv vevn && source vevn/bin/activate`
1. $ `pip install --upgrade pip && pip install -r requirements.txt`
1. $ `cp -rfp inventory/sample inventory/mycluster`
1. $ `declare -a IPS=(192.168.15.10 192.168.15.11 192.168.15.12 192.168.15.13)`
1. $ `CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}`
1. $ `ansible-playbook -i inventory/mycluster/hosts.yaml -b -u dmx cluster.yml`
1. $ `scp root@192.168.15.10:/etc/kubernetes/admin.conf /root/.kube/config`
