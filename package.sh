#!/bin/bash
source toolchain.conf
mkdir -p /pkgs/$TARGET_CROSS/var/cache/mercury/meta-pkgs
echo "$TARGET_CROSS-binutils $TARGET_CROSS-gcc $TARGET_CROSS-glibc $TARGET_CROSS-linux-api-headers" > /pkgs/$TARGET_CROSS/depends
echo "$TARGET_CROSS-binutils $TARGET_CROSS-gcc $TARGET_CROSS-glibc $TARGET_CROSS-linux-api-headers" > /pkgs/$TARGET_CROSS/var/cache/mercury/meta-pkgs/$TARGET_CROSS
cd /pkgs
touch /pkgs/$TARGET_CROSS-linux-api-headers/depends
touch /pkgs/$TARGET_CROSS-binutils/depends
touch /pkgs/$TARGET_CROSS-gcc/depends
touch /pkgs/$TARGET_CROSS-glibc/depends
tar -cvzpf $TARGET_CROSS-gcc.tar.xz $TARGET_CROSS-gcc
tar -cvzpf $TARGET_CROSS-glibc.tar.xz $TARGET_CROSS-glibc
tar -cvpzf $TARGET_CROSS-binutils.tar.xz $TARGET_CROSS-binutils
tar -cvzpf $TARGET_CROSS-linux-api-headers.tar.xz $TARGET_CROSS-linux-api-headers
mv $TARGET_CROSS*.tar.xz /finished
