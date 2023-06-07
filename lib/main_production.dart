import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:homemakers_merchant/bootup/bootstrap.dart';

import 'package:homemakers_merchant/firebase_options_prod.dart';

RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
Future<void> main() async {
  RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
  await bootstrap(
    () async {
      return Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    },
  );
}
