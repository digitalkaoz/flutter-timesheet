import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/src/google_fonts_base.dart'
    show loadFontIfNecessary;
import 'package:google_fonts/src/google_fonts_descriptor.dart';
import 'package:google_fonts/src/google_fonts_family_with_variant.dart';
import 'package:google_fonts/src/google_fonts_variant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet_flutter/screens/loading.dart';
import 'package:timesheet_flutter/services/container.dart';
import 'package:timesheet_flutter/widgets/platform/app.dart';

void _setTargetPlatformForDesktop() {
  // No need to handle macOS, as it has now been added to TargetPlatform.
  if (Platform.isLinux || Platform.isWindows) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() async {
  _setTargetPlatformForDesktop();
  WidgetsFlutterBinding.ensureInitialized();

  await _preloadFonts();
  runApp(TimesheetApp());
}

Future<void> _preloadFonts() {
  return loadFontIfNecessary(
    GoogleFontsDescriptor(
      file: GoogleFontsFile(
        '03452c0b90c71f4088222325620904576503c4d5a3a6c563ee22d1e896788d3e',
        143508,
      ),
      familyWithVariant: GoogleFontsFamilyWithVariant(
        family: 'Pacifico',
        googleFontsVariant: GoogleFontsVariant(
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
        ),
      ),
    ),
  );
}

class TimesheetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snap) {
        if (ConnectionState.done != snap.connectionState) {
          return LoadingPage();
        }

        return MultiProvider(
          providers: createProviders(snap.data),
          child: PlatformApp(),
        );
      },
    );
  }
}
