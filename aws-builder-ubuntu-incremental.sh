set -x
set -e
pushd ~/llvm-repo/llvm-project/llvm
echo "Starting incremental build with fresh patch"
date
git checkout -f main
git clean -fd
git pull --ff-only
patch -p2 < ~/BuildOnAWS.diff
time make -j31 -C ../../build check
popd
echo "Finished incremental build"
date
