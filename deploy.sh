#!/bin/bash
set -e

DEPLOY_DIR="/usr/share/nginx/html/wwwroot"
BACKUP_DIR="/opt/deploy_backups"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)

echo "Creating backup..."
mkdir -p "$BACKUP_DIR"
zip -r "$BACKUP_DIR/site_backup_$TIMESTAMP.zip" "$DEPLOY_DIR"

echo "Cleaning old site..."
rm -rf "$DEPLOY_DIR"/*

echo "Deploying new version..."
unzip app.zip -d "$DEPLOY_DIR"

chown -R nginx:nginx "$DEPLOY_DIR"
chmod -R 755 "$DEPLOY_DIR"

systemctl reload nginx

echo "Deployment complete!"
