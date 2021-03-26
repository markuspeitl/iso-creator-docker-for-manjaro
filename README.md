# Unofficial ISO Creator Docker image for Manjaro

Dockerfile for building an image based on manjaro/base image and manjaro-iso-tools,
for the purpose of building a customized manjaro image from any linux machine and
trying to prevent the creating of temporary files on the host machine.
(At least not fully, as the files in /var/lib/manjaro-tools still need to be mounted on the host,
as a workaround for mounting the overlay filesystem)

## Why?

- Less files on the host system
- Build on non-arch hosts, without building manjaro-tools from source (as manjaro-tools are not available via apt)
- Speed up the build process (as otherwise you possibly would need a VM which leads to performance overhead and the question how to get the .iso file out of the VM)
- Simpler setup of the requirements

Essentially i just wanted to simplify the .iso build process for me, so that i can have all the applications that i want to have preinstalled
on the .iso and can quickly set up a new system for me anywhere anytime so that i do not spend ages on installing stuff.

## Consideration

Be careful what you do with the container.
It requires priviledged mode and could break your host system if wrongfully used.

## TODO

- Integrate easy method to add AUR packages

### Note

Currently the pacman update fails in the base image if on a debian machine.
One possible workaround is to install "sudo apt install runc" on the host machine.
