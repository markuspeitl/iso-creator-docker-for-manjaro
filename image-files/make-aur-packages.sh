
mkdir -p ~/online-repo/x86_64
mkdir -p ~/pkgbuild

cd ~/pkgbuild

git clone https://aur.archlinux.org/kickshaw
git clone https://aur.archlinux.org/reaper-bin

mkdir built

buildpkg -p kichshaw reaper-bin -r ~/pkgbuild/built/
