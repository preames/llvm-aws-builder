# Push a diff of current working state against main, and then build with
# the requested command line options.
set -e
set -x

git diff origin/main > BuildOnAWS.diff
scp BuildOnAWS.diff llvm-builder:~/
rm BuildOnAWS.diff

ssh llvm-builder "~/aws-builder-ubuntu-incremental.sh main ${@:1}"
