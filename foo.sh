#!/bin/bash
#
#
# 88""Yb 88""Yb  dP"Yb  888888  dP"Yb  88""Yb 88      dP"Yb   dP""b8 88  dP 
# 88__dP 88__dP dP   Yb   88   dP   Yb 88__dP 88     dP   Yb dP   `" 88odP  
# 88"""  88"Yb  Yb   dP   88   Yb   dP 88""Yb 88  .o Yb   dP Yb      88"Yb  
# 88     88  Yb  YbodP    88    YbodP  88oodP 88ood8  YbodP   YboodP 88  Yb                                                                                                                       '                   
#
# 080 114 111 116 111 098 108 111 099 107
# 01010000 01110010 01101111 01110100 01101111 01000010 01101100 01101111 01100011 01101011
#
# contact@protoblock.com
#
# FIXME make options to pass in for the following
# + ndk root location
# + android cross build usr path
# + Version of protobuf to build
# 
#
# FIXME pkgconf is not working oob
#


INSTALLPATH=/Users/satoshi/Desktop/fc/prebuilt/android/extrenal-android-2.5.0

BUILDDIR=$(pwd)/build-protobuf-android-2.5.0
PREFIX=`pwd`/protobuf/android-2.5.0
rm -rf ${PREFIX} ${BUILDDIR}

mkdir -p ${PREFIX}
mkdir -p ${BUILDDIR}

export NDK=/Users/satoshi/Desktop/ndk/android-ndk-r10e
 
# 1. Use the tools from the Standalone Toolchain
export PATH=/Users/satoshi/Desktop/ndk/android-ndk-r10e/build/toolchain/bin:$PATH
export SYSROOT=/Users/satoshi/Desktop/ndk/android-ndk-r10e/build/toolchain/sysroot
export CC="arm-linux-androideabi-gcc --sysroot $SYSROOT"
export CXX="arm-linux-androideabi-g++ --sysroot $SYSROOT"
export CXXSTL=$NDK/sources/cxx-stl/gnu-libstdc++/4.9
 
##########################################
# Fetch Protobuf 2.5.0 from source.
##########################################

(
    cd $BUILDDIR
    wget https://github.com/google/protobuf/releases/download/v2.5.0/protobuf-2.5.0.tar.gz
	tar xf $BUILDDIR/protobuf-2.5.0.tar.gz
)


cd $BUILDDIR/protobuf-2.5.0

 
# 3. Run the configure to target a static library for the ARMv7 ABI
# for using protoc, you need to install protoc to your OS first, or use another protoc by path
./configure \
		--prefix=$INSTALLPATH/ \
		--host=arm-linux-androideabi \
		--with-sysroot=$SYSROOT \
		--enable-cross-compile \
		--with-protoc=/Users/satoshi/Desktop/fc/ios/extrenal/prototbuf/platform/x86_64/bin/protoc \
		CFLAGS="-march=armv7-a" \
		CXXFLAGS="-march=armv7-a -I$CXXSTL/include -I$CXXSTL/libs/armeabi-v7a/include"
 
# 4. Build
make
make install
 
# 5. Inspect the library architecture specific information
# arm-linux-androideabi-readelf -A $INSTALLPATH/lib/libprotobuf-lite.a

# cp build/lib/libprotobuf.a $PREFIX/libprotobuf.a
# cp build/lib/libprotobuf-lite.a $PREFIX/libprotobuf-lite.a
