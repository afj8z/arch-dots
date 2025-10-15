#!/bin/bash

# Frames are the same as the example above
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

# Animation loop
i=0
while true; do
    # This ANSI code clears the screen and moves cursor to home (top-left)
    printf '\e[2J\e[H'
    echo "${frames[i]}" # Print the current frame
    sleep 0.1
    # Move to the next frame
    ((i = (i + 1) % ${#frames[@]}))
done
