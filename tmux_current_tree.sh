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
        OUTPUT=$(exa -snew -T -L 2 --color='always' "$PANEDIR")
        NLINES=$(echo $OUTPUT | wc -l)
        if [ $NLINES -lt 40 ]; then
            echo $OUTPUT
        else
            exa -snew -T -L 1 --color='always' "$PANEDIR"
        fi
    fi
    DISPLAYDIR=$PANEDIR
    MD5=$MD5_
    sleep 1
done
