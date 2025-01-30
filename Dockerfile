from ubuntu:jammy

run apt update \
	&& apt -y install openssh-server nano unzip wget curl psmisc net-tools \
	&& sed -i 's/.*PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config \
	&& mkdir /run/sshd \
	&& chmod -R 700 /run/sshd \
	&& chown -R root:users /run/sshd \
	&& echo "root:root" | chpasswd

copy ./installer /opt/installer

run apt install -y nginx ttyd
run curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash
run mkdir /opt/filebrowser

run rm -rf /etc/nginx/sites-enabled/default
add ./NGINX /etc/nginx/sites-enabled/

copy ./docker-entrypoint.sh /
run chmod +x /docker-entrypoint.sh
cmd []
entrypoint ["/docker-entrypoint.sh"]
