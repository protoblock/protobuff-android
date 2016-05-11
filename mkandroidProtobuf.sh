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



printHelp(){
cat << _EOF_
#______________________________________________________________ #
#    ____                                                       #
#    /    )                          /     /               /    #
#---/____/---)__----__--_/_----__---/__---/----__----__---/-__- #
#  /        /   ) /   ) /    /   ) /   ) /   /   ) /   ' /(     #
#_/________/_____(___/_(_ __(___/_(___/_/___(___/_(___ _/___\__ #
#								#
#______________________________________________________________ #
#								#                                                              
Usage 
$0 [option] version
 
 Options
		[ --debug, -d , -v --verbose ]
			Print std out in debug mode
 		
 		[ --release, -r ]
			Print std in release mode

		[ --help, -h, h , ? ]
			Print this help
 
Eample: 
	$0 -r 2.5.0
_EOF_
exit 1;
}



if [ $# -lt 2 ]; 
then
	printHelp;
fi


if [ -z "$2" ]; 
then
	printHelp;
fi

DEBUG=0;
case "$1" in
    -d|--debug|d|v|--verbose)
    	DEBUG=1
    ;;
    -r|--release)
		DEBUG=0
	;;
        -h|--help|h|?)
    	printHelp;
    ;;
    *)
		printHelp
	;;
esac


# FIXME debug
if [ $DEBUG == 1 ];
 then
 		set -x
fi

PREFIX=$HOME/bin/protobuf/android
if [ -d $PREFIX ];
	then 
	rm -rf $HOME/bin/protobuf/
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
		if [ $DEBUG == 1 ];
		then
			tar -xvf android-ndk-r11c-darwin-x86.tar
		else
			tar -xf android-ndk-r11c-darwin-x86.tar
		fi
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
rm /tmp/protobuf-$2.tar.*
if [ -d /tmp/protobuf-$2.tar.gz ];
then
	rm -rf /tmp/protobuf-$2.tar.gz
fi

wget https://github.com/google/protobuf/releases/download/v$2/protobuf-$2.tar.gz
echo "Extracting protobuf"
tar xf /tmp/protobuf-$2.tar.gz

cd /tmp/protobuf-$2/

mkdir build

./configure --prefix=/tmp/protobuf-$2/build \
--host=arm-linux-androideabi \
--with-sysroot=$SYSROOT \
--enable-cross-compile \
--with-protoc=protoc \
--disable-shared \
CFLAGS="-march=armv7-a" \
CXXFLAGS="-march=armv7-a -I$CXXSTL/include -I$CXXSTL/libs/armeabi-v7a/include"
 

# 4. Build
make all
make check
make install
 
# 5. Inspect the library architecture specific information
arm-linux-androideabi-readelf -A /tmp/protobuf-$2/src/.libs/libprotobuf-lite.a

cp /tmp/protobuf-$2/src/.libs/libprotobuf.a $PREFIX/lib/libprotobuf.a
cp /tmp/protobuf-$2/src/.libs/libprotobuf-lite.a $PREFIX/lib/libprotobuf-lite.a
cp /tmp/protobuf-$2/src/.libs/libprotoc.a $PREFIX/lib/libprotoc.a


mkdir -p $HOME/bin/protobuf/android/include/google/protobuf/
cp -r /tmp/protobuf-$2/src/google/protobuf $PREFIX/include/google/

