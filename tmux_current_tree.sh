#!/usr/bin/env zsh
# -*- coding: UTF8 -*-

# Author: Guillaume Bouvier -- guillaume.bouvier@pasteur.fr
# https://research.pasteur.fr/en/member/guillaume-bouvier/
# 2020-03-10 10:34:11 (UTC+0100)

DISPLAYDIR='None'
MD5='XXX'
while :; do
    PANEDIR=$(tmux display-message -p -F '#{pane_current_path}')
    MD5_=$(stat $PANEDIR | md5sum | awk '{print $1}')
    if [ $DISPLAYDIR != $PANEDIR ] || [ $MD5_ != $MD5 ]; then
        clear
        NFILES=$(ls "$PANEDIR" | wc -w)
        if [ $NFILES -lt 40 ]; then
            OUTPUT=$(tree -l -C -L 2 --filelimit 40 -t "$PANEDIR")
        else
            OUTPUT=$(tree -l -C -L 1 -t "$PANEDIR")
        fi
        NLINES=$(echo $OUTPUT | wc -l)
        if [ $NLINES -lt 45 ]; then
            echo $OUTPUT
        else
            tree -l -C -L 1 -t "$PANEDIR"
        fi
    fi
    DISPLAYDIR=$PANEDIR
    MD5=$MD5_
    sleep 1
done
