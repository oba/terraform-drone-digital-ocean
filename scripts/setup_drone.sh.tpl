#!/bin/bash

DRONE_IO_VERSION="0.4"

mkdir /etc/drone
touch /etc/drone/dronerc

cat > /etc/drone/dronerc << EOF
REMOTE_DRIVER=bitbucket
REMOTE_CONFIG=https://bitbucket.org?client_id=${client_id}&client_secret=${client_secret}
EOF

# cat > /etc/drone/dronerc << EOF
# REMOTE_DRIVER=github
# REMOTE_CONFIG=https://github.com?client_id={client_id}&client_secret=${client_secret}
# EOF

sudo docker run \
    --volume /var/lib/drone:/var/lib/drone \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --env-file /etc/drone/dronerc \
    --restart=always \
    --publish=80:8000 \
    --detach=true \
    --name=drone \
    drone/drone:$DRONE_IO_VERSION