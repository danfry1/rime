#!/usr/bin/env bash
# Loads the colorscheme headlessly; exits non-zero on any Lua error.
set -euo pipefail
SLUG="$(bun -e 'console.log(require("./palette.json").name.toLowerCase().replace(/[^a-z0-9]+/g,"-"))')"
nvim --headless -u NONE \
  --cmd "set rtp+=$(pwd)" \
  -c "lua vim.g.colors_name=nil" \
  -c "colorscheme ${SLUG}" \
  -c "lua print('NVIM_LOAD_OK')" \
  -c "qa!" 2>&1 | tee /tmp/nvim-smoke.out
grep -q NVIM_LOAD_OK /tmp/nvim-smoke.out
