set -x
set -e
pushd ~/llvm-repo/llvm
echo "Starting incremental build with fresh patch"
date
git checkout -f master
git clean -fd
git pull --ff-only
patch -p0 < ~/BuildOnAWS.diff
make -j31 -C ../build check
popd
echo "Finished incremental build"
date
