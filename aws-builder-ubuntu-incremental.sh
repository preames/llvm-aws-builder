set -x
set -e
echo "Starting incremental build with fresh patch"
date
# ensure shutdown 180 minutes after last build attempt
sudo shutdown -c
sudo shutdown -P +180
pushd ~/llvm-repo/llvm-project
# Replace the next four lines with the commented out ones for a much
# faster incremental rebuild at the risk of missing rebase problems.
# git diff > ~/LastDiff.diff
# interdiff ~/LastDiff.diff ~/BuildOnAWS.diff > ~/Delta.diff
# patch -p2 < ~/Delta.diff
git checkout -f $1
git clean -fd
git pull --ff-only
patch -p1 < ~/BuildOnAWS.diff
time nice -n 19 make -j31 -C ../build ${@:2}
popd
echo "Finished incremental build"
date
