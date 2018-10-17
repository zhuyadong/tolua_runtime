#新建一个文件夹，将pullallsrc.sh拷贝到该目录下，执行，拉取所有代码，之后进入tolua_runtime
#执行onkeybuild_android.sh编译android版
#执行onkeybuild_ios.sh编译ios版
git clone https://github.com/shbrk/LuaPbIntf
git clone  -b cpp3.6.0 --recursive https://github.com/shbrk/protobuf-cpp
git clone https://github.com/zhuyadong/tolua_runtime 
mv ./LuaPbIntf ./tolua_runtime/
