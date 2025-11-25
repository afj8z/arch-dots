#!/bin/bash

frames=(
"
   o..
  .   .
 .     .
.       .
 .     .
  .   .
   ...
"
"
   ...
  .   o
 .     .
.       .
 .     .
  .   .
   ...
"
"
   ...
  .   .
 .     .
.       o
 .     .
  .   .
   ...
"
"
   ...
  .   .
 .     .
.       .
 .     o
  .   .
   ...
"
"
   ...
  .   .
 o     .
.       .
 .     .
  .   .
   ...
"
"
   ...
  o   .
 .     .
.       .
 .     .
  .   .
   ...
"
)

i=0
while true; do
    # This ANSI code clears the screen and moves cursor to home (top-left)
    printf '\e[2J\e[H'
    echo "${frames[i]}"
    sleep 0.1
    ((i = (i + 1) % ${#frames[@]}))
done
