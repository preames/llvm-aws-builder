# ensure shutdown 120 minutes after last build attempt
./aws-builder-ubuntu-arm-ahutdown-timer.sh

# install relevant packages
sudo apt-get update
sudo apt-get --assume-yes install emacs man-db libc6-dev dpkg-dev make build-essential binutils binutils-dev gcc g++ autoconf python git clang cmake patchutils ninja-build

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
mkdir llvm-dev
mkdir llvm-dev/build
cd llvm-dev
git clone https://github.com/llvm/llvm-project.git
# Allow pushes to the current branch, discarding local state so that
# aws-builder-push works.
git config receive.denyCurrentBranch ignore
cd build/
cmake ../llvm-project/llvm/ -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_ASSERTIONS=On -DLLVM_TARGETS_TO_BUILD=all -DLLVM_ENABLE_PROJECTS=clang -G Ninja

# Do the initial full build
time nice -n 19 ninja
