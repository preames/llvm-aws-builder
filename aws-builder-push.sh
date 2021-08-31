# Push the local branch and any current WIP state to the builder, then
# do a build with the requested command line.

set -e
set -x
BRANCH=$(git rev-parse --abbrev-ref HEAD)
git diff HEAD > BuildOnAWS.diff

git push -f llvm-builder:~/llvm-repo/llvm-project/
ssh llvm-builder "~/aws-builder-ubuntu-incremental.sh $BRANCH ${@:1}"
