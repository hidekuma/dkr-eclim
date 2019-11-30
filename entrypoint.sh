#!/bin/bash
sudo Xvfb :1 -screen 0 1024x768x24 &
DISPLAY=:1 /opt/eclipse/eclimd
#./eclim_2.8.0.bin \
  #--yes \
  #--eclipse=$HOME/eclipse \
  #--vimfiles=$HOME/.vim \
  #--plugins=jdt
