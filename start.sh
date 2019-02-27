#!/bin/bash
system=$(uname -a)
os_name=(${system// / })
if [[ ${os_name[0]} == "Linux" && ${os_name[2]} =~ "Microsoft" ]]
then
    $a export PULSE_SERVER=tcp:localhost
fi
source env/bin/activate

