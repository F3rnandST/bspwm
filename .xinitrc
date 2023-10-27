#!/usr/bin/bash

xrdb -merge ~/.Xresources

sxhkd &
exec bspwm