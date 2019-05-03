#!/bin/bash

mkdir -p "/home/rpclab/.vnc"
echo "${VNCPASSWORD}" | vncpasswd -f > "/home/rpclab/.vnc/passwd"
chmod 600 "/home/rpclab/.vnc/passwd"

if [ -f "/home/rpclab/.Xauthority" ]
then
    rm "/home/rpclab/.Xauthority"
fi

if [ -f "/tmp/.X1-lock" ]
then
    vncserver -kill :1
fi


vncserver -xstartup /usr/local/bin/startxfce.sh -fg -autokill

