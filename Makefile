ZIP_FILES := customize.sh META-INF module.prop system
VERSION = v3.49.1
VERSIONCODE = 20250220
.PHONY: module.prop system/bin zip

default: module.prop system/bin zip

zip:
	rm -f SQLite-$(VERSION)-for-magisk.multi-arch.zip
	zip -9 -r SQLite-$(VERSION)-for-magisk.multi-arch.zip $(ZIP_FILES)

module.prop:
	sed -i 's/version=.*$$/version=$(VERSION)/' module.prop
	sed -i 's/versionCode=.*$$/versionCode=$(VERSIONCODE)/' module.prop

sqlite3-android:
	make -C ../sqlite3-android clean
	make -C ../sqlite3-android

system/bin:
	mkdir -p system/bin
	cp ../sqlite3-android/libs/arm64-v8a/sqlite3-static	system/bin/sqlite3.arm64
	cp ../sqlite3-android/libs/armeabi-v7a/sqlite3-static	system/bin/sqlite3.arm
	cp ../sqlite3-android/libs/x86_64/sqlite3-static	system/bin/sqlite3.x64
	cp ../sqlite3-android/libs/x86/sqlite3-static		system/bin/sqlite3.x86
