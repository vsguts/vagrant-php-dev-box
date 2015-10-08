require "./local_conf.rb" if File.exist?("./local_conf.rb")

INTERNAL_IP      ||= "172.17.0.3"             # IP-address on private interface
PROJECT          ||= "dev"
HOSTNAME         ||= "dev"
RAM              ||= "512"
APPLICATION_PATH ||= "../app"
# PROVISION_TAGS   ||= ""

File.open('./provision/inventory', 'w') { |file|
  file.puts "[vagrant]"
  file.puts INTERNAL_IP
}

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.host_name = PROJECT + '.' + HOSTNAME
  config.vm.network "private_network", ip: INTERNAL_IP

  ENV['VAGRANT_DEFAULT_PROVIDER'] ||= "virtualbox"
  case ENV['VAGRANT_DEFAULT_PROVIDER'].downcase
  when "parallels"

    config.vm.box = "parallels/ubuntu-14.04"
    config.vm.synced_folder APPLICATION_PATH, "/var/www/html"
    config.vm.provider "parallels" do |v|
      v.memory = RAM
      v.cpus = 1
      # v.update_guest_tools = true
    end

  else

    config.vm.box = "ubuntu/trusty64"

    config.vm.synced_folder APPLICATION_PATH, "/var/www/html", type: "nfs", mount_options: ['rw', 'vers=3', 'tcp', 'fsc']
    # :mount_options => ["udp", "dmode=775", "fmode=774", "uid=33", "gid=33", "noac", "sync", "lookupcache=none" ]
    # :mount_options => ["noac", "sync", "lookupcache=none" ]
    config.nfs.map_uid = Process.uid
    config.nfs.map_gid = Process.gid

    config.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.customize [
        'modifyvm', :id,
        '--memory', RAM,
        '--name',   PROJECT + '.' + HOSTNAME
      ]
    end
  end
  
  config.vm.provision :ansible do |ansible|
    if(defined? PROVISION_TAGS)
      ansible.tags = PROVISION_TAGS
    end
    ansible.limit = "vagrant"
    ansible.playbook = "provision/playbook.yml"
    ansible.inventory_path = "provision/inventory"
    ansible.extra_vars = {
      hostname: HOSTNAME,
    }
  end

end

# To enable web server on host machine, you may use one of several ways:
# 1. Use directly http://localhost:8080/

# 2. Apache-proxy. Add to /etc/apache2/httpd.conf:
# <Location />
#     ProxyPass http://localhost:8080/
# </Location>
# ProxyPreserveHost On

# 3. ipfw-forwarding. Add rules:
# sudo ipfw add 100 fwd 127.0.0.1,8080 tcp from any to me 80
# sudo ipfw add 101 fwd 127.0.0.1,8443 tcp from any to me 443
# P.S.: remove rules:
# sudo ipfw delete 100
# sudo ipfw delete 101
# P.S.S. Autoload in /etc/ipfw.conf
