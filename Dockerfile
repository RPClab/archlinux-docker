FROM archlinux/base

RUN pacman -Sy && \
pacman -S --noconfirm tigervnc base-devel xorg-server kde-meta
EXPOSE 5901
ENTRYPOINT[/bin/sh]
