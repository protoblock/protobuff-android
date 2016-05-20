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

```````````````````````````````````````````````````````````

NOTE YOU CAN ONLY USE THIS TO BUILD PROTOBUF > 2.6.1

```````````````````````````````````````````````````````````


Usage 
$0 [option]
 
 Options
		[ --debug, -d , -v --verbose ]
			Print std out in debug mode
 		
 		[ --release, -r ]
			Print std in release mode

		[ --help, -h, h , ? ]
			Print this help

 
Eample: 
	$0 -r
_EOF_
exit 1;
}



if [ $# -lt 1 ]; 
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

if [ -d /tmp/protobuf-android ];
	then 
	rm -rf /tmp/protobuf-android
fi

git clone https://github.com/protoblock/protobuf-android.git
cd /tmp/protobuf-android
$NDK_HOME/ndk-build

 
# 5. Inspect the library architecture specific information
# arm-linux-androideabi-readelf -A /tmp/protobuf-$2/src/.libs/libprotobuf-lite.a

# cp /tmp/protobuf-$2/src/.libs/libprotobuf.a $PREFIX/lib/libprotobuf.a
# cp /tmp/protobuf-$2/src/.libs/libprotobuf-lite.a $PREFIX/lib/libprotobuf-lite.a
# cp /tmp/protobuf-$2/src/.libs/libprotoc.a $PREFIX/lib/libprotoc.a


# mkdir -p $HOME/bin/protobuf/android/include/google/protobuf/
# cp -r /tmp/protobuf-$2/src/google/protobuf $PREFIX/include/google/






https://github.com/protoblock/protobuf-android.git