# Allfeat Validator Umbrel App

Private Umbrel packaging for an Allfeat validator node.

## Layout

- `data/chain`: Substrate database and chain state
- `data/admin`: validator keys, node config, identity, logs

## Defaults

- Chain: `melodie`
- Role: validator-only
- Public P2P: `30333`
- RPC: not exposed

## Chain switch

Edit `data/admin/config/node.env` and change `APP_ALLFEAT_CHAIN` to `mainnet`, then restart the app.

## Manual key import

Import validator keys after installation so they persist across app updates. The imported keys should go into the persistent admin keystore.

Allfeat validators need the GRANDPA, Aura, and im_online authority keys. See `scripts/insert_keys.sh` in the main repo for the expected import pattern.

## VPS forwarding

The node should advertise the VPS-facing P2P address once the tunnel is ready. The compose file does not wire that flag yet; we will add it once we verify the exact Allfeat CLI option.
