
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:homemakers_merchant/bootup/bootstrap.dart';
import 'package:homeway_firebase/firebase_options_dev.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

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
      WidgetsFlutterBinding.ensureInitialized();
      const kWebRecaptchaSiteKey = '6LfvnlwpAAAAAIy6kpOxkVOAQUQAxfBysW8tkGDo';
      //await Firebase.initializeApp();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      if(!kDebugMode){
        await FirebaseAppCheck.instance.activate(
          androidProvider: AndroidProvider.playIntegrity,
          appleProvider: AppleProvider.appAttest,
          webProvider: ReCaptchaV3Provider(kWebRecaptchaSiteKey),
        );
        final appCheck = FirebaseAppCheck.instance;
        await appCheck.activate(
          webProvider: ReCaptchaV3Provider(kWebRecaptchaSiteKey),
        );
      }else{
        /*await FirebaseAppCheck.instance.activate(
          androidProvider: AndroidProvider.debug,
          appleProvider: AppleProvider.debug,
          webProvider: ReCaptchaV3Provider(kWebRecaptchaSiteKey),
        );
        final appCheck = FirebaseAppCheck.instance;
        await appCheck.activate(
          webProvider: ReCaptchaV3Provider(kWebRecaptchaSiteKey),
        );*/
      }

      //await appCheck.getToken(true);
      return;
    },
  );
}
