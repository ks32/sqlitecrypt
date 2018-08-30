.DEFAULT_GOAL := all
BIN_DIR := ${CURDIR}/bin
JNI_DIR := ${CURDIR}/jni
LIBS_DIR := ${CURDIR}/libs
EXTERNAL_DIR := ${CURDIR}/external
SQLITECRYPT_DIR := ${CURDIR}/external/sqlitecrypt
SQLITECRYPT_CFLAGS :=  -DHAVE_USLEEP=1 -DSQLITE_HAS_CODEC \
	-DSQLITE_DEFAULT_JOURNAL_SIZE_LIMIT=1048576 -DSQLITE_THREADSAFE=1 -DNDEBUG=1 \
	-DSQLITE_ENABLE_MEMORY_MANAGEMENT=1 -DSQLITE_TEMP_STORE=2 \
	-DSQLITE_ENABLE_FTS3_BACKWARDS -DSQLITE_ENABLE_LOAD_EXTENSION \
	-DSQLITE_ENABLE_MEMORY_MANAGEMENT -DSQLITE_ENABLE_COLUMN_METADATA \
	-DSQLITE_ENABLE_FTS4 -DSQLITE_ENABLE_UNLOCK_NOTIFY -DSQLITE_ENABLE_RTREE \
	-DSQLITE_SOUNDEX -DSQLITE_ENABLE_STAT3 -DSQLITE_ENABLE_FTS4_UNICODE61 \
	-DSQLITE_THREADSAFE -DSQLITE_ENABLE_JSON1 -DSQLITE_ENABLE_FTS3_PARENTHESIS \
	-DSQLITE_ENABLE_STAT4 -DSQLITE_ENABLE_FTS5

.PHONY: clean develop-zip release-zip release

init-environment:
	android update project -p ${CURDIR}

build-amalgamation:
	cd ${SQLITECRYPT_DIR} && \
		CFLAGS="${SQLITECRYPT_CFLAGS}" && \
	make sqlite3.c

build-java:
	ant release

build-native:
	cd ${JNI_DIR} && \
	ndk-build V=1 --environment-overrides NDK_LIBS_OUT=$(JNI_DIR)/libs \
		SQLITECRYPT_CFLAGS="${SQLITECRYPT_CFLAGS}"

clean-java:
	ant clean
	rm -rf ${LIBS_DIR}

clean-ndk:
	rm -rf obj
	-cd ${JNI_DIR} && \
	ndk-build clean

clean: clean-ndk clean-java
	-cd ${SQLITECRYPT_DIR} && \
	rm -f *.o && \
	rm -f *.zip

distclean: clean
	rm -rf ${EXTERNAL_DIR}/android-libs

copy-libs:
	cp -R ${JNI_DIR}/libs/* ${LIBS_DIR}

release-aar:
	-rm ${LIBS_DIR}/sqlitecrypt.jar
	-rm ${LIBS_DIR}/sqlitecrypt-javadoc.jar
	mvn package

all: init-environment build-amalgamation build-native build-java copy-libs
