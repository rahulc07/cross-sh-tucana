#!/bin/bash

# Exit on error
set -e 

# Source the configuration
source toolchain.conf

pkg=gcc
# Untar

cd $BUILD_DIR
tar -xvf $SOURCES_DIR/$pkg-$CC_VER.tar.xz
cd $pkg-$CC_VER

# Start the build

tar -xf $SOURCES_DIR/mpfr-4.1.0.tar.xz
mv -v mpfr-4.1.0 mpfr
tar -xf $SOURCES_DIR/gmp-6.2.1.tar.xz
mv -v gmp-6.2.1 gmp
tar -xf $SOURCES_DIR/mpc-1.2.1.tar.gz
mv -v mpc-1.2.1 mpc

mkdir build
cd build

CFLAGS_FOR_TARGET='-O2' CFLAGS='-O2' ../configure --prefix=/usr --enable-languages=c,c++ --disable-multilib --target=$TARGET_CROSS --disable-werror --with-sysroot=/usr/$TARGET_CROSS --with-build-sysroot=/usr/$TARGET_CROSS --with-local-prefix=/usr/$TARGET_CROSS --with-system-zlib 
make CFLAGS_FOR_TARGET='-O2' CFLAGS='-O2' BOOT_CFLAGS='-O2' -j$(nproc)
make DESTDIR=$LOCATION install
make DESTDIR=/pkgs/$TARGET_CROSS-$pkg install
# Thanks arch btw 
  find /pkgs/$TARGET_CROSS-$pkg/usr/bin/ /pkgs/$TARGET_CROSS-$pkg/usr/libexec/gcc/$TARGET_CROSS/ -type f -and \( -executable \) -exec strip '{}' \;
# Strip the target libs
find /pkgs/$TARGET_CROSS-$pkg/usr/$TARGET_CROSS/lib* -type f -executable -name '*.so*' -exec $TARGET_CROSS-strip {} \;

# Delete the old files
cd $BUILD_DIR
rm -rf $pkg-$CC_VER
