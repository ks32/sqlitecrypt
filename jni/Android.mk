LOCAL_PATH := $(call my-dir)
MY_PATH := $(LOCAL_PATH)
include $(CLEAR_VARS)
LOCAL_PATH := $(MY_PATH)
SQLITECRYPT_DIR := $(LOCAL_PATH)/../external/sqlitecrypt
SQLITECRYPT_SRC := $(SQLITECRYPT_DIR)/sqlite3.c

LOCAL_CFLAGS +=  $(SQLITECRYPT_CFLAGS) -DLOG_NDEBUG
LOCAL_C_INCLUDES := $(SQLITECRYPT_DIR) $(LOCAL_PATH)
LOCAL_LDLIBS := -llog -latomic
LOCAL_LDFLAGS += -L$(LOCAL_PATH)/android-libs/$(TARGET_ARCH_ABI) -fuse-ld=bfd
LOCAL_MODULE    := libsqlitecrypt
LOCAL_SRC_FILES := $(SQLITECRYPT_SRC) \
	jni_exception.cpp \
	com_sqlitecrypt_database_SQLiteCompiledSql.cpp \
	com_sqlitecrypt_database_SQLiteDatabase.cpp \
	com_sqlitecrypt_database_SQLiteProgram.cpp \
	com_sqlitecrypt_database_SQLiteQuery.cpp \
	com_sqlitecrypt_database_SQLiteStatement.cpp \
	com_sqlitecrypt_CursorWindow.cpp \
	CursorWindow.cpp

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

