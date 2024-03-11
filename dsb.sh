#!/bin/bash
# Bash Menu Script Example

PS3='Please enter your choice: '
options=("Replace with docker.ir" "Restore original" "Remove" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Replace with docker.ir")
            cp /etc/docker/daemon.json /etc/docker/daemon.json.bk
            echo -e '{\n"registry-mirrors": ["https://registry.docker.ir"]\n}' > /etc/docker/daemon.json
            echo docker.ir has been installed.
            ;;
        "Restore original")
            cp /etc/docker/daemon.json.bk /etc/docker/daemon.json
            echo original file has been restored.
            ;;
        "Remove")
            rm /etc/docker/daemon.json
            echo config file has been deleted.
            ;;
        "Quit")
            echo Restarting docker daemon...
            systemctl daemon-reload && systemctl restart docker
            echo Bye!
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done