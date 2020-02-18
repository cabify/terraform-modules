#!/bin/bash
# vim: ai:ts=8:sw=8:noet
# Metadata startup script for consul servers in chaos env
set -eufo pipefail
export SHELLOPTS
umask 0077
IFS=$'\t\n'

# Start coredns first, so that we can connect to GKMS and grab secrets
# This is not required for now in chaos env, but will be in the future
bash /usr/local/sbin/gen_coredns_config.sh
systemctl enable coredns
systemctl start coredns

#####################################
# The rest of the stuf follows below

# Role agnostic variables
export NODE_DATACENTER="sl-dal06"
export NODE_REGION="global"
export INTERNAL_DOMAIN="c.cabify-mr-meeseeks-box.internal"
export EXTERNAL_DOMAIN="chaos-refugees.minks.xyz"

#######################
# Secrets handling
# Import and setup GKMS
source /usr/local/lib/functionarium/gkms_secret_to_stdout.sh
export GKMS_KEYNAME="gitlab-ci-secrets-key"
export GKMS_KEYRING="gitlab-keyring"
export GKMS_LOCATION="us-central1"
export GKMS_PROJECT="cabify-controlpanel"

##################################################################
# Mandatory consul parameters
# We still need this because we are generating a config for consul
export CONSUL_BOOTSTRAP_EXPECT="5"

# Totally ephemeral, generated only for this env
# Hardcoded to unblock us from testing things that are _not_ dependent on having KMS in chaos env
export CONSUL_KEY="tX50Zoz6f2bwA7tcXv5zSw=="
# shellcheck disable=SC2155
export CONSUL_RETRY_JOIN="$(seq 1 $CONSUL_BOOTSTRAP_EXPECT | xargs printf ",\"consul-%s.$INTERNAL_DOMAIN\"" | cut -c2-)"

###################
# Config generation

# Enable services
systemctl enable process-exporter
systemctl enable node-exporter
systemctl enable consul

# Start services
systemctl start process-exporter
systemctl start node-exporter
systemctl start consul

# shellcheck disable=SC2155
export SERVICE="$(curl -s 'http://metadata.google.internal/computeMetadata/v1/instance/attributes/service' -H 'Metadata-Flavor: Google')"
echo "Service: $SERVICE"
# shellcheck disable=SC2155
export NODE_ID="$(curl -s 'http://metadata.google.internal/computeMetadata/v1/instance/attributes/node_id' -H 'Metadata-Flavor: Google')"
echo "Node_ID: $NODE_ID"

systemctl enable mysql

# Configure MySQL (both config file and instance setup)
bash /usr/local/sbin/instance_startup_script.sh
