#!/bin/bash
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java 9999
sudo Xvfb $DISPLAY -screen 0 1024x768x24
#DISPLAY=$DISPLAY /opt/eclipse/eclimd
