basepath=$(cd `dirname $0`; pwd)
echo =====onekeybuild-ios=====
#build protobuf
cd $basepath
cd ../protobuf-cpp
find . -name '*.h' | xargs sed -i '' 's/google:/googlex:/g'
find . -name '*.cc' | xargs sed -i '' 's/google:/googlex:/g'
find . -name '*.h' | xargs sed -i '' 's/google /googlex /g'
find . -name '*.cc' | xargs sed -i '' 's/google /googlex /g'
mkdir ./build_ios
cd ./build_ios
rm ./CMakeCache.txt
cmake ../cmake/ -DCMAKE_TOOLCHAIN_FILE=../cmake/ios.toolchain.cmake -DCMAKE_BUILD_TYPE=Release
make -j 10 libprotobuf

#build tolua_runtime
cd $basepath
cp ../protobuf-cpp/build_ios/libprotobuf.a ./Plugins/iOS/
cd ./LuaPbIntf
find . -name '*.h' | xargs sed -i '' 's/google:/googlex:/g'
find . -name '*.cpp' | xargs sed -i '' 's/google:/googlex:/g'
find . -name '*.h' | xargs sed -i '' 's/google /googlex /g'
find . -name '*.cpp' | xargs sed -i '' 's/google /googlex /g'
cd ..
mkdir ./build_ios
cd ./build_ios
rm ./CMakeCache.txt
cmake ../ -DCMAKE_TOOLCHAIN_FILE=../cmake/ios.toolchain.cmake -DCMAKE_BUILD_TYPE=Release
make -j 10

echo libtolua.a "=>" $(pwd|awk '{print $1"/libtolua.a"}')