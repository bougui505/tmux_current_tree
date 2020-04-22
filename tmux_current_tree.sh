#!/usr/bin/env zsh
# -*- coding: UTF8 -*-

# Author: Guillaume Bouvier -- guillaume.bouvier@pasteur.fr
# https://research.pasteur.fr/en/member/guillaume-bouvier/
# 2020-03-10 10:34:11 (UTC+0100)

if ! [ -x "$(command -v h)" ]; then
    source ~/source/hhighlighter/h.sh
fi

DISPLAYDIR='None'
TIMESTAMP='XXX'
while :; do
    PANEDIR=$(tmux display-message -p -F '#{pane_current_path}')
    TIMESTAMP_=$(find . -maxdepth 0 -name '*' -not -path '*/\.*' | xargs stat -c %Y "$PANEDIR/." | sort -n | tail -1)
    if [ $DISPLAYDIR != $PANEDIR ] || [ $TIMESTAMP_ != $TIMESTAMP ]; then
        NEWFILES=$(exa -lh -snew --git --time-style full-iso --links | awk '{Time=$5" "$6
                    gsub("[-,:]", " ", Time)
                    Time=mktime(Time)
                    delta=systime()-Time
                    if (delta<300){
                        print $9}
                    }' | tr '\n' '|'|sed 's/.$//')
        clear
        NFILES=$(ls "$PANEDIR" | wc -w)
        if [ $NFILES -lt 40 ]; then
            OUTPUT=$(tree -I __pycache__ -l -C -L 2 --filelimit 40 -t "$PANEDIR" | h $(echo $NEWFILES))
        else
            OUTPUT=$(tree -I __pycache__ -l -C -L 1 -t "$PANEDIR" | h $(echo $NEWFILES))
        fi
        NLINES=$(echo $OUTPUT | wc -l)
        if [ $NLINES -lt 45 ]; then
            echo $OUTPUT
        else
            tree -I __pycache__ -l -C -L 1 -t "$PANEDIR" | h $(echo $NEWFILES)
        fi
    fi
    DISPLAYDIR=$PANEDIR
    TIMESTAMP=$TIMESTAMP_
    sleep 1
done
