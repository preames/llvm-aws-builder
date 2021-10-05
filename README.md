A simple set of utility scripts for working with an AWS instance as a
builder for LLVM.  The assumed environment is that you have a checkout
locally with an in-progress patch.  The builder is assumed to be
shutdown and recreated periodically.  There is no *state* kept in the
builder.

To create the builder, use a spot instance w/at least 32 cores running
Ubuntu 20.04 LTS.  (The spot page allows limited duration launches
which are ideal for this purpose as you don't have to remember to
shut them down.  A six hour run costs approximately $3 at recent
prices.)

The scripts will ensure the builder is automatically shutdown after
roughly two hours of inactivity.  If you don't use the limited
duration feature above **make sure that you config termination on
shutdown** in the instance options.

Once created, setup your ~/.ssh/config entry (as described below), and
then run the aws-builder-setup.sh script.  
Once created, copy scripts to the builder, run the setup script, and
then exit.  The setup process takes about 5 minutes.  All future
interaction is done via the upload script from your working directory.

Example:

```
$ ./aws-builder-setup.sh
$ cd <your working source directory>
$ ./aws-builder-upload.sh # OR ./aws-builder-push.sh
```

An "upload" applies a diff against tip-of-tree of the main branch.  A "push" pushes your exact local working state (including full branch history).  "upload" is generally a good default if you're iterating on a single patch for upstream submission; "push" is for when working with more complex branch state.

The above example assumes you've configured your ~/.ssh/config to add
an "llvm-builder" entry which handles all login details including keys
and users.  You can test this by simple sshing into that name and ensuring
everything works.  Example entry:

```
Host llvm-builder
    HostName ec2-whatever.compute-1.amazonaws.com 
    IdentityFile <path to your aws private key>
    User ubuntu
```


To copy back a build binary (say, for using update_lit_test.py)

```
./aws-builder-fetch.sh opt .
```

Note that the binaries are typically quite large, so you want to make sure
you're on high bandwidth pipe, and not say, mobile internet.


If you want, you can use a stateful builder by replacing the "Terminate" in the shutdown configuration with a "Stop".  Once that's done, you can restore a builder instance by simply starting the stopped instance.  You will pay for storage of the stopped image, but assuming you're using this mechanism frequently, that's a fairly minimal cost to avoid the time cost of running setup each day.
