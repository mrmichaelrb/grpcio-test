#!/bin/bash

echo "Starting the virtual display server"
Xvfb $DISPLAY -nolisten tcp -screen $SCREEN_NUM $SCREEN_WHD +extension GLX +extension RANDR +extension RENDER &
xvfb_pid=$!

echo "Waiting for the virtual display server to start"
sleep 2
