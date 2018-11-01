basepath=$(cd `dirname $0`; pwd)
echo =====onekeybuild-osx=====
#build protobuf
cd $basepath
cd ../protobuf-cpp
find . -name '*.h' | xargs sed -i '' 's/google:/googlex:/g'
find . -name '*.cc' | xargs sed -i '' 's/google:/googlex:/g'
find . -name '*.h' | xargs sed -i '' 's/google /googlex /g'
find . -name '*.cc' | xargs sed -i '' 's/google /googlex /g'
# 原生编译方式
# ./autogen.sh
# ./configure
# make clean
# make -j 7 libprotobuf
mkdir ./build_osx
cd ./build_osx
cmake ../cmake
make -j 6 libprotobuf
echo "./build_osx/libprotobuf.a"

#build tolua_runtime
cd $basepath
cp ../protobuf-cpp/build_osx/libprotobuf.a ./mac/
cd ./LuaPbIntf
find . -name '*.h' | xargs sed -i '' 's/google:/googlex:/g'
find . -name '*.cpp' | xargs sed -i '' 's/google:/googlex:/g'
find . -name '*.h' | xargs sed -i '' 's/google /googlex /g'
find . -name '*.cpp' | xargs sed -i '' 's/google /googlex /g'

cd ..
mkdir ./build_osx
cd ./build_osx
cmake ../
make clean
make -j 6
echo tolua.bundle "=>" $(pwd|awk '{print $1"/tolua.bundle"}')