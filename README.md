# Flutter Timesheet App

<img src="https://github.com/digitalkaoz/flutter-timesheet/raw/master/assets/app_icon_transparent.png" width="100" height="100">

![Flutter CI](https://github.com/digitalkaoz/flutter-timesheet/workflows/Flutter%20CI/badge.svg)

> a Timesheet Application, because all others suxx ;)

This whole App is totally educational to me. I used it for learning [Dart](https://dart.dev/) and [Flutter](https://flutter.dev/). If you value this work (like me) download the App
from the App-Store of your Platform :)

<a href="https://play.google.com/store/apps/details?id=net.digitalkaoz.timesheet_flutter" target="_blank"><img src="https://github.com/digitalkaoz/flutter-timesheet/raw/master/assets/playstore.png" height="50"></a>
<a href="https://apps.apple.com/us/app/timesheets-by-digitalkaoz/id1498314656" target="_blank"><img src="https://github.com/digitalkaoz/flutter-timesheet/raw/master/assets/applestore.png" height="50"></a>


## Features
* multiple clients
* automatic Range/Sum of Timesheets
* editable/deletable Times
* automatic dark mode detection
* export/print timesheets as PDF
* dynamic billing ranges
* export/import Data from other Instances

## Technical Highlights

* 🤖 🍎 Cross-Platform (native Android/IOS Components)
* 📲 Adaptive Layouts for different Orientations and Devices
* 🧠 Mobx for State-Management
* 💾 Stored in Local-Storage
* 🖥 Works on Web (t.b.d.)
* 🌓 Dark Mode aware
* 🤖 🍎 native Controls


**Android**

| ![Empty](screenshots/android/android_1.png) | ![Timesheet](screenshots/android/android_4.png) | ![New Time](screenshots/android/android_3.png) | ![PDF Export](screenshots/android/android_5.png) |
|------------|-------------|-------------|-------------|

**iOS**

| ![Empty](screenshots/ios/ios_1.png) | ![Timesheets](screenshots/ios/ios_3.png) | ![New Time](screenshots/ios/ios_2.png) | ![Edit Time](screenshots/ios/ios_4.png) | ![Print](screenshots/ios/ios_5.png) |
|------------|-------------|-------------|-------------|-------------|


## Getting Started

we store everything inside a `Makefile`.

**Install flutter dependencies**

```shell script
$ make install
```

**Watch `mobx` part generations when editing Stores**

```shell script
$ make codegen-watch
```

**Run Tests**

```shell script
$ make test
```

**Rebuild Icons**

```shell script
$ make icons
```

**Create Production Bundles**

```shell script
$ make build
```

## TODO

* darkmode ui glitches
* functional tests
* multi-device with firebase ?
