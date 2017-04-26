# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
   config.vm.define "server" do |server|
      server.vm.hostname = "zabbix-server"
      server.vm.box = "centos7min"
      server.vm.network "private_network", ip: "192.168.44.44"
      server.vm.provider "virtualbox" do |vm|
       vm.memory = "3072"
       vm.cpus = "2"
      end
      server.vm.provision "shell", path: "/home/student/monitoring/zabbix/server.sh"
   end

  config.vm.define "agent" do |agent|
      agent.vm.hostname = "zabbix-agent"
      agent.vm.box = "centos7min"
      agent.vm.network "private_network", ip: "192.168.44.45"
      agent.vm.provision "shell", path: "/home/student/monitoring/zabbix/agent.sh"
  end
end
