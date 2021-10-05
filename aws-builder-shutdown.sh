set -e
set -x
# Shutdown with a 5 minute grace period as I frequently shutdown and then
# go "oh, one more thing!!".  Note that any upload/push command in the grace
# period will abort the shutdown.
ssh llvm-builder "sudo shutdown -P +5"
