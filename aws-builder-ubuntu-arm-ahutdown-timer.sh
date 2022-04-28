set -x
set -e
# ensure shutdown 120 minutes after last build attempt
sudo shutdown -c
sudo shutdown -P +120
