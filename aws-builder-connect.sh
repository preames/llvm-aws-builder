
set -e
set -x

${EDITOR} ~/.ssh/config

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
scp $SCRIPT_DIR/aws-builder-ubuntu-*.sh llvm-builder:~/
ssh llvm-builder "sudo shutdown -P +120"
