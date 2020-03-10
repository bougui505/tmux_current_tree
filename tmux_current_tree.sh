#!/usr/bin/env zsh
# -*- coding: UTF8 -*-

# Author: Guillaume Bouvier -- guillaume.bouvier@pasteur.fr
# https://research.pasteur.fr/en/member/guillaume-bouvier/
# 2020-03-10 10:34:11 (UTC+0100)

while :; do
    PANEDIR=$(tmux display-message -p -F '#{pane_current_path}')
    clear
    exa -snew -T -L 1 --color='always' "$PANEDIR"
    sleep 1
done
