# ensure shutdown 180 minutes after last build attempt
sudo shutdown -c
sudo shutdown -P +180

# install relevant packages
sudo apt-get update
sudo apt-get --assume-yes install emacs man-db libc6-dev dpkg-dev make build-essential binutils binutils-dev gcc g++ autoconf python git clang cmake patchutils

# install a new enough cmake (from source)
# NOTE: Ubuntu 20.04 currently has a recent enough one in repo
#mkdir cmake
#pushd cmake
#wget https://cmake.org/files/v3.8/cmake-3.8.0-Linux-x86_64.sh
#chmod u+x cmake-3.8.0-Linux-x86_64.sh
#./cmake-3.8.0-Linux-x86_64.sh --skip-license
#export PATH=~/cmake/bin/:$PATH
#popd

#
chmod u+x aws-*.sh

# Setup the source/build tree
mkdir llvm-repo
mkdir llvm-repo/build
cd llvm-repo
git clone --depth 500 https://github.com/llvm/llvm-project.git
cd build/
cmake ../llvm-project/llvm/ -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_ASSERTIONS=On -DLLVM_TARGETS_TO_BUILD=X86 ##-DLLVM_ENABLE_PROJECTS=clang

# Do the initial full build
time nice -n 19 make -j31
