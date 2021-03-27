#Not stable right now https://bbs.archlinux.org/viewtopic.php?id=263379 so basing on older package
# workaround = install runc if on debian
FROM manjarolinux/base
#FROM archlinux/archlinux:base-devel-20210205.0.15146

RUN pacman -Syu --noconfirm
RUN pacman -Syu --noconfirm sudo
#RUN pacman -Syu --noconfirm pamac
RUN pacman -Syu --noconfirm  manjaro-tools-iso
RUN pacman -Syu --noconfirm  manjaro-tools-pkg
RUN pacman -Syu --noconfirm  git
RUN pacman -Syu --noconfirm  yay

RUN pacman -Syu --noconfirm  snapd
#RUN sudo systemctl enable --now snapd.socket
#RUN sudo systemctl enable --now snapd.socket
#RUN sudo ln -s /var/lib/snapd/snap /snap
#RUN sudo snap install snapd

RUN mkdir /var/lib/manjaro-tools

WORKDIR /root/
RUN git clone https://gitlab.manjaro.org/profiles-and-settings/iso-profiles.git

ENTRYPOINT ["buildiso","-t","/output-volume/"]