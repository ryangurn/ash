# kibanananana
wget https://download.elasticsearch.org/kibana/kibana/kibana-4.0.1-linux-x64.tar.gz
tar xzvf kibana-4.0.1-linux-x64.tar.gz
sudo cp -r kibana-4.0.1-linux-x64/* /var/www/

yum provides \*bin/htpasswd
htpasswd -c /etc/nginx/conf.d/kibana.htpasswd root
htpasswd /etc/nginx/conf.d/kibana.htpasswd root
htpasswd -c /etc/nginx/conf.d/kibana-write.htpasswd root
