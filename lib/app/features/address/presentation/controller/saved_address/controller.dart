import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_makers_customer_cli/app/core/commons/common_variables.dart';
import 'package:home_makers_customer_cli/app/core/exception/network_exception.dart';
import 'package:home_makers_customer_cli/app/core/theme/app_colors.dart';
import 'package:home_makers_customer_cli/app/data/user_model.dart';
import 'package:home_makers_customer_cli/app/modules/address/data/common/string_constants.dart';
import 'package:home_makers_customer_cli/app/modules/address/data/data_sources/remote/address_remote_datasource.dart';
import 'package:home_makers_customer_cli/app/modules/address/data/models/adddress_model.dart';
import 'package:home_makers_customer_cli/app/modules/address/data/repositories/address_repository_impl.dart';
import 'package:home_makers_customer_cli/app/modules/address/domain/repositories/address_repository.dart';
import 'package:home_makers_customer_cli/app/modules/address/presentation/controller/saved_address/service.dart';
import 'package:home_makers_customer_cli/app/routes/app_pages.dart';

class SavedAddressController extends GetxController {
  SavedAddressController();

  static final DialogService dialogService = Get.find();
  Rx<List<AddressModel>> savedAddressList = Rx<List<AddressModel>>([]);

  List<AddressModel> get savedAddress => savedAddressList.value;
  late final AddressRepository addressRepository;
  late User user;
  bool? bannerPositionRight = true;
  double? bannersize = 50;
  Color? bannerColor = kMainColor;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    final User? userMap = CommonVariables.userData.read(USER);
    if (userMap != null) {
      user = userMap;
      String collectionPath = AddressConstants.addressCollection +
          "/customers/" +
          user.id.toString();
      addressRepository =
          AddressRepositoryImplement(AddressRemoteDataSource(collectionPath));
      savedAddressList.bindStream(addressRepository.getAllRealTimeAddress());
      refresh();
    }
  }

  void addNewAddress() {
    Get.toNamed(Routes.ADDRESS_LIST);
    return;
  }

  void editAddress(AddressModel addressModel) {
    Get.toNamed(Routes.ADDRESS_LIST, arguments: addressModel);
  }

  void removeAddress(AddressModel addressModel, {String? description}) {
    dialogService.showWarning(
      title: 'Remove address?',
      description: description ?? 'Do you want to remove this address',
      popupHeight: 180,
      //themeColor: kMainColor,
      onConfirmButtonPressed: () async {
        if (addressModel.isDefault != null && addressModel.isDefault == true) {
          log.i('removeAddress - Address is default');
          Get.back(closeOverlays: true);
          return;
        } else {
          try {
            return addressRepository
                .deleteAddress(
                    userID: addressModel.userId!,
                    placeId: addressModel.address?.placeId ?? -1,
                    addressRefId: addressModel.addressRefId!)
                .then((value) {
              log.i('removeAddress - Address removed successfully');
              Get.back(closeOverlays: true);
            }, onError: (error) {
              log.e('removeAddress - failed reason - ${error.toString()}');
              Get.back(closeOverlays: true);
            });
          } catch (e) {
            log.e('removeAddress - failed catch exception- ${e.toString()}');
            Get.back(closeOverlays: true);
          }
          return;
        }
      },
    );
    return;
  }

  void setDefaultAddress(
    AddressModel addressModel,
  ) {
    return dialogService.showInfo(
      title: 'Change default address?',
      description:
          'Do you want to use this address as your default delivery address',
      popupHeight: 180,
      themeColor: kMainColor,
      onConfirmButtonPressed: () async {
        updateIsDefaultAddress(addressModel,
            addressRefId: addressModel.addressRefId, closeDialogBox: true);
      },
    );
  }

  Future<void> updateIsDefaultAddress(AddressModel addressModel,
      {String? addressRefId, bool closeDialogBox = false}) async {
    String collectionPath =
        AddressConstants.addressCollection + "/customers/" + user.id.toString();
    var collection = FirebaseFirestore.instance.collection(collectionPath);
    collection.where("isDefault", isEqualTo: true).get().then((value) {
      value.docs.asMap().forEach((key, value) {
        //Set isDefault false to all address
        value.reference.update({'isDefault': false}).then((value) {
          log.i('isDefault false to all');
        }, onError: (e) {
          log.e(
              ('updateIsDefaultAddress - Error during update the default address reference- ${e.toString()}'));
        });
      });
    }).then((value) async {
      // Update only specific passed address model
      var doc = await collection.doc(addressModel.addressRefId).get();
      if (doc.exists) {
        collection.doc(addressModel.addressRefId).update({
          'isDefault': true,
          'updatedAt': Timestamp.now().millisecondsSinceEpoch,
        }).then((value) {
          log.i(
              'updateIsDefaultAddress document exists and update isDefault for - ${addressModel.addressRefId}');
        }, onError: (e) {
          log.e(
              ('updateIsDefaultAddress - Error during update the default address of specified address- ${e.toString()}'));
        });
      }
      // Close the dialog box
      if (closeDialogBox) {
        Get.back(closeOverlays: true);
      }
      return;
    }, onError: (e) {
      log.e(
          ('updateIsDefaultAddress - Error during update the default address false to all- ${e.toString()}'));
      // Close the dialog box
      if (closeDialogBox) {
        Get.back(closeOverlays: true);
      }
      return;
    });
  }
// @override
// void onClose() {
//   super.onClose();
// }

  void onCardPressed(AddressModel addressModel) {
    Get.back<AddressModel>(result: addressModel);
  }
}
