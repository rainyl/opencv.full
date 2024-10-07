#!/bin/zsh

set -ex

SRC_DIR=$1
# SRC_SUB_DIR=${1##*/}

FRAMEWORK_NAME="opencv2"
FRAMEWORK_DIR=$2

SCRIPT_DIR=$(dirname $0)

# if [ $(test -s $SRC_DIR && echo true) == true ]; then
#     echo "AAA"
# fi

rm -rf $FRAMEWORK_DIR
mkdir -p $FRAMEWORK_DIR/Versions/A/Headers
mkdir -p $FRAMEWORK_DIR/Versions/A/Resources
ln -s A $FRAMEWORK_DIR/Versions/Current
ln -s Versions/Current/Headers $FRAMEWORK_DIR/Headers
ln -s Versions/Current/Resources $FRAMEWORK_DIR/Resources
ln -s Versions/Current/$FRAMEWORK_NAME $FRAMEWORK_DIR/$FRAMEWORK_NAME

libtool -static -o $SRC_DIR/lib/libopencv.a $SRC_DIR/lib/**/*.a
lipo -create \
    $SRC_DIR/lib/libopencv.a \
    -o $FRAMEWORK_DIR/Versions/A/$FRAMEWORK_NAME

cp -r $SRC_DIR/include/opencv4/opencv2/* $FRAMEWORK_DIR/Versions/A/Headers/ || :
cp "$SCRIPT_DIR/Info.plist" $FRAMEWORK_DIR/Versions/A/Resources/
cp "$SCRIPT_DIR/PrivacyInfo.xcprivacy" $FRAMEWORK_DIR/Versions/A/Resources/

# zip -9 -y -r $SRC_DIR.zip $SRC_DIR.framework
