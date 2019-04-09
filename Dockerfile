FROM archlinux/base

COPY run_vnc.sh /run_vnc.sh
COPY xinitrc /xinitrc

RUN 	echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen && \
	echo 'Server = https://mirrors.kernel.org/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist && \
	pacman-key --init && \
	pacman-key --populate archlinux && \
	pacman -Syu --noconfirm && \
	pacman -S --noconfirm tigervnc base-devel xorg-server mesa-vdpau libva-mesa-driver rrdtool xorg-xinit git gtk3 gtk2 cmake clang root xrootd plasma-meta && \
	pacman -Scc --noconfirm 
EXPOSE 5901
ENTRYPOINT ["/run_vnc.sh"]
