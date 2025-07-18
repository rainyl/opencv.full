root_dir=$(pwd)
mkdir -p $root_dir/build
cmake -S $root_dir/opencv -B $root_dir/build -G Ninja \
    `cat $root_dir/options.txt` \
    -DCMAKE_TOOLCHAIN_FILE=$root_dir/cmake/ios.toolchain.cmake \
    -DDEPLOYMENT_TARGET=10.15 \
    -DENABLE_BITCODE=OFF \
    -DENABLE_ARC=OFF \
    -DENABLE_VISIBILITY=OFF \
    -DCMAKE_INSTALL_PREFIX=$root_dir/build/install \
    -DCMAKE_BUILD_TYPE=Release \
    -DOPENCV_EXTRA_MODULES_PATH="$root_dir/opencv_contrib/modules" \
    -DCMAKE_POLICY_DEFAULT_CMP0074=NEW \
    -DWITH_OPENCL_SVM=OFF \
    -DPLATFORM=MAC_ARM64 \
    -DWITH_FFMPEG=ON \
    -DFFMPEG_DIR=$root_dir/cmake \
    -DFFMPEG_ROOT=$root_dir/ffmpeg-7.1-macOS-default \
    -DBUILD_opencv_world=OFF

cmake --build $root_dir/build --config Release --target install
