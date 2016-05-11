#!/bin/bash 

NDK_HOME=$HOME/Desktop/ndk/android-ndk-r11c
export ANDROID_NDK_ROOT=$NDK_HOME
export PATH=$NDK_HOME/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64/bin/:$PATH
export SYSROOT=$NDK_HOME/platforms/android-24/arch-arm/
export CC="arm-linux-androideabi-gcc --sysroot $SYSROOT"
export CXX="arm-linux-androideabi-g++ --sysroot $SYSROOT"
export CXXSTL=$NDK_HOME/sources/cxx-stl/gnu-libstdc++/4.9/
export CFLAGS="-fPIC -DANDROID -nostdlib"

$NDK_HOME/ndk-build -C /tmp/protobuf-2.5.0/
