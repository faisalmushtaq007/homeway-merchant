
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:homemakers_merchant/bootup/bootstrap.dart';

import 'package:homemakers_merchant/firebase_options_dev.dart';

RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
Future<void> main() async {
  final rootIsolateToken = RootIsolateToken.instance!;
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  await bootstrap(
    () async {
      return Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    },
  );
}
