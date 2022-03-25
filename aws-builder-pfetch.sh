set -e
#set -x
if [ "$#" -ne 2 ]; then
    echo "aws-builder-pfetch.sh <toolname> <local-dest>"
    echo "  does a combined push and fetch for a single tool"
    echo "  use push/fetch seperately for multiple tools"
    exit -1
fi

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

PUSH_SCRIPT="$SCRIPT_DIR/aws-builder-push.sh"
$PUSH_SCRIPT $1

FETCH_SCRIPT="$SCRIPT_DIR/aws-builder-fetch.sh"
$FETCH_SCRIPT $@
