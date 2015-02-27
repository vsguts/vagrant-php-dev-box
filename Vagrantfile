
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "parallels/ubuntu-14.04"

  # config.vm.network :forwarded_port, guest: 80, host: 8080 # nginx
  # config.vm.network :forwarded_port, guest: 443, host: 8443 # nginx ssl
  # config.vm.network :forwarded_port, guest: 81, host: 8081 # apache
  # config.vm.network :forwarded_port, guest: 3306, host: 3307 # mysql

  config.vm.provider "parallels" do |v|
    v.update_guest_tools = true
  end

  config.vm.provider "parallels" do |v|
    v.memory = 512
    v.cpus = 1
  end

  config.vm.host_name = "dev"

  config.vm.network "private_network", ip: "172.17.0.3"

  config.vm.synced_folder "/Users/gvs/Sites/dev", "/var/www/html"
  
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