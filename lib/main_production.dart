import 'package:firebase_core/firebase_core.dart';
import 'package:homemakers_merchant/bootstrap.dart';

import 'package:homemakers_merchant/firebase_options_prod.dart';

Future<void> main() async {
  await bootstrap(
    () async {
      return Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    },
  );
}
