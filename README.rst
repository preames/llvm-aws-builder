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

