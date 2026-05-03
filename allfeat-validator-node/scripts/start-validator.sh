#!/usr/bin/env sh

set -eu

case "${APP_ALLFEAT_CHAIN:-melodie}" in
  melodie) CHAIN_ID="melodie_3_staging" ;;
  mainnet|allfeat) CHAIN_ID="allfeat_staging" ;;
  *) CHAIN_ID="${APP_ALLFEAT_CHAIN}" ;;
esac

mkdir -p \
  /data/chain/chains/"${CHAIN_ID}" \
  /data/admin/config \
  /data/admin/keystore \
  /data/admin/identity \
  /data/admin/logs

ln -sfn /data/admin/keystore /data/chain/keystore
ln -sfn /data/admin/keystore "/data/chain/chains/${CHAIN_ID}/keystore"

exec allfeat \
  --chain "${APP_ALLFEAT_CHAIN:-melodie}" \
  --name "${APP_ALLFEAT_NODE_NAME:-allfeat-validator}" \
  --base-path /data/chain \
  --node-key-file "/data/chain/chains/${CHAIN_ID}/network/secret_ed25519" \
  --validator \
  --no-hardware-benchmarks \
  --database=paritydb \
  --port=30333
