# DevOps-Portfolio
In order to use Kubespray to install Kubernetes Cluster you need:

    - A machine with kubespray supported ansible version installed
        (You can use Scripts/ansible-install.sh script to install the latest version of ansible)
    - At list 1 fresh Ubuntu server for Kubernetes master (3 servers are advised)
    - At list 1 fresh Ubuntu server for Kubernetes worker (as many as you want)
    - Make sure your Ubuntu servers where you are going to install Kubernetes (targets) are reachable from your Ansible machine
        it is also suggested to have target hostnames are resolvable from your Ansible machine.

    - Passwordless SSH from your Ansible machine to your targets
        you can use Scripts/ssh_copy_id.sh script

    - Optional:
        - Make all your Servers have passwordless sudo
            You can use Scripts/passwordless-sudo.sh script for that
        - Set Timezone and Locale on all your servers
            You can use Scripts/timezone-locale.sh script for that

     - Configure your Ansible host with all needed libraries:
        You can use Scripts/ansible-host-config.sh script for that

     - Create your Ansible inventory:
        - Copy the example inventory folder:
                command:  cp -fpr ~/DevOps-Portfolio/kubespray/inventory/sample/  ~/DevOps-Portfolio/kubespray/inventory/<mycluster>
        - Adjust the ~/DevOps-Portfolio/kubespray/inventory/<mycluster>/inventory.ini with your inventory (you can use inventory/inventory.ini file as an example)