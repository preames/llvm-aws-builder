A simple set of utility scripts for working with an AWS instance as a
builder for LLVM.  The assumed environment is that you have a checkout
locally with an in-progress patch.  The builder is assumed to be
shutdown and recreated periodically.  There is no *state* kept in the
builder.

To create the builder, use a spot instance w/at least 32 cores running
Ubuntu 18.04 LTS.  (The spot page allows limited duration launches
which are ideal for this purpose as you don't have to remember to
shut them down.  A six hour run costs approximately $3 at recent
prices.)

Once created, copy scripts to the builder, run the setup script, and
then exit.  The setup process takes about 5 minutes.  All future
interaction is done via the upload script from your working directory.

Example:

::
   $ scp *.sh ubuntu@ec2-52-54-108-46.compute-1.amazonaws.com:~/
   $ ssh ubuntu@ec2-52-54-108-46.compute-1.amazonaws.com
   (On builder, not local machine)
   $ chmod u+x aws-*
   $ ./aws-builder-ubuntu-setup.sh
   $ exit
   (Back on local machine)
   $ cd <your working source directory>
   $ ./aws-builder-upload.sh

The above example assumes you've configured your ~/.ssh/config to pick
the appropriate key when logging into AWS.
