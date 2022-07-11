set -e
set -x
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
scp $DIR/aws-builder-ubuntu-*.sh llvm-builder:~/
ssh llvm-builder "chmod u+x *.sh"
ssh llvm-builder "cd ~/llvm-dev/llvm-project/ && git fetch origin"
