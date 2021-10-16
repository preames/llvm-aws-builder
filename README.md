A simple set of utility scripts for working with an AWS instance as a
builder for LLVM.  The assumed environment is that you have a checkout
locally with an in-progress patch.  The builder is assumed to be
shutdown and recreated periodically.  There is no *interesting state*
kept in the builder.

## Initial Setup

Start by creating a new instance w/at least 32 cores running
Ubuntu 20.04 LTS.  Make sure you configure your image to be
stop-on-shutdown, not terminate-on-shutdown.  This will allow you
to create a restartable builder and only pay the storage cost in
between usage.  

Once created, setup your ~/.ssh/config entry (as described below), and
then run the aws-builder-setup.sh script.

The scripts assumes you've configured your ~/.ssh/config to add an
"llvm-builder" entry which handles all login details including keys
and users.  You can test this by simple sshing into that name and
ensuring everything works.  Example entry:

```
Host llvm-builder
    HostName ec2-whatever.compute-1.amazonaws.com 
    IdentityFile <path to your aws private key>
    User ubuntu
```

The setup script handles copying all the builder scripts to the
builder, creating a build tree, and configuring a build environment
(currently defaulting to Release+Asserts w/clang enabled, but you
can edit the config if desired).  The setup process takes about
5 minutes.

The scripts will ensure the builder is automatically shutdown after
roughly two hours of inactivity.

## Restarting

If you configured your builder to stop-on-shutdown, you'll have an
non-running instance waiting in your EC2 instance list.  If you
start that instance through the EC2 interface, you can reconnect via:

```
# Will open ~/.ssh/config so you can change the url, and then resync
# scripts to the builder before arming the shutdown timer.
$ aws-builder connect
```

Warning: Simply starting the instance will *not* arm the shutdown
timer, that's currently only done on first command execution.

## Basic Usage

From here out, all examples will assume you've configured an alias for the
master script (aws-builder.sh) as "aws-builder".

There are two basic workflows supported by the tooling:  "push" and "upload".
Both have the effect of triggering remote builds, but what is built is a bit
different.

"push" is a good default command.  It will build exactly what you'd get by
doing a local build in your directory.  A "push" pushes your exact local
working state (including full branch history) and builds that.


```
$ aws-builder push
```

There are two potential downsides to a "push".  The first is that it requires
uploading your entire git history for the current branch.  This might be
undesirable if you're working over a very limited upload link.  The second is
that you're not testing upstream ToT unless you've rebased locally.

An "upload" applies a diff from your local origin/main against tip-of-tree of
the main branch (synced immediately before build on the builder) regardless
of what the state of your local branch is.  This is useful if you're want to
post a patch for review and confirm that it builds on ToT without disrupting
your local checkout or build state.  

```
$ aws-builder upload
```

To copy back a build binary (say, for using update_lit_test.py)

```
$ aws-builder fetch opt .
```

Note that the binaries are typically quite large, so you want to make sure
you're on high bandwidth pipe, and not say, mobile internet.  Also, note that
while moving LLVM's utility binaries tend to works well, using a downloanded
clang locally tends to be more error prone since builtin search paths will
likely be wrong for your local environment.

Once you're done for the day, you can explicitly shutdown the instance to
minimize usage charges.  The actual shutdown is 5 minutes delayed to allow
that "oops, I needed one more build" realization.  :)

```
$ aws-builder shutdown
```


## Cleanup

Once you're done with the builder, make sure you terminate the instance. If
your note sure about using the builder long term, you can also launch the
original image with terminate-on-shutdown set.  Doing that will require you
to recreate a builder each time you want to use one (which adds a couple
minutes setup delay), but has the benefit of not needing to pay storage costs
in between usage.

