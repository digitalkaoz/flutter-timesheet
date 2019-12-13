test-coverage:
	flutter test --coverage
	genhtml -o coverage/html coverage/lcov.info
	open coverage/html/index.html

codegen-watch:
	flutter packages pub run build_runner watch --delete-conflicting-outputs

bundle:
	flutter build appbundle
	bundletool build-apks --bundle=build/app/outputs/bundle/release/app-release.aab --output=build/kita_parent.apks

to_device:
	bundletool install-apks --apks=build/kita_parent.apks --device-id=FA69T0301176