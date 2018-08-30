This package provide Java interface to SQLiteCrypt for Android devices.

1. Compilation

In order to build android-database-sqlitecrypt from source you will need JDK 7 or later, Android SDK, Android NDK, Ant and Maven installed (don't forget to set environment variables). Use 64-bit Android NDK to target 64-bit platforms. Update your target in jni/Application.mk.
Copy SQLiteCrypt source code to external/sqlitecrypt then run make:
:  # to build the source
:  make

2. Using android-database-sqlitecrypt

Steps to follow:
a. There are two options:
   - Add a single sqlitecrypt.jar and a few .so’s (native libraries compiled to your platforms) to 	the application libs directory
   - or run 'make release-aar' to create android-database-sqlitecrypt-3.*.*.aar package and 	   	reference it
b. Update the import path from =android.database.sqlite.*= to =com.sqlitecrypt.database.*= in any source files that reference it. The original =android.database.Cursor= can still be used unchanged.
c.  Init the database in =onCreate()= and open database:

:  SQLiteDatabase.loadLibs(this); //first init the db libraries with the context
:  SQLiteOpenHelper.getWritableDatabase("password"); //if db is encrypted
:  SQLiteOpenHelper.getWritableDatabase(null); //if db is not encrypted

To encrypt normal database, run
   PRAGMA rekey='password';

   
