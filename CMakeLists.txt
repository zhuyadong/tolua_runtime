cmake_minimum_required(VERSION 3.6.0)
project(tolua VERSION 0.1.0)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS TRUE)
include(cmake/ucm.cmake)
ucm_set_runtime(STATIC)

if(CMAKE_FORCE_PLATFORM_NAME MATCHES OSX)
    message("=====this is osx")
else()
    message("=====this is not osx")
endif()

include_directories(SYSTEM
    ${tolua_SOURCE_DIR}/../protobuf-cpp/src
    ${tolua_SOURCE_DIR}/LuaPbIntf/src
    ${tolua_SOURCE_DIR}/LuaPbIntf/third_party/lua-intf
)

if(CMAKE_FORCE_PLATFORM_NAME MATCHES OSX)
    include_directories(SYSTEM
        ${tolua_SOURCE_DIR}/lua-5.1.5/src
    )
else()
    include_directories(SYSTEM
        ${tolua_SOURCE_DIR}/luajit-2.1/src
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
    ${tolua_SOURCE_DIR}/LuaPbIntf/src/LuaPbIntf.cpp
    ${tolua_SOURCE_DIR}/LuaPbIntf/src/detail/LuaPbIntfImpl.cpp
    ${tolua_SOURCE_DIR}/LuaPbIntf/src/detail/MessageSetter.cpp
    ${tolua_SOURCE_DIR}/LuaPbIntf/src/detail/MsgToTbl.cpp
)
if (MSVC)
    if(CMAKE_VS_PLATFORM_NAME MATCHES x64)
        link_directories(
        ${tolua_SOURCE_DIR}/window/x86_64
        ${tolua_SOURCE_DIR}/protobuf/lib
    )
    else()
        link_directories(
        ${tolua_SOURCE_DIR}/window/x86
        ${tolua_SOURCE_DIR}/protobuf/lib
    )
    endif()
    add_definitions(
        /wd4244
        /wd4267
        /wd4133
        /wd4996
    )
else()
    if(CMAKE_SYSTEM_NAME MATCHES "Android")
        if(ANDROID_ABI MATCHES armeabi-v7a)
            link_directories(
                ${tolua_SOURCE_DIR}/android/jni/armeabi-v7a
            )    
        elseif(ANDROID_ABI MATCHES arm64-v8a)
            link_directories(
                ${tolua_SOURCE_DIR}/android/jni/arm64-v8a
            )
        elseif(ANDROID_ABI MATCHES x86)
            link_directories(
                ${tolua_SOURCE_DIR}/android/jni/x86
            )
        endif()
    elseif(CMAKE_FORCE_PLATFORM_NAME MATCHES OSX)
            link_directories(
            ${tolua_SOURCE_DIR}/mac
        )
    else()
        link_directories(
            ${tolua_SOURCE_DIR}/protobuf/lib
        )
    endif()
    set(CMAKE_C_STANDARD 99)
    ucm_remove_files(${tolua_SOURCE_DIR}/luasocket/wsocket.c FROM tolua_SOURCES)
    ucm_add_files(${tolua_SOURCE_DIR}/luasocket/usocket.c TO tolua_SOURCES)
endif()
if (MSVC)
	add_library(tolua SHARED
	    ${tolua_SOURCES}
	)
elseif(CMAKE_SYSTEM_NAME MATCHES "Android")
	add_library(tolua SHARED
	    ${tolua_SOURCES}
	)
elseif(CMAKE_FORCE_PLATFORM_NAME MATCHES OSX)
    add_library(tolua MODULE ${tolua_SOURCES})
    set_target_properties(tolua PROPERTIES BUNDLE TRUE)
else()
	add_library(tolua STATIC
	    ${tolua_SOURCES}
	)
endif()


if(MSVC)
    target_link_libraries(tolua
        luajit
        ws2_32
        libprotobuf
        )
elseif(CMAKE_SYSTEM_NAME MATCHES "Android")
    target_link_libraries(tolua
            luajit
            protobuf
	        log
    )
elseif(CMAKE_FORCE_PLATFORM_NAME MATCHES OSX)
    target_link_libraries(tolua
            lua
            protobuf
    )
else()
    target_link_libraries(tolua
            luajit
            protobuf
    )
endif()
