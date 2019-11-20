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

```
$ AWS_BUILDER_URL=<your public dns url>
$ scp *.sh ubuntu@${AWS_BUILDER_URL}:~/
$ ssh ubuntu@${AWS_BUILDER_URL}
(On builder, not local machine)
$ chmod u+x aws-*
$ ./aws-builder-ubuntu-setup.sh
$ exit
(Back on local machine)
$ cd <your working source directory>
$ ./aws-builder-upload.sh
```

The above example assumes you've configured your ~/.ssh/config to pick
the appropriate key when logging into AWS.

To copy back a build binary (say, for using update_lit_test.py)

```
scp  ubuntu@$AWS_BUILDER_URL:~/llvm-repo/build/bin/opt ../../aws-bin/
```

Note that the binaries are typically quite large, so you want to make sure
you're on high bandwidth pipe, and not say, mobile internet.
