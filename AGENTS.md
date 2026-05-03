# Agent Notes

- This repo is Umbrel packaging only; do not depend on the Allfeat source tree layout.
- Keep the app store id `allfeat` and the app id/folder `allfeat-validator` unless you are intentionally renaming the packaging.
- The validator image is pulled from `ghcr.io/plzrf/allfeat-validator:latest`; do not vendor the binary or store validator keys in the image.
- Keep the app validator-only with default chain `melodie`.
- Persistent state is split on purpose: `data/chain` is chain state, and `data/admin` holds config, keystore, identity, and logs.
- `hooks/pre-start` creates `data/admin/config/node.env`, `keystore`, `identity`, and `logs`, reads any existing `node.env` before deriving the chain, generates a raw 32-byte `data/chain/chains/<chain>/network/secret_ed25519` on first start if missing or invalid, then chowns `data/` to `1000:1000`.
- `docker-compose.yml` maps `APP_ALLFEAT_CHAIN=melodie` to `melodie_3_staging` and `mainnet` or `allfeat` to `allfeat_staging`; other values are passed through.
- `umbrel-app.yml` uses `port: 8081` so the app proxy does not collide with Umbrel's own node on host port `80`.
- `allfeat-validator-node/icon.png` is generated from `../Allfeat/docs/logo.svg` and used as the app tile icon.
- Public P2P is `30333`; RPC stays private.
- Manual key import is expected after install; the keys that matter are GRANDPA, Aura, and `im_online`. The reference flow is `scripts/insert_keys.sh` in the main Allfeat repo.
- If startup behavior changes, keep Umbrel 1.7 private app packaging compatibility (`umbrel-app.yml`, `docker-compose.yml`, optional `hooks/` and `web/`).
