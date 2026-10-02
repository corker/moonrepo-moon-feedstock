#!/usr/bin/env bash

# strip debug symbols
export RUSTFLAGS="-C strip=symbols"

# protoc for moon_daemon_proto build script
export PROTOC="$BUILD_PREFIX/bin/protoc"

# check licenses
cargo-bundle-licenses --format yaml --output THIRDPARTY.yml

# build
cargo install --locked --root "$PREFIX" --path crates/cli

# remove extra build file
rm -f "${PREFIX}/.crates.toml"
