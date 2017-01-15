# https://www.digitalocean.com/community/tutorials/an-introduction-to-using-consul-a-service-discovery-system-on-ubuntu-14-04#downloading-and-installing-consul
apt-get update
apt-get install unzip # To unzip consul bundle
apt-get install screen # To start mutiple bash terminal
screen # run screen, Ctlr + A + C (new) Ctrl + A + N (navigate)

# Consul configuration directory
sudo mkdir /etc/consul.d/{boostrap,server,client}

consul agent -server -bootstrap-expect=2 -data-dir=/tmp/consul -node=agent-one -bind=172.31.21.207 -config-dir=/etc/consul.d
