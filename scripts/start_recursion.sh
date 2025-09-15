#!/bin/bash
# 🔁 Infinity Loop Recursive Engine

LOG_FILE="/opt/infinity_loop/logs/recursion.log"
mkdir -p /opt/infinity_loop/logs

echo "🔁 $(date): Infinity Loop recursion starting..." >> "$LOG_FILE"

while true; do
  bash /opt/infinity_loop/scripts/ignite.sh >> "$LOG_FILE" 2>&1
  sleep 60
done
