# Flutter Timesheet App

[![Timesheets](./assets/icon_android.png)](https://github.com/digitalkaoz/flutter-timesheet)



> a Timesheet Application, because all others suxx ;)

This whole App is totally educational to me. If you value this work (like me) download the App
from the App-Store of your Platform :)

[![Playstore](./assets/playstore.png)](http://play.google.com/store/apps/details?id=<package_name>)
[![Applestore](./assets/applestore.png)](http://play.google.com/store/apps/details?id=<package_name>)

## Highlights

* 🤖 🍎 Cross-Platform (native Android/IOS Components)
* 📲 Adaptive Layouts for different Orientations and Devices
* 🧠 Mobx for State-Management
* 💾 Stored in Local-Storage
* ⬇️ Export/Import Data from other Instances 
* 🖥 Works on Web (t.b.d.)
* 🌓 Dark Mode aware

## Features

* multiple Clients
* PDF Export of Timesheets
* automatic Range/Sum of Timesheets
* editable/deletable Times
* automatic dark mode detection

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
$ make bundle
```

**Sync Production Bundle to a device**

```shell script
$ make to_device
```

## TODOS

* Landscape Mobile
* Portrait/Landscape Tablet
* Portrait/Landscape Web
