FROM kalilinux/kali-rolling

RUN apt update \
	&& apt -y install kali-linux-headless \
	&& apt install -y openssh-server \
	&& mkdir -p /var/run/sshd \
	&& sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
	&& sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
	&& sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
	&& echo 'root:toor' | chpasswd 

RUN service ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
