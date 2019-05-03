FROM archlinux/base:latest
LABEL maintainer="lagarde@sjtu.edu.cn"

#ENV DEBIAN_FRONTEND noninteractive
#ENV NOVNC_VERSION 0.6.2
#ENV SCREEN_DIMENSIONS 1024x768x16
#ENV DESKTOP_USERNAME user
ENV VNCPASSWORD password

#INIT
RUN 	pacman-key --init
RUN	pacman-key --populate archlinux 
RUN	pacman -Sy --noconfirm 
RUN	pacman -S --noconfirm archlinux-keyring 
RUN	pacman -Syu --noconfirm 

#INSTALL TIGERVNC
RUN	pacman -S --noconfirm tigervnc xfce4


#base-devel
#RUN	pacman -S --noconfirm base-devel
# x11 etc 
#RUN	pacman -S --noconfirm x11vnc xorg-server xorg-apps xorg-server-xvfb xorg-xinit 
# others
#RUN	pacman -S --noconfirm git tigervnc plasma-meta ttf-dejavu
#RUN	pacman -S --noconfirm supervisor
#RUN	pacman -S --noconfirm tigervnc

# noVNC setup
#WORKDIR /usr/share/
#RUN git clone https://github.com/kanaka/noVNC.git
#WORKDIR /usr/share/noVNC/utils/
#RUN git clone https://github.com/kanaka/websockify

#RUN export DISPLAY=:0.0
#ADD ./supervisord /etc/supervisord.conf
EXPOSE 5900 6080
#RUN useradd -m ${DESKTOP_USERNAME}
#WORKDIR /home/${DESKTOP_USERNAME}
#RUN mkdir /home/${DESKTOP_USERNAME}/.vnc/ && \
#x11vnc -storepasswd ${DESKTOP_USERNAME} /home/${DESKTOP_USERNAME}/.vnc/passwd && \
#    chown -R ${DESKTOP_USERNAME}:${DESKTOP_USERNAME} /home/${DESKTOP_USERNAME}/.vnc && \
#chmod 0640 /home/${DESKTOP_USERNAME}/.vnc/passwd 


COPY ./startxfce.sh /usr/local/bin/startxfce.sh
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
