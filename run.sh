#docker run -it --cap-add=CHOWN --cap-add=MKNOD --cap-add=SETFCAP --cap-add=SYS_CHROOT --cap-add=SYS_ADMIN --entrypoint /bin/bash manajaro-iso-creator

OUTPUT_DIRECTORY=`dirname $0`/iso-target/
INPUT_PROFILES=`dirname $0`/iso-profiles/

#Need to create this directory on host and bind to container, as the overlay must be mounted from the host machine
sudo mkdir -p /var/lib/manjaro-tools

sudo mkdir -p $OUTPUT_DIRECTORY

docker run -it \
--privileged=true \
--mount type=bind,source=/var/lib/manjaro-tools/,target=/var/lib/manjaro-tools/ \
-v $INPUT_PROFILES:/root/iso-profiles \
-v $OUTPUT_DIRECTORY:/output-volume \
manajaro-iso-creator \
-f -c

#For debugging
"""
docker run -it \
--privileged=true \
--mount type=bind,source=/var/lib/manjaro-tools/,target=/var/lib/manjaro-tools/ \
-v $INPUT_PROFILES:/root/iso-profiles \
-v $OUTPUT_DIRECTORY:/output-volume \
-entrypoint /bin/bash \
manajaro-iso-creator 
"""