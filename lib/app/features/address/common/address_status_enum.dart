part of 'package:homemakers_merchant/app/features/address/index.dart';

enum AddressStatus {
  none,
  saveAddress,
  deleteAddress,
  getAddress,
  navigateToAllSavedAddressPage,
  navigateToAddressFormPage,
  navigateToLocationPickerPage,
  exceptionForAddress,
  failedForAddress,
  loadingForAddress,
  processingForAddress,
  emptyForAddress,
  deleteAllAddress,
  getAllAddress,
  selectDefaultAddress,
  selectCurrentAddress,
  confirmationOnDefaultAddress,
  ;

  @override
  String toString() {
    return name;
  }
}
