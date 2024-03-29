#!/bin/sh

# Code from https://raw.githubusercontent.com/docker-library/docker/eb1b8297d29bb1fb2208c98f41c1ff4c053c4173/19.03/modprobe.sh

set -eu

# "modprobe" without modprobe
# https://twitter.com/lucabruno/status/902934379835662336

# this isn't 100% fool-proof, but it'll have a much higher success rate than simply using the "real" modprobe

# Docker often uses "modprobe -va foo bar baz"
# so we ignore modules that start with "-"
for module; do
	if [ "${module#-}" = "$module" ]; then
		ip link show "$module" || true
		lsmod | grep "$module" || true
	fi
done

# remove /usr/local/... from PATH so we can exec the real modprobe as a last resort
export PATH='/usr/sbin:/usr/bin:/sbin:/bin'
exec modprobe "$@"
