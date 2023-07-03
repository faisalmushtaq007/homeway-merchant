import 'package:homemakers_merchant/bootup/bootstrap.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:homemakers_merchant/bootup/bootstrap.dart';

RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
Future<void> main() async {
  RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  await bootstrap(
    () {},
  );
}
