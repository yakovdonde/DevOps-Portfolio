# Public Download Mirror

The public mirror is useful to make the public resources download quickly in some areas of the world. (such as China).

## Configuring Kubespray to use a mirror site

You can follow the [offline](offline-environment.md) to config the image/file download configuration to the public mirror site. If you want to download quickly in China, the configuration can be like:

```shell
gcr_image_repo: "gcr.m.daocloud.io"
kube_image_repo: "k8s.m.daocloud.io"
docker_image_repo: "docker.m.daocloud.io"
quay_image_repo: "quay.m.daocloud.io"
github_image_repo: "ghcr.m.daocloud.io"

files_repo: "https://files.m.daocloud.io"
```

Use mirror sites only if you trust the provider. The Kubespray team cannot verify their reliability or security.
You can replace the `m.daocloud.io` with any site you want.

## Example Usage Full Steps

You can follow the full steps to use the kubesray with mirror. for example:

Install Ansible according to Ansible installation guide then run the following steps:

```shell
# Copy ``inventory/sample`` as ``inventory/donde-k8s-cluster``
cp -rfp inventory/sample inventory/donde-k8s-cluster

# Update Ansible inventory file with inventory builder
declare -a IPS=(10.10.1.3 10.10.1.4 10.10.1.5)
CONFIG_FILE=inventory/donde-k8s-cluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

# Use the download mirror
cp inventory/donde-k8s-cluster/group_vars/all/offline.yml inventory/donde-k8s-cluster/group_vars/all/mirror.yml
sed -i -E '/# .*\{\{ files_repo/s/^# //g' inventory/donde-k8s-cluster/group_vars/all/mirror.yml
tee -a inventory/donde-k8s-cluster/group_vars/all/mirror.yml <<EOF
gcr_image_repo: "gcr.m.daocloud.io"
kube_image_repo: "k8s.m.daocloud.io"
docker_image_repo: "docker.m.daocloud.io"
quay_image_repo: "quay.m.daocloud.io"
github_image_repo: "ghcr.m.daocloud.io"
files_repo: "https://files.m.daocloud.io"
EOF

# Review and change parameters under ``inventory/donde-k8s-cluster/group_vars``
cat inventory/donde-k8s-cluster/group_vars/all/all.yml
cat inventory/donde-k8s-cluster/group_vars/k8s_cluster/k8s-cluster.yml

# Deploy Kubespray with Ansible Playbook - run the playbook as root
# The option `--become` is required, as for example writing SSL keys in /etc/,
# installing packages and interacting with various systemd daemons.
# Without --become the playbook will fail to run!
ansible-playbook -i inventory/donde-k8s-cluster/hosts.yaml  --become --become-user=root cluster.yml
```

The above steps are by adding the "Use the download mirror" step to the [README.md](../README.md) steps.

## Community-run mirror sites

DaoCloud(China)

* [image-mirror](https://github.com/DaoCloud/public-image-mirror)
* [files-mirror](https://github.com/DaoCloud/public-binary-files-mirror)
