#!/usr/bin/env zsh
# -*- coding: UTF8 -*-

# Author: Guillaume Bouvier -- guillaume.bouvier@pasteur.fr
# https://research.pasteur.fr/en/member/guillaume-bouvier/
# 2020-03-10 11:17:08 (UTC+0100)

DIRSCRIPT="$(dirname "$(readlink -f "$0")")"
cd $DIRSCRIPT
tmux -2 splitw -l 40 -h ./tmux_current_tree.sh
tmux last-pane
