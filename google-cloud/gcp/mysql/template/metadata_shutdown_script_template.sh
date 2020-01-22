#!/bin/bash
# vim: ai:ts=8:sw=8:noet
# metadata startup script *template* for every instance
# NOTE: since this is terraform template, don't use curly brace syntax for bash variables
# NOTE: this script is run every time the instance is started. This includes reboots.
# Therefore, it should be idempotent. Later, the provisioning logic will move off here.

exec 1> >(logger -s -t "$(basename "$0")") 2>&1

set -exufo pipefail
export SHELLOPTS
IFS=$'\t\n'


exit 0

