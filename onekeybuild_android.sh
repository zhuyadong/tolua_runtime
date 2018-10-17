basepath=$(cd `dirname $0`; pwd)
echo "===== onekeybuild-android ====="
#build protobuf
cd $basepath
cd ../protobuf-cpp
find . -name '*.h' | xargs sed -i '' 's/google:/googlex:/g'
find . -name '*.cc' | xargs sed -i '' 's/google:/googlex:/g'
find . -name '*.h' | xargs sed -i '' 's/google /googlex /g'
find . -name '*.cc' | xargs sed -i '' 's/google /googlex /g'
mkdir ./build_android
cd ./build_android
##armeabi-v7a
echo "- build protobuf - armeabi-v7a"
rm ./CMakeCache.txt
cmake ../cmake/ -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI="armeabi-v7a"
make -j 7 libprotobuf
mkdir armeabi-v7a
cp ./libprotobuf.a ./armeabi-v7a/
##arm64-v8a
echo "- build protobuf - arm64-v8a"
rm ./CMakeCache.txt
cmake ../cmake/ -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI="arm64-v8a"
make -j 7 libprotobuf
mkdir arm64-v8a
cp ./libprotobuf.a ./arm64-v8a/
##x86
echo "- build protobuf - x86"
rm ./CMakeCache.txt
cmake ../cmake/ -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI="x86"
make -j 7 libprotobuf
mkdir x86
cp ./libprotobuf.a ./x86/

#build tolua_runtime
cd $basepath
cd ./LuaPbIntf
find . -name '*.h' | xargs sed -i '' 's/google:/googlex:/g'
find . -name '*.cpp' | xargs sed -i '' 's/google:/googlex:/g'
find . -name '*.h' | xargs sed -i '' 's/google /googlex /g'
find . -name '*.cpp' | xargs sed -i '' 's/google /googlex /g'
cd ..

mkdir ./android/jni/armeabi-v7a
cp ../protobuf-cpp/build_android/armeabi-v7a/libprotobuf.a ./android/jni/armeabi-v7a/
mkdir ./android/jni/arm64-v8a
cp ../protobuf-cpp/build_android/arm64-v8a/libprotobuf.a ./android/jni/arm64-v8a/
mkdir ./android/jni/x86
cp ../protobuf-cpp/build_android/x86/libprotobuf.a ./android/jni/x86/

mkdir ./build_android
cd ./build_android

echo "- build tolua_runtime - armeabi-v7a"
rm ./CMakeCache.txt
cmake ../ -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI=armeabi-v7a
make -j 7 
mkdir ./armeabi-v7a
cp ./libtolua.so ./armeabi-v7a/

# echo "- build tolua_runtime - arm64-v8a"
# cmake ../ -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI=arm64-v8a
# make -j 7 
# mkdir arm64-v8a
# cp ./libtolua.so ./arm64-v8a/

echo "- build tolua_runtime - x86"
rm ./CMakeCache.txt
cmake ../ -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI=x86
make -j 7 
mkdir ./x86
cp ./libtolua.so ./x86/

echo "--- output libtolua.so"
echo libtolua.so "=>" $(pwd|awk '{print $1"/armeabi-v7a/libtolua.so"}')
#echo libtolua.so "=>" $(pwd|awk '{print $1"/arm64-v8a/libtolua.so"}')
echo libtolua.so "=>" $(pwd|awk '{print $1"/x86/libtolua.so"}')
