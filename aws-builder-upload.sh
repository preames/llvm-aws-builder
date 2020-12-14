set -e
set -x
git diff origin/master > BuildOnAWS.diff
scp BuildOnAWS.diff ubuntu@${AWS_BUILDER_URL}:~/
rm BuildOnAWS.diff
ssh ubuntu@${AWS_BUILDER_URL} './aws-builder-ubuntu-incremental.sh'
