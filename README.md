## Tutorial References
https://github.com/techiescamp/vagrant-kubeadm-kubernetes
https://www.exxactcorp.com/blog/HPC/building-a-kubernetes-cluster-using-vagrant
https://elroydev.tech/hoc-kubernetes/ <br>
https://elroydev.tech/cach-dung-vagrant-tao-may-ao/
## Prerequisites
### My local enviroment:
Ubuntu 22.04
### Virtualbox
#### Vagrant
```console
sudo apt update && sudo apt upgrade
sudo apt-get -y install vagrant
vagrant --version
```
#### Virtualbox
```console
sudo apt update && sudo apt upgrade
sudo apt install virtualbox
vboxmanage --version
```
> NOTE <br>
> The virtualbox allows the host only networks in range 192.168.56.0/21 <br>
> So run this command to allow networks in any range
```console
sudo mkdir -p /etc/vbox/
echo "* 0.0.0.0/0 ::/0" | sudo tee -a /etc/vbox/networks.conf
```

## Running
```console
vagrant up
```

## Access K8s Cluter without ssh to master node
> Ensure install kubectl in your machine
```console
mkdir -p $HOME/.kube
cp configs/config $HOME/.kube
```
> OR
```
export KUBECONFIG=$(PWD)/configs/config
```
> Now you can manage the cluster in your machine without ssh to kmaster

## Dashboard
```console
source /vagrant/dashboard.sh
```
In your machine
```console
kubectl proxy
```
Access to dashboard
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login

The token is stored in configs folder

## Some issues
### Using ip address of enp0s3 instead of enp0s8
https://github.com/kubernetes/kubernetes/blob/v1.6.2/pkg/kubelet/kubelet_node_status.go#L440

https://github.com/kubernetes/kubernetes/issues/44702#issuecomment-302471161

 the issue is in how kubelet finds its own IP address, not about kube-proxy. So --bind-address won't really work, because that's a kube-proxy option and the proxy is running in a pod that already has the wrong address.

If you're not using a cloud provider, try modifying the kubelet command-line options to pass "--node-ip=" or setting the NodeIP configuration in the kubelet config yaml file.


https://jaanhio.medium.com/how-to-fix-k8s-clusters-network-issue-due-to-nodes-having-similar-internal-ip-address-537b48d47d3

```console
$ sudo su
# echo 'KUBELET_EXTRA_ARGS="--node-ip=192.168.60.2"' >> /etc/default/kubelet
```