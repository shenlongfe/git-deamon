#!/bin/bash

#auther:shenlongfei
if [ "$#" -ne 1 ];then
  echo "Usage:$0 {start|stop|restart}"
  exit 1
fi

if [ "$1" = "start" ];then
  /usr/bin/rsync --daemon
  sleep 2
  if [ `netstat -tunlp | grep rsync | wc -l` -ge 1 ];then
     echo "rsync  is   started!!!"
     exit 0
  fi

elif [ "$1" = "stop" ];then
  killall rsync &>/dev/null
  sleep  2
  if [ `netstat -tunlp | grep rsync | wc -l` -eq 0 ];then
     echo "rsync is stopped!!!"
     exit 0
  fi

elif [ "$1" = "restart" ];then
   killall rsync &>/dev/null
   sleep 2
   stoprsync=`netstat -tunlp | grep rsync | wc -l`
   /usr/bin/rsync --daemon
   startrsync=`netstat -tunlp | grep rsync | wc -l`
   if [ "$stoprsync" -eq 0 -a "$startrsync" -ge 1 ];then
       echo "rsync is restarted!!"
   fi

else 
   echo "Usage:$0 {start|stop|restart}"
   exit 1
fi

