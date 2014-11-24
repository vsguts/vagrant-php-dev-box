
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # config.vm.box = "wheezy32"
  # config.vm.box_url = "http://tools.swergroup.com/downloads/wheezy32.box"

  # config.vm.box = "debian-wheezy72-x64-vbox43"
  # config.vm.box_url = "https://puphpet.s3.amazonaws.com/debian-wheezy72-x64-vbox43.box"

  config.vm.box = "ubuntu/trusty64"

  config.vm.network :forwarded_port, guest: 80, host: 8080 # web-server
  config.vm.network :forwarded_port, guest: 443, host: 8443 # web-server
  config.vm.network :forwarded_port, guest: 3306, host: 3307 # mysql

  config.vm.network :private_network, ip: "192.168.9.9"

  config.vm.synced_folder "~/www", "/var/www",
    :nfs => { :mount_options => ["noac", "sync", "lookupcache=none" ] }

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