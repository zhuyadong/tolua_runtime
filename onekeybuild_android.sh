basepath=$(cd `dirname $0`; pwd)
echo =====onekeybuild-android=====
#build protobuf
cd $basepath
cd ../protobuf-cpp
find . -name '*.h' | xargs sed -i '' 's/google:/googlex:/g'
find . -name '*.cc' | xargs sed -i '' 's/google:/googlex:/g'
find . -name '*.h' | xargs sed -i '' 's/google /googlex /g'
find . -name '*.cc' | xargs sed -i '' 's/google /googlex /g'
mkdir ./build_android
cd ./build_android
cmake ../cmake/ -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake -DCMAKE_BUILD_TYPE=Release
make -j 6 libprotobuf

#build tolua_runtime
cd $basepath
cp ../protobuf-cpp/build_android/libprotobuf.a ./android/jni/
cd ./LuaPbIntf
find . -name '*.h' | xargs sed -i '' 's/google:/googlex:/g'
find . -name '*.cpp' | xargs sed -i '' 's/google:/googlex:/g'
find . -name '*.h' | xargs sed -i '' 's/google /googlex /g'
find . -name '*.cpp' | xargs sed -i '' 's/google /googlex /g'
cd ..
mkdir ./build_android
cd ./build_android
cmake ../ -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake -DCMAKE_BUILD_TYPE=Release
make -j 7 

echo libtolua.so "=>" $(pwd|awk '{print $1"/libtolua.so"}')