clean:
	flutter clean

test-coverage:
	flutter test --coverage
	genhtml -o coverage/html coverage/lcov.info
	open coverage/html/index.html


test-ci:
	flutter test --coverage
	genhtml -o coverage/html coverage/lcov.info

codegen:
	flutter packages pub run build_runner build  --delete-conflicting-outputs

codegen-watch:
	flutter packages pub run build_runner watch --delete-conflicting-outputs


build-android-ci:
	flutter build appbundle --debug

build-android:
	rm -f build/timesheet.apks
	flutter build appbundle
	bundletool build-apks --bundle=build/app/outputs/bundle/release/app-release.aab --output=build/timesheet.apks

build-ios:
	flutter build ios

build: clean build-ios build-android

install:
	flutter pub get

icons:
	flutter pub run flutter_launcher_icons:main

to_device:
	bundletool install-apks --apks=build/timesheet.apks --device-id=9A261FFAZ004EC

#TODO some xcode fuckup forces us to have either a development version or a release version, not both
ios-dev:
	mv ios _ios
	flutter create .
	cp _ios/Runner/Info.plist ios/Runner/Info.plist
	make install
	make icons

ios-prod:
	rm -rf ios
	mv _ios ios
