#!/usr/bin/env bash
# ---
# Use "run program" to run it only if it is not already running
# Use "program &" to run it regardless
# ---
# NOTE: This script runs with every restart of AwesomeWM
# TODO: run_once

function run {
    if ! pgrep $1 > /dev/null ;
    then
        $@&
    fi
}

# spotlight like functionality
run albert

# wallpaper
run nitrogen --restore

# Desktop effects
run compton --config /etc/compton/compton.conf

# Caps Lock is Escape (Escape remains as is)
# setxkbmap -option caps:escape

# Scratchpad
# scratchpad
