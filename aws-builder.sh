# busybox wrapper for dispatching to individual commands
# e.g.
# $ aws-builder push opt
# $ aws-builder fetch opt .

set -e
set -x

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

COMMAND_SCRIPT="$SCRIPT_DIR/aws-builder-$1.sh"

if [[ ! -e "$COMMAND_SCRIPT" ]]; then
    echo "Error: $1 command not found"
    exit -1
fi

${COMMAND_SCRIPT} ${@:2}
