# Install Openssh server
echo "[TASK 6] Install and configure ssh"
sed -i 's/.*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/.*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl restart sshd >/dev/null 2>&1


# Set Root password
echo "[TASK 7] Set root password"
echo -e "kubeadmin\nkubeadmin" | passwd "root"


