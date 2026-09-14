#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
chmod +x MainMenu.sh status.sh Backup_Management.sh Network_Management.sh Service_Management.sh management.sh FileManagement.sh
exec bash MainMenu.sh
