set -e
set -x
git diff origin/master > BuildOnAWS.diff
scp BuildOnAWS.diff ubuntu@${AWS_BUILDER_URL}:~/
rm BuildOnAWS.diff
scp aws-*.sh ubuntu@${AWS_BUILDER_URL}:~/
ssh ubuntu@${AWS_BUILDER_URL} 'chmod u+x aws-builder-ubuntu-incremental.sh'
ssh ubuntu@${AWS_BUILDER_URL} './aws-builder-ubuntu-incremental.sh'
