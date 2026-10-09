#!/usr/bin/env bash

# strip debug symbols
export RUSTFLAGS="-C strip=symbols"

# protoc for moon_daemon_proto build script
export PROTOC="$BUILD_PREFIX/bin/protoc"

# aws-lc-sys 0.45 + cc 1.6: jitterentropy must build without -O (aws/aws-lc-rs#1252).
# cc 1.6 appends both CFLAGS and CFLAGS_<target>; strip -O from CFLAGS and override
# CFLAGS_<target> for aws-lc-sys only. Other crates keep -O2 via CFLAGS_<target>.
export CFLAGS="$(echo "$CFLAGS" | sed -E 's/(^| )-O[^ ]*//g')"
export AWS_LC_SYS_CFLAGS="$CFLAGS"

# check licenses
cargo-bundle-licenses --format yaml --output THIRDPARTY.yml

# build
cargo install --locked --root "$PREFIX" --path crates/cli

# remove extra build file
rm -f "${PREFIX}/.crates.toml"
