#!/usr/bin/env zsh
# -*- coding: UTF8 -*-

# Author: Guillaume Bouvier -- guillaume.bouvier@pasteur.fr
# https://research.pasteur.fr/en/member/guillaume-bouvier/
# 2020-03-10 10:34:11 (UTC+0100)

DISPLAYDIR='None'
TIMESTAMP='XXX'
while :; do
    PANEDIR=$(tmux display-message -p -F '#{pane_current_path}')
    TIMESTAMP_=$(stat -c %Y $PANEDIR/* | sort -n | tr -d "\n")
    if [ $DISPLAYDIR != $PANEDIR ] || [ $TIMESTAMP_ != $TIMESTAMP ]; then
        clear
        NFILES=$(ls "$PANEDIR" | wc -w)
        if [ $NFILES -lt 40 ]; then
            OUTPUT=$(tree -I __pycache__ -l -C -L 2 --filelimit 40 -t "$PANEDIR")
        else
            OUTPUT=$(tree -I __pycache__ -l -C -L 1 -t "$PANEDIR")
        fi
        NLINES=$(echo $OUTPUT | wc -l)
        if [ $NLINES -lt 45 ]; then
            echo $OUTPUT
        else
            tree -I __pycache__ -l -C -L 1 -t "$PANEDIR"
        fi
    fi
    DISPLAYDIR=$PANEDIR
    TIMESTAMP=$TIMESTAMP_
    sleep 1
done
