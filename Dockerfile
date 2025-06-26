from ubuntu:jammy
#APT_UBUNTU_JAMMY
run apt update \
	&& apt -y install openssh-server nano unzip wget curl psmisc net-tools aria2 \
	&& sed -i 's/.*PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config \
	&& mkdir /run/sshd \
	&& chmod -R 700 /run/sshd \
	&& chown -R root:users /run/sshd \
	&& echo "root:root" | chpasswd \
	&& apt clean \
	&& apt autoremove

copy ./installer /opt/installer

run apt install -y nginx ttyd
run mkdir /opt/filebrowser \
	&& cd /opt/filebrowser\
	&& DOWNLOAD=$(curl -s https://api.github.com/repos/filebrowser/filebrowser/releases/latest | grep browser_download_url |grep linux|grep amd64| grep -v rocm| cut -d'"' -f4) \
	&& aria2c -x 10 -j 10 -k 1M $DOWNLOAD -o linux-amd64-filebrowser.tar.gz \
	&& tar -zxvf linux-amd64-filebrowser.tar.gz \
	&& rm -rf linux-amd64-filebrowser.tar.gz \
	&& ln -s /opt/filebrowser/filebrowser /usr/bin/filebrowser

run set -e \
        && apt install -y language-pack-zh-hans \
        && locale-gen zh_CN.UTF-8 \
        && update-locale LANG=zh_CN.UTF-8 \
        && apt clean

run rm -rf /etc/nginx/sites-enabled/default
add ./NGINX /etc/nginx/sites-enabled/

env ROOT_PASSWORD=
copy ./docker-entrypoint.sh /
run chmod +x /docker-entrypoint.sh
cmd []
volume ["/opt/installer"]
volume ["/workspace"]
entrypoint ["/docker-entrypoint.sh"]
