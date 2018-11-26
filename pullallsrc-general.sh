#新建一个文件夹，将pullallsrc.sh拷贝到该目录下，执行，拉取所有代码，之后进入tolua_runtime
#执行onkeybuild_android.sh编译android版
#执行onkeybuild_ios.sh编译ios版
git clone https://github.com/zhuyadong/LuaPbIntf
git clone  -b 3.6.x --recursive https://github.com/protocolbuffers/protobuf protobuf-cpp
cd ./protobufcpp
git checkout -b v360 v3.6.0
cd ..
git clone https://github.com/zhuyadong/tolua_runtime 
mv ./LuaPbIntf ./tolua_runtime/
cp ./tolua_runtime/cmake/ios.toolchain.cmake ./protobuf-cpp/cmake/