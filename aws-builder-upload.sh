set -e
set -x
BRANCH=$(git rev-parse --abbrev-ref HEAD)
git diff origin/$BRANCH > BuildOnAWS.diff

#git push llvm-builder:~/llvm-repo/llvm-project/
scp BuildOnAWS.diff llvm-builder:~/
rm BuildOnAWS.diff
ssh llvm-builder "~/aws-builder-ubuntu-incremental.sh $BRANCH ${@:1}"
