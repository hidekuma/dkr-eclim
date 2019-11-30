FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y openjdk-8-jdk xvfb build-essential
RUN apt-get install -y gcc make
RUN apt-get install -y python3
RUN apt-get install -y sudo

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.6 2

ENV USER eclim
RUN useradd -ms /bin/bash ${USER} && echo "${USER}:${USER}" | chpasswd && adduser ${USER} sudo

ADD ./resource/eclipse-jee-photon-R-linux-gtk-x86_64.tar.gz /opt
RUN chown -R eclim:eclim /opt/eclipse
RUN echo "eclim ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER ${USER}
COPY ./resource/eclim_2.8.0.bin /home/${USER}
COPY ./entrypoint.sh /home/${USER}

RUN mkdir /home/${USER}/.vim
RUN /home/eclim/eclim_2.8.0.bin \
  --yes \
  --eclipse=/opt/eclipse/ \
  --vimfiles=/home/${USER}/.vim \
  --plugins=jdt
#RUN chown -R eclim:eclim /opt/eclipse

EXPOSE 9091
#CMD ['~/entrypoint.sh']
