cd ~/DevOps-Portfolio/kubespray && \
sudo apt update && \
sudo apt install git python3 python3-pip -y && \
git clone https://github.com/kubernetes-incubator/kubespray.git && \
cd kubespray &&& \
pip install -r requirements.txt