set -x
set -e
echo "Starting incremental build with fresh patch"
date
# ensure shutdown 180 minutes after last build attempt
sudo shutdown -c
sudo shutdown -P +240
pushd ~/llvm-repo/llvm-project
git checkout -f $1
git clean -fd
patch -p1 < ~/BuildOnAWS.diff
time nice -n 19 ninja -C ../build ${@:2}
popd
echo "Finished incremental build"
date
