cmake_minimum_required(VERSION 3.6.0)
project(tolua VERSION 0.1.0)
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS TRUE)
include(cmake/ucm.cmake)
ucm_set_runtime(STATIC)

include_directories(SYSTEM
    ${tolua_SOURCE_DIR}/luajit-2.1/src
    ${tolua_SOURCE_DIR}/protobuf/include
    ${tolua_SOURCE_DIR}/LuaPbIntf/src
    ${tolua_SOURCE_DIR}/LuaPbIntf/third_party/lua-intf
)
if(${CMAKE_BUILD_TYPE} MATCHES "Release")
    link_directories(
        ${tolua_SOURCE_DIR}/window/x86_64
        #${tolua_SOURCE_DIR}/LuaPbIntf/premake/vs2017/bin/x64/Release
        ${tolua_SOURCE_DIR}/protobuf/lib
        )
else()
    link_directories(
        ${tolua_SOURCE_DIR}/window/x86_64
        #${tolua_SOURCE_DIR}/LuaPbIntf/premake/vs2017/bin/x64/Release
        ${tolua_SOURCE_DIR}/protobuf/lib
        )
endif()
set(tolua_SOURCES
    ${tolua_SOURCE_DIR}/cjson/fpconv.c
    ${tolua_SOURCE_DIR}/cjson/lua_cjson.c
    ${tolua_SOURCE_DIR}/cjson/strbuf.c
    ${tolua_SOURCE_DIR}/luasocket/auxiliar.c
    ${tolua_SOURCE_DIR}/luasocket/buffer.c
    ${tolua_SOURCE_DIR}/luasocket/except.c
    ${tolua_SOURCE_DIR}/luasocket/inet.c
    ${tolua_SOURCE_DIR}/luasocket/io.c
    ${tolua_SOURCE_DIR}/luasocket/luasocket.c
    ${tolua_SOURCE_DIR}/luasocket/luasocket_scripts.c
    ${tolua_SOURCE_DIR}/luasocket/mime.c
    ${tolua_SOURCE_DIR}/luasocket/options.c
    ${tolua_SOURCE_DIR}/luasocket/select.c
    ${tolua_SOURCE_DIR}/luasocket/tcp.c
    ${tolua_SOURCE_DIR}/luasocket/timeout.c
    ${tolua_SOURCE_DIR}/luasocket/udp.c
    ${tolua_SOURCE_DIR}/luasocket/wsocket.c
    ${tolua_SOURCE_DIR}/bit.c
    ${tolua_SOURCE_DIR}/int64.c
    ${tolua_SOURCE_DIR}/lpeg.c
    ${tolua_SOURCE_DIR}/struct.c
    ${tolua_SOURCE_DIR}/tolua.c
    ${tolua_SOURCE_DIR}/uint64.c
    ${tolua_SOURCE_DIR}/lua.def
)
add_library(tolua SHARED
    ${tolua_SOURCES}
)

set(pb_SOURCES 
    ${tolua_SOURCE_DIR}/LuaPbIntf/src/LuaPbIntf.cpp
    ${tolua_SOURCE_DIR}/LuaPbIntf/src/detail/LuaPbIntfImpl.cpp
    ${tolua_SOURCE_DIR}/LuaPbIntf/src/detail/MessageSetter.cpp
    ${tolua_SOURCE_DIR}/LuaPbIntf/src/detail/MsgToTbl.cpp
)
add_library(luapbintf STATIC
    ${pb_SOURCES}
)
if (MSVC)
    add_definitions(
        /wd4244
        /wd4267
        /wd4133
        /wd4996
    )
endif()

if(${CMAKE_BUILD_TYPE} MATCHES "Release")
    target_link_libraries(tolua
        lua51
        ws2_32
        luapbintf
        libprotobuf
        )
else()
    target_link_libraries(tolua
        lua51
        ws2_32
        luapbintf
        libprotobuf
        )
endif()