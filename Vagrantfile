
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network :forwarded_port, guest: 80, host: 8080 # nginx
  config.vm.network :forwarded_port, guest: 443, host: 8443 # nginx ssl
  config.vm.network :forwarded_port, guest: 8081, host: 8081 # apache
  config.vm.network :forwarded_port, guest: 3306, host: 3307 # mysql

  config.vm.network :private_network, ip: "192.168.9.9"

  config.vm.synced_folder "~/www", "/var/www", type: "nfs", mount_options: ['rw', 'vers=3', 'tcp', 'fsc']
  config.nfs.map_uid = Process.uid
  config.nfs.map_gid = Process.gid
  
  config.vm.provision :shell, :path => "bootstrap.sh"

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