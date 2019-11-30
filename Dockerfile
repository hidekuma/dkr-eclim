FROM ubuntu:18.04
MAINTAINER Hidekuma <d.hidekuma@gmail.com>

RUN apt-get update
RUN apt-get install -y openjdk-8-jdk xvfb build-essential ant maven wget
RUN apt-get install -y gcc make
RUN apt-get install -y python3
RUN apt-get install -y sudo
RUN apt-get install -y git
RUN apt-get install -y software-properties-common \
        zlib1g-dev libssl-dev libreadline-dev libyaml-dev \
        libxml2-dev libxslt-dev sqlite3 libsqlite3-dev \
        byobu curl unzip tree

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.6 2

ENV USER eclim
RUN useradd -ms /bin/bash ${USER} && echo "${USER}:${USER}" | chpasswd && adduser ${USER} sudo

RUN wget -P /opt -O /opt/eclipse.tar.gz \
http://www.mirrorservice.org/sites/download.eclipse.org/eclipseMirror/technology/epp/downloads/release/photon/R/eclipse-jee-photon-R-linux-gtk-x86_64.tar.gz
RUN tar xzvf /opt/eclipse.tar.gz -C /opt

RUN apt-get install -y language-pack-ko
RUN locale-gen ko_KR.UTF-8
RUN update-locale LANG=ko_KR.UTF-8 LC_MESSAGES=POSIX

RUN chown -R eclim:eclim /opt/eclipse
RUN echo "eclim ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN wget -P /home/${USER} https://github.com/ervandew/eclim/releases/download/2.8.0/eclim_2.8.0.bin
RUN chown eclim:eclim ./home/${USER}/eclim_2.8.0.bin


USER ${USER}
WORKDIR /home/${USER}

RUN mkdir /home/${USER}/.vim
RUN chmod 744 /home/${USER}/eclim_2.8.0.bin
RUN /home/${USER}/eclim_2.8.0.bin \
  --yes \
  --eclipse=/opt/eclipse/ \
  --vimfiles=/home/${USER}/.vim \
  --plugins=jdt

COPY ./entrypoint.sh /home/${USER}
RUN sudo chown eclim:eclim /home/${USER}/entrypoint.sh
