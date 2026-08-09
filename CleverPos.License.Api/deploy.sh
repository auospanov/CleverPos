#!/usr/bin/env bash
# Deploy License API: upload only Api+Core, build Docker image ON the server.
# Password is prompted by ssh/scp (no local Docker required).
#
# Usage (Git Bash / WSL), from this folder:
#   bash deploy.sh
#
# Optional env:
#   DEPLOY_HOST=92.38.49.47
#   DEPLOY_USER=root
#   DEPLOY_PATH=/var/www/apilicense

set -euo pipefail

HOST="${DEPLOY_HOST:-92.38.49.47}"
USER_NAME="${DEPLOY_USER:-root}"
REMOTE_PATH="${DEPLOY_PATH:-/var/www/apilicense}"
IMAGE_NAME="${DEPLOY_IMAGE:-cleverpos-license-api:latest}"
REMOTE="${USER_NAME}@${HOST}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

echo "==> Target ${REMOTE}:${REMOTE_PATH}"
echo "==> (ssh/scp will ask for password if key is not configured)"

# Password prompt uses the console TTY (OpenSSH); no -t needed for remote script stdin.
SSH=(ssh)
SCP=(scp)
RSYNC_SSH="ssh"

echo "==> Ensure remote folder"
"${SSH[@]}" "${REMOTE}" "mkdir -p '${REMOTE_PATH}/CleverPos.License.Api' '${REMOTE_PATH}/CleverPos.License.Core'"

echo "==> Upload CleverPos.License.Core"
if command -v rsync >/dev/null 2>&1; then
  rsync -az --delete \
    --exclude bin/ --exclude obj/ --exclude .vs/ --exclude '*.user' \
    -e "${RSYNC_SSH}" \
    "${REPO_ROOT}/CleverPos.License.Core/" \
    "${REMOTE}:${REMOTE_PATH}/CleverPos.License.Core/"
else
  "${SCP[@]}" -r \
    "${REPO_ROOT}/CleverPos.License.Core/." \
    "${REMOTE}:${REMOTE_PATH}/CleverPos.License.Core/"
fi

echo "==> Upload CleverPos.License.Api (sources + Dockerfile + compose)"
if command -v rsync >/dev/null 2>&1; then
  rsync -az --delete \
    --exclude bin/ --exclude obj/ --exclude .vs/ --exclude '*.user' \
    --exclude .env --exclude '*.tar' --exclude deploy.ps1 \
    -e "${RSYNC_SSH}" \
    "${SCRIPT_DIR}/" \
    "${REMOTE}:${REMOTE_PATH}/CleverPos.License.Api/"
else
  "${SCP[@]}" -r \
    "${SCRIPT_DIR}/." \
    "${REMOTE}:${REMOTE_PATH}/CleverPos.License.Api/"
fi

echo "==> Build image and start on server"
"${SSH[@]}" "${REMOTE}" "set -e; cd '${REMOTE_PATH}'; cp -f CleverPos.License.Api/docker-compose.prod.yml docker-compose.yml; if [ ! -f .env ]; then if [ -f CleverPos.License.Api/.env.example ]; then cp CleverPos.License.Api/.env.example .env; else printf '%s\n' 'ADMIN_API_KEY=change-me-admin-key' 'ASPNETCORE_ENVIRONMENT=Production' 'API_PORT=5088' 'LICENSE_DB=Server=127.0.0.1;user id=root;password=Asd+12345678;database=cleverpos;charset=utf8mb4;default command timeout=1200;SslMode=none;AllowPublicKeyRetrieval=True' > .env; fi; echo 'Created .env'; fi; docker build -f CleverPos.License.Api/Dockerfile -t '${IMAGE_NAME}' .; docker compose -f docker-compose.yml up -d --force-recreate; docker ps --filter name=cleverpos-license-api"
echo "==> Done: http://${HOST}:5088"
echo "    Files: ${REMOTE}:${REMOTE_PATH}"
