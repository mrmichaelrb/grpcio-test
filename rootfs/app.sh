#!/bin/bash

source xvfb.sh

echo "Starting the app"
wine python app.py
app_pid=$!

echo "Waiting for processes to terminate"
wait -n $xvfb_pid $app_pid
