FROM archlinux/base

RUN pacman -Sy && \
pacman -S --noconfirm tigervnc base-devel xorg-server plasma-meta
EXPOSE 5901
ENTRYPOINT ["bash"]
