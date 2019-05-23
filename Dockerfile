FROM archlinux/base:latest
LABEL maintainer="lagarde@sjtu.edu.cn"

#ENV DEBIAN_FRONTEND noninteractive
#ENV NOVNC_VERSION 0.6.2
#ENV SCREEN_DIMENSIONS 1024x768x16
ENV DESKTOP_USERNAME rpclab
ENV VNCPASSWORD password
ENV ROOTPASSWORD root
ENV TIMEZONE Asia/Shanghai

RUN echo -e "${ROOTPASSWORD}\n${ROOTPASSWORD}" | passwd root

#INIT
RUN 	pacman-key --init
RUN	pacman-key --populate archlinux 
RUN	pacman -Sy --noconfirm 
RUN	pacman -S --noconfirm archlinux-keyring 
RUN	pacman -Syu --noconfirm 

#base-devel
RUN	pacman -S --noconfirm base-devel git cmake x11vnc xorg-server xorg-apps xorg-server-xvfb xorg-xinit root tigervnc xfce4 tzdata

# timezone
RUN ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime

# noVNC setup
WORKDIR /usr/share/
RUN git clone https://github.com/kanaka/noVNC.git
WORKDIR /usr/share/noVNC/utils/
RUN git clone https://github.com/kanaka/websockify

#RUN export DISPLAY=:0.0
#ADD ./supervisord /etc/supervisord.conf

# DIM_DNS_PORT
EXPOSE 2505
EXPOSE 5100-6000
RUN useradd -m ${DESKTOP_USERNAME}
RUN echo -e "${VNCPASSWORD}\n${VNCPASSWORD}" | passwd ${DESKTOP_USERNAME}

COPY ./startxfce.sh /usr/local/bin/startxfce.sh
RUN chmod a+rwx /usr/local/bin/startxfce.sh
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod a+rwx /usr/local/bin/entrypoint.sh

USER ${DESKTOP_USERNAME}
WORKDIR /home/${DESKTOP_USERNAME}

RUN mkdir -p /home/${DESKTOP_USERNAME}/.vnc/
RUN echo "${VNCPASSWORD}" | vncpasswd -f > "/home/${DESKTOP_USERNAME}/.vnc/passwd"
RUN chown -R ${DESKTOP_USERNAME}:${DESKTOP_USERNAME} /home/${DESKTOP_USERNAME}/.vnc
RUN chmod 0640 /home/${DESKTOP_USERNAME}/.vnc/passwd 





ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
