#!/usr/bin/env bash

# strip debug symbols
export RUSTFLAGS="-C strip=symbols"

# protoc for moon_daemon_proto build script
export PROTOC="$BUILD_PREFIX/bin/protoc"

# aws-lc-sys 0.45 + cc 1.6: jitterentropy must build without -O (aws/aws-lc-rs#1252)
export AWS_LC_SYS_CFLAGS="$(echo "$CFLAGS" | sed -E 's/(^| )-O[^ ]*//g')"

# check licenses
cargo-bundle-licenses --format yaml --output THIRDPARTY.yml

# build
cargo install --locked --root "$PREFIX" --path crates/cli

# remove extra build file
rm -f "${PREFIX}/.crates.toml"
