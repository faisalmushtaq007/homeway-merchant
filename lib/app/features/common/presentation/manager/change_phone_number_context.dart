part of 'package:homemakers_merchant/app/features/common/index.dart';

class ChangePhoneNumberContext<T extends Object> {
  ChangePhoneNumberContext(this.changePhoneNumberImplement);

  late IChangePhoneNumber<T> changePhoneNumberImplement;

  void init({required String phoneNumber, required String dialCode, required String countryCode}) {
    changePhoneNumberImplement.init(phoneNumber, dialCode, countryCode);
  }

  Future<void> updatePhoneNumber(T bloc) async {
    await changePhoneNumberImplement.updatePhoneNumber(bloc);
    return;
  }
}
