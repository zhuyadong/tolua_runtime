# tolua_runtime
**Build**<br>
pc: build_win32.sh build_win64.h  (mingw + luajit2.0.4) <br>
android: build_arm.sh build_x86.sh (mingw + luajit2.0.4) <br>
mac: build_osx.sh (xcode + luac5.1.5 for luajit can't run on unity5) <br>
ios: build_ios.sh (xcode + luajit2.1 beta) <br>

NDK 版本:android-ndk-r10e 默认安装到 D:/android-ndk-r10e<br>
https://dl.google.com/android/repository/android-ndk-r10e-windows-x86_64.zip<br>
Msys2配置说明<br>
https://github.com/topameng/tolua_runtime/wiki<br>
配置好的Msys2下载<br>
https://pan.baidu.com/s/1c2JzvDQ<br>

# Libs
**cjson**<br>
https://github.com/mpx/lua-cjson<br>
**protoc-gen-lua**<br>
https://github.com/topameng/protoc-gen-lua<br>
**LuaSocket** <br>
https://github.com/diegonehab/luasocket<br>
**struct**<br>
http://www.inf.puc-rio.br/~roberto/struct/<br>
**lpeg**<br>
http://www.inf.puc-rio.br/~roberto/lpeg/lpeg.html

# zhuyadong补充说明
现在编译android和ios，都在mac下编译
## android编译
* 下载ndk放到~/.local/android-ndk-r10e
* `$ export NDK=~/.local/android-ndk-r10e`
* `build_arm.sh`  这只会生成android/jni/libluajit.a，生成tolua看下面步骤
* `mkdir build_android && cd build_android`
* `cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/android.toolchain.cmake ..`
* `make` make之前，确认编译好的android版本的libprotobuf.a已经放在protobuf/lib下或者android/jni下

## iOS编译
确认装好了xcode, 并且`xcode-select -p`的输出是`/Applications/Xcode.app/Contents/Developer`
* `build_ios.sh`