#!/usr/bin/env bash

# strip debug symbols
export RUSTFLAGS="-C strip=symbols"

cargo-bundle-licenses --format yaml --output THIRDPARTY.yml

# build statically linked binary with Rust
cargo install --locked --root "$PREFIX" --path crates/cli

# remove extra build file
rm -f "${PREFIX}/.crates.toml"
