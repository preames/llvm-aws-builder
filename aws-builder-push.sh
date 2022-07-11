# Push the local branch and any current WIP state to the builder, then
# do a build with the requested command line.

set -e
set -x

BRANCH=$(git rev-parse --abbrev-ref HEAD)
git push -f llvm-builder:~/llvm-dev/llvm-project/

git diff HEAD > BuildOnAWS.diff
scp BuildOnAWS.diff llvm-builder:~/
rm BuildOnAWS.diff

ssh llvm-builder "~/aws-builder-ubuntu-pushed.sh $BRANCH ${@:1}"
