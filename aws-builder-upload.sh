set -e
set -x
git diff origin/main > BuildOnAWS.diff
#git push llvm-builder:~/llvm-repo/llvm-project/
scp BuildOnAWS.diff llvm-builder:~/
rm BuildOnAWS.diff
ssh llvm-builder "~/aws-builder-ubuntu-incremental.sh ${@:1}"
