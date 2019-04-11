FROM archlinux/base:latest
LABEL maintainer="lagarde@sjtu.edu.cn"

RUN 	pacman-key --init && \
	pacman-key --populate archlinux && \
	pacman -Sy --noconfirm archlinux-keyring && \
	pacman -Syu --noconfirm && \
	pacman -S --noconfirm base-devel \
	git \
	tigervnc \
	plasma-meta \	
	ttf-dejavu \
	x11vnc \
   	xorg-server \
    	xorg-apps \
    	xorg-server-xvfb \
	xorg-xinit\
# noVNC setup
WORKDIR /usr/share/
RUN git clone https://github.com/kanaka/noVNC.git
#WORKDIR /usr/share/noVNC/utils/
#RUN git clone https://github.com/kanaka/websockify

RUN export DISPLAY=:0.0
COPY supervisord.conf /etc/
EXPOSE 8083
RUN useradd -m user
WORKDIR /home/user
CMD ["/usr/bin/supervisord"]
