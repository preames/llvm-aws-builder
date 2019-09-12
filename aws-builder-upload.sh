set -e
set -x
svn diff > BuildOnAWS.diff
scp -i ~/.ssh/azul_rsa.private BuildOnAWS.diff ubuntu@${AWS_BUILDER_URL}:~/
rm BuildOnAWS.diff
scp -i ~/.ssh/azul_rsa.private aws-*.sh ubuntu@${AWS_BUILDER_URL}:~/
ssh -i ~/.ssh/azul_rsa.private ubuntu@${AWS_BUILDER_URL} 'chmod u+x aws-builder-ubuntu-incremental.sh'
ssh -i ~/.ssh/azul_rsa.private ubuntu@${AWS_BUILDER_URL} './aws-builder-ubuntu-incremental.sh'
