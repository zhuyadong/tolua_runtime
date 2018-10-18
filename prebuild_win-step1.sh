basepath=$(cd `dirname $0`; pwd)
echo "===== prebuild-win-step1 ====="
#build protobuf
cd $basepath
cd ../protobuf-cpp
find . -name '*.h' | xargs sed -i 's/google:/googlex:/g'
find . -name '*.cc' | xargs sed -i 's/google:/googlex:/g'
find . -name '*.h' | xargs sed -i 's/google /googlex /g'
find . -name '*.cc' | xargs sed -i 's/google /googlex /g'
mkdir ./build_win
cd ./build_win
mkdir ./x86
mkdir ./x64

#build tolua_runtime
cd $basepath
cd ./LuaPbIntf
find . -name '*.h' | xargs sed -i 's/google:/googlex:/g'
find . -name '*.cpp' | xargs sed -i 's/google:/googlex:/g'
find . -name '*.h' | xargs sed -i 's/google /googlex /g'
find . -name '*.cpp' | xargs sed -i 's/google /googlex /g'
cd ..
mkdir ./build_win
cd ./build_win
mkdir ./x86
mkdir ./x64

echo "prebuild-win-step1 done"
