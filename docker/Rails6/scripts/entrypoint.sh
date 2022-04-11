#!/bin/bash
set -e
ip addr add 192.168.99.101 dev eth0
# Remove a potentially pre-existing server.pid for Rails.
rm -f /ro6mysngx/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
