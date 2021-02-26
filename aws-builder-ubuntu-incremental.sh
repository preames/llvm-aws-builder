set -x
set -e
echo "Starting incremental build with fresh patch"
date
# ensure shutdown 120 minutes after last build attempt
sudo shutdown -c
sudo shutdown -P +120
pushd ~/llvm-repo/llvm-project/llvm
git checkout -f main
git clean -fd
git pull --ff-only
patch -p2 < ~/BuildOnAWS.diff
time nice -n 19 make -j31 -C ../../build ${@:1}
popd
echo "Finished incremental build"
date
