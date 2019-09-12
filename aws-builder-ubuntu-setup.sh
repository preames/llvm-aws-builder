# install relevant packages
sudo apt-get update
sudo apt-get install emacs man-db libc6-dev dpkg-dev make build-essential binutils binutils-dev gcc g++ autoconf python git clang

# install a new enough cmake (from source)
mkdir cmake
pushd cmake
wget https://cmake.org/files/v3.8/cmake-3.8.0-Linux-x86_64.sh
chmod u+x cmake-3.8.0-Linux-x86_64.sh
./cmake-3.8.0-Linux-x86_64.sh --skip-license
export PATH=~/cmake/bin/:$PATH
popd

# Setup the source/build tree
mkdir llvm-repo
mkdir llvm-repo/build
cd llvm-repo
git clone http://llvm.org/git/llvm.git
cd build/
cmake ../llvm/ -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_ASSERTIONS=On -DLLVM_TARGETS_TO_BUILD=X86

# Do the initial full build
time make -j31
