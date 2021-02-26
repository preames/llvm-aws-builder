set -e
set -x
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
scp $DIR/*.sh llvm-builder:~/
ssh llvm-builder "chmod u+x *.sh"
ssh llvm-builder "./aws-builder-ubuntu-setup.sh"
