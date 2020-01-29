test-coverage:
	flutter test --coverage
	genhtml -o coverage/html coverage/lcov.info
	open coverage/html/index.html

codegen-watch:
	flutter packages pub run build_runner watch --delete-conflicting-outputs

bundle:
	rm -f build/timesheet.apks
	flutter build appbundle
	bundletool build-apks --bundle=build/app/outputs/bundle/release/app-release.aab --output=build/timesheet.apks

install:
	flutter pub get

icons:
	flutter pub run flutter_launcher_icons:main

to_device:
	bundletool install-apks --apks=build/timesheet.apks --device-id=FA69T0301176
