set -e
#set -x
if [ "$#" -ne 2 ]; then
    echo "aws-builder-fetch.sh <toolname> <local-dest>"
    echo "  use \"{tool1,tool2}\" for multiple tools"
    exit -1
fi

rsync -v --info=progress llvm-builder:~/llvm-repo/build/bin/$1 $2
