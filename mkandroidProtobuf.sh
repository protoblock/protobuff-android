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

PREFIX=$HOME/bin/protobuf/android
if [ -d $PREFIX ];
	then 
	rm -rf ${PREFIX}
	mkdir -p ${PREFIX}/lib
	mkdir -p ${PREFIX}/include
else 
	mkdir -p ${PREFIX}/lib
	mkdir -p ${PREFIX}/include/leveldb/
fi 

if [ -d $HOME/Desktop/ndk/android-ndk-r11c ];
	then
		echo "Already have the right version of ndk";
	else
		echo "Downloading the correct NDK toolkit";
		mkdir -p $HOME/Desktop/ndk/
		cd $HOME/Desktop/ndk/
		wget http://dl.google.com/android/repository/android-ndk-r11c-darwin-x86_64.zip
		bzip2 -d android-ndk-r11c-darwin-x86.tar.bz2
		tar -xf android-ndk-r11c-darwin-x86.tar
		## clean up
		## rm android-ndk-r11c-darwin-x86.tar
		## rm android-ndk-r11c-darwin-x86.tar.bz2
	fi


NDK_HOME=$HOME/Desktop/ndk/android-ndk-r11c
export ANDROID_NDK_ROOT=$NDK_HOME
export PATH=$NDK_HOME/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64/bin/:$PATH
export SYSROOT=$NDK_HOME/platforms/android-24/arch-arm/
export CC="arm-linux-androideabi-gcc --sysroot $SYSROOT"
export CXX="arm-linux-androideabi-g++ --sysroot $SYSROOT"
export CXXSTL=$NDK_HOME/sources/cxx-stl/gnu-libstdc++/4.9/
 
##########################################
# Download Protobuf
##########################################

cd /tmp
wget https://github.com/google/protobuf/releases/download/v2.6.1/protobuf-2.6.1.tar.gz
 
if [ -d /tmp/protobuf-2.6.1.tar.gz ];
then
	rm -rf /tmp/protobuf-2.6.1.tar.gz
fi

echo "Extracting protobuf"
tar xf /tmp/protobuf-2.6.1.tar.gz

cd /tmp/protobuf-2.6.1/

mkdir build

./configure --prefix=/tmp/protobuf-2.6.1/build \
--host=arm-linux-androideabi \
--with-sysroot=$SYSROOT \
--disable-shared \
--enable-cross-compile \
--with-protoc=/usr/local/bin/protoc \
CFLAGS="-march=armv7-a" \
CXXFLAGS="-march=armv7-a -I$CXXSTL/include -I$CXXSTL/libs/armeabi-v7a/include"
 
# 4. Build
make all
make install
 
# 5. Inspect the library architecture specific information
arm-linux-androideabi-readelf -A /tmp/protobuf-2.6.1/src/.libs/libprotobuf-lite.a

cp /tmp/protobuf-2.6.1/src/.libs/libprotobuf.a $PREFIX/lib/libprotobuf.a
cp /tmp/protobuf-2.6.1/src/.libs/libprotobuf-lite.a $PREFIX/lib/libprotobuf-lite.a
cp /tmp/protobuf-2.6.1/src/.libs/libprotoc.a $PREFIX/lib/libprotoc.a

mkdir -p $HOME/bin/protobuf/include/google/protobuf/
cp -r /tmp/protobuf-2.6.1/src/google/protobuf/ $PREFIX/include/google/protobuf/

