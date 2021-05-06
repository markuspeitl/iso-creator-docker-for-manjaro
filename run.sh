#TODO remove priviledged and only add capabilities needed
#--cap-add=CHOWN --cap-add=MKNOD --cap-add=SETFCAP --cap-add=SYS_CHROOT --cap-add=SYS_ADMIN

TARGET_PROFILE=$1

if [ -z $TARGET_PROFILE ]; then
    TARGET_PROFILE=media-xfce-kde
fi;

#OUTPUT_DIRECTORY=`dirname $0`/iso-target/
OUTPUT_DIRECTORY=$(pwd)/iso-target/
echo $OUTPUT_DIRECTORY

INPUT_PROFILES=$(pwd)/iso-profiles/
INPUT_PROFILES=$(pwd)/my-custom-manjaro-profiles/
echo $INPUT_PROFILES

#PACMAN_CACHE=/tmp/pacman-cache/
PACMAN_CACHE=$(pwd)/pacman-cache/
echo $PACMAN_CACHE

SNAPD_CACHE=$(pwd)/snapd-cache/
echo $SNAPD_CACHE


PROFILE="-p $TARGET_PROFILE"
FLAGS='-f'


sudo mkdir -p $PACMAN_CACHE

#Need to create this directory on host and bind to container, as the overlay must be mounted from the host machine
sudo mkdir -p /var/lib/manjaro-tools

sudo mkdir -p $OUTPUT_DIRECTORY

#Clean cache
#sudo rm -r $PACMAN_CACHE/*

docker run -it \
--privileged=true \
--mount type=bind,source=/var/lib/manjaro-tools/,target=/var/lib/manjaro-tools/ \
-v $INPUT_PROFILES:/root/iso-profiles \
-v $OUTPUT_DIRECTORY:/output-volume \
-v $PACMAN_CACHE:/var/cache/pacman/pkg \
-v /var/lib/snapd:/var/lib/snapd/snaps \
-v /var/run/snapd.socket:/var/run/snapd.socket \
-v /snap:/snap \
manajaro-iso-creator \
$PROFILE \
$FLAGS

#For debugging
#docker run -it \
#--privileged=true \
#--mount type=bind,source=/var/lib/manjaro-tools/,target=/var/lib/manjaro-tools/ \
#-v $INPUT_PROFILES:/root/iso-profiles \
#-v $OUTPUT_DIRECTORY:/output-volume \
#-v $PACMAN_CACHE:/var/cache/pacman/pkg \
#-v /var/lib/snapd:/var/lib/snapd/snaps \
#-v /var/run/snapd.socket:/var/run/snapd.socket \
#-v /snap:/snap \
#--entrypoint /bin/bash \
#manajaro-iso-creator \

#-v $SNAPD_CACHE:/var/lib/snapd/snaps \