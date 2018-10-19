basepath=$(cd `dirname $0`; pwd)
echo "===== prebuild-win-step2 ====="
cp ../protobuf-cpp/build_win/x86/Release/libprotobuf.lib ./window/x86/
cp ../protobuf-cpp/build_win/x64/Release/libprotobuf.lib ./window/x86_64/
cp ../protobuf-cpp/build_win/x86/Debug/libprotobufd.lib ./window/x86/
cp ../protobuf-cpp/build_win/x64/Debug/libprotobufd.lib ./window/x86_64/

echo "prebuild-win-step2 done"
