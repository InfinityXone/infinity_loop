#!/bin/bash
# 🌀 Infinity Loop Push/Pull Gateway

REPO_DIR="/opt/infinity_loop"
WATCH_DIR="/mnt/data"
LOG_FILE="$REPO_DIR/logs/sync.log"
BRANCH="main"

mkdir -p "$REPO_DIR/logs"

cd "$REPO_DIR" || exit 1
echo "🌀 $(date): Sync Trigger Start" >> "$LOG_FILE"

git fetch origin "$BRANCH"
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse origin/"$BRANCH")

if [ "$LOCAL" != "$REMOTE" ]; then
  echo "📥 Pulling from GitHub..." >> "$LOG_FILE"
  git pull origin "$BRANCH" >> "$LOG_FILE" 2>&1
fi

if compgen -G "$WATCH_DIR/*.*" > /dev/null; then
  rsync -av --exclude='*.zip' --exclude='.git/' "$WATCH_DIR/" "$REPO_DIR/" >> "$LOG_FILE" 2>&1
  git add . >> "$LOG_FILE"
  git commit -m '🚀 Auto-sync Infinity_Loop files' >> "$LOG_FILE" 2>&1 || echo "⚠️ Nothing to commit." >> "$LOG_FILE"
  git push origin "$BRANCH" >> "$LOG_FILE" 2>&1
  echo "✅ Push complete." >> "$LOG_FILE"
fi

echo "✅ $(date): Sync Trigger Complete" >> "$LOG_FILE"
