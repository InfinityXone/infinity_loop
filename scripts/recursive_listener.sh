#!/bin/bash
# 👂 Infinity Loop Autonomous Listener

WATCH_DIR="/mnt/data"
DEST_DIR="/opt/infinity_loop"
LOG_FILE="$DEST_DIR/logs/listener.log"

mkdir -p "$DEST_DIR/logs"

echo "👂 $(date): Listener Active..." >> "$LOG_FILE"

for file in "$WATCH_DIR"/*.{ts,sh,py}; do
  [ -e "$file" ] || continue
  cp "$file" "$DEST_DIR/scripts/"
  chmod +x "$DEST_DIR/scripts/$(basename "$file")"
  echo "🚀 Executing: $file" >> "$LOG_FILE"
  if [[ "$file" == *.ts ]]; then
    node "$DEST_DIR/scripts/$(basename "$file")" >> "$LOG_FILE" 2>&1
  elif [[ "$file" == *.py ]]; then
    python3 "$DEST_DIR/scripts/$(basename "$file")" >> "$LOG_FILE" 2>&1
  elif [[ "$file" == *.sh ]]; then
    bash "$DEST_DIR/scripts/$(basename "$file")" >> "$LOG_FILE" 2>&1
  fi
done

echo "✅ $(date): Listener Complete." >> "$LOG_FILE"
