import 'package:firebase_core/firebase_core.dart';
import 'package:homemakers_merchant/bootstrap.dart';

import 'firebase_options_dev.dart';

Future<void> main() async {
  await bootstrap(
    () async {
      return Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    },
  );
}
