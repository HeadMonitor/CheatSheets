#!/bin/bash

host=$1
start_port=${2:-1}
end_port=${3:-1024}

echo "Scanning $host from port $start_port to $end_port"

for ((port=start_port; port<=end_port; port++)); do
  (echo > /dev/tcp/$host/$port) >/dev/null 2>&1 && echo "Port $port is open" &
done
wait
