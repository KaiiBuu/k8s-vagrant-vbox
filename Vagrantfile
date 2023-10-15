Vagrant.configure(2) do |config|
    ## Run common setup of k8s master and node
    config.vm.provision "shell", path: "bootstrap.sh"

    # Kubernetes Master Server
    config.vm.define "kmaster" do |kmaster|
        kmaster.vm.box = "ubuntu/focal64"
        kmaster.vm.hostname = "kmaster.lab.com"
        kmaster.vm.network "private_network", ip: "10.32.3.180"
        kmaster.vm.provider "virtualbox" do |v|
            v.name = "kmaster"
            v.memory = 4096
            v.cpus = 2
        end
        kmaster.vm.provision "shell", path: "bootstrap_kmaster.sh"
    end

    NodeCount = 2

    # Kubernetes Worker Nodes
    (1..NodeCount).each do |i|
        config.vm.define "kworker#{i}" do |workernode|
            workernode.vm.box = "ubuntu/focal64"
            workernode.vm.hostname = "kworker#{i}.lab.com"
            workernode.vm.network "private_network", ip: "10.32.3.18#{i}"
            workernode.vm.provider "virtualbox" do |v|
                v.name = "kworker#{i}"
                v.memory = 2048
                v.cpus = 1
            end
            workernode.vm.provision "shell", path: "bootstrap_kworker.sh"
        end
    end

end