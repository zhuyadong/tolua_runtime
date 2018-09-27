LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := libluajit
LOCAL_SRC_FILES := libluajit.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := luapbintf

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../LuaPbIntf/src
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../LuaPbIntf/third_party/lua-intf

LOCAL_CPPFLAGS := -O2 -std=c++11
LOCAL_SRC_FILES := ../../LuaPbIntf/src/LuaPbIntf.cpp \
    ../../LuaPbIntf/src/detail/LuaPbIntfImpl.cpp \
    ../../LuaPbIntf/src/detail/MessageSetter.cpp \
    ../../LuaPbIntf/src/detail/MsgToTbl.cpp \

include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_MODULE := tolua
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../luajit-2.1/src
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../

LOCAL_CPPFLAGS := -O2
LOCAL_CFLAGS :=  -O2 -std=gnu99
LOCAL_SRC_FILES :=	../../tolua.c \
					../../int64.c \
					../../uint64.c \
					../../pb.c \
					../../lpeg.c \
					../../struct.c \
					../../cjson/strbuf.c \
					../../cjson/lua_cjson.c \
					../../cjson/fpconv.c \
					../../luasocket/auxiliar.c \
 					../../luasocket/buffer.c \
 					../../luasocket/except.c \
 					../../luasocket/inet.c \
 					../../luasocket/io.c \
 					../../luasocket/luasocket.c \
 					../../luasocket/mime.c \
 					../../luasocket/options.c \
 					../../luasocket/select.c \
 					../../luasocket/tcp.c \
 					../../luasocket/timeout.c \
 					../../luasocket/udp.c \
 					../../luasocket/usocket.c \
 					
LOCAL_WHOLE_STATIC_LIBRARIES += libluajit luapbintf
include $(BUILD_SHARED_LIBRARY)