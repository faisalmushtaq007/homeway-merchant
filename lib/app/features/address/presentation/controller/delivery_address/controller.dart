import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder_buddy/geocoder_buddy.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_makers_customer_cli/app/core/commons/base/presentation/phonenumber_form_field_index.dart';
import 'package:home_makers_customer_cli/app/core/commons/common_variables.dart';
import 'package:home_makers_customer_cli/app/core/commons/states/api_result_state.dart';
import 'package:home_makers_customer_cli/app/core/utils/validator/generic_validator/generic_validator.dart';
import 'package:home_makers_customer_cli/app/data/user_model.dart';
import 'package:home_makers_customer_cli/app/modules/address/data/common/string_constants.dart';
import 'package:home_makers_customer_cli/app/modules/address/data/data_sources/remote/address_remote_datasource.dart';
import 'package:home_makers_customer_cli/app/modules/address/data/models/adddress_model.dart';
import 'package:home_makers_customer_cli/app/modules/address/data/repositories/address_repository_impl.dart';
import 'package:home_makers_customer_cli/app/modules/address/domain/repositories/address_repository.dart';
import 'package:home_makers_customer_cli/app/modules/address/domain/validator/city_name_validator.dart';
import 'package:home_makers_customer_cli/app/modules/address/domain/validator/name_validator.dart';
import 'package:home_makers_customer_cli/app/modules/address/domain/validator/phone_number_validator.dart';
import 'package:home_makers_customer_cli/app/modules/address/domain/validator/platform_phone_validator.dart';
import 'package:home_makers_customer_cli/app/modules/address/presentation/controller/saved_address/controller.dart';
import 'package:home_makers_customer_cli/app/routes/app_pages.dart';
import 'package:logger/logger.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../../../../core/commons/base/presentation/presentation.dart';

enum ActionOfSaveAddressButton {
  create,
  update,
}

class DeliveryAddressController extends GetxController {
  DeliveryAddressController();
  // Dependency and getx controllers
  static final LogServiceImpl logService = Get.find();
  final SavedAddressController savedAddressController =
      Get.put(SavedAddressController());
  final PhoneNumberController phoneNumberController =
      Get.put(PhoneNumberController());
  // Log service
  Logger log = logService.logger;
  // Form
  final formKey = GlobalKey<FormState>();
  // Controllers
  final firstAddressTextFieldController = TextEditingController();
  final secondAddressTextFieldController = TextEditingController();
  final landmarkTextFieldController = TextEditingController();
  final buildingTextFieldController = TextEditingController();
  final areaTextFieldController = TextEditingController();
  final cityTextFieldController = TextEditingController();
  final stateTextFieldController = TextEditingController();
  final countryTextFieldController = TextEditingController();
  final zipCodeTextFieldController = TextEditingController();
  final fullNameTextFieldController = TextEditingController();
  final mobileNumberTextFieldController = TextEditingController();
  final mapAddressTextFieldController = TextEditingController();
  final districtAddressTextFieldController = TextEditingController();

  //ValueChanged<bool?>? checkBoxOnChanged;
  bool checkBoxValue = false;
  List<bool> isToggleButtonSelected = [false, false, false, false, false];
  List<String> valueOfToggleButtonSelected = [
    'Home',
    'Office',
    'Friend',
    'Business',
    'Other'
  ];
  late final GBData locationAddressData;
  late final NameValidator nameValidator;
  late final CityNameValidator cityNameValidator;
  //late final PhoneValidator phoneValidator;
  String? phoneValidation;
  String? addressTypeValidation;
  late User user;
  int indexOfSaveAddress = -1;
  String? valueOfSavedAddress;
  late double sharedLatitude;
  late double sharedLongitude;
  AddressModel? sharedAddressModel;
  Rx<ActionOfSaveAddressButton> actionOfSaveAddressButton =
      Rx<ActionOfSaveAddressButton>(ActionOfSaveAddressButton.create);
  final isoCodeNameMap = IsoCode.values.asNameMap();

  //Function(int index)? onToggleButtonPressed;
  void onTap() {}

  @override
  void onInit() {
    super.onInit();
    nameValidator = NameValidator();
    cityNameValidator = CityNameValidator();
    final platformPhoneValidator = PlatformPhoneValidatorImpl();
    //phoneValidator = PhoneValidator(phoneValidator: platformPhoneValidator);
    final User? userMap = CommonVariables.userData.read(USER);
    if (userMap != null) {
      user = userMap;
      fullNameTextFieldController.text = user.name ?? '';
    }
    if (Get.arguments != null) {
      final argsData = Get.arguments as Map<String, dynamic>;
      locationAddressData = argsData['locationData'] as GBData;
      sharedLatitude = argsData['latitude'] as double;
      sharedLongitude = argsData['longitude'] as double;
      sharedAddressModel = argsData['addressModel'] as AddressModel?;
      if (sharedAddressModel != null &&
          sharedAddressModel?.fullName != null &&
          sharedAddressModel!.address != null) {
        areaTextFieldController.text = sharedAddressModel!.address?.area ?? '';
        mapAddressTextFieldController.text =
            sharedAddressModel!.address?.displayAddressName ?? '';
        districtAddressTextFieldController.text =
            sharedAddressModel!.address?.district ?? '';
        zipCodeTextFieldController.text =
            sharedAddressModel!.address?.postalCode.toString() ?? '';
        cityTextFieldController.text = sharedAddressModel!.address?.city ?? '';
        stateTextFieldController.text =
            sharedAddressModel!.address?.state ?? '';
        countryTextFieldController.text =
            sharedAddressModel!.address?.country ?? '';
        fullNameTextFieldController.text = sharedAddressModel!.fullName ?? '';
        if (sharedAddressModel!.phoneNumber != null) {
          mobileNumberTextFieldController.text =
              sharedAddressModel!.phoneNumber.toString();
        }
        buildingTextFieldController.text =
            sharedAddressModel!.address?.apartment ?? '';
        landmarkTextFieldController.text =
            sharedAddressModel!.address?.landmark ?? '';
        checkBoxValue = sharedAddressModel!.address?.isDefault ?? false;
        //isToggleButtonSelected
        if (sharedAddressModel!.address?.indexOfSavedAddressAs != null) {
          int? index = sharedAddressModel!.address?.indexOfSavedAddressAs!;
          isToggleButtonSelected[index!] = true;
          indexOfSaveAddress = index;
          valueOfSavedAddress = valueOfToggleButtonSelected[index];
        }
        // Phone number information
        mobileNumberTextFieldController.clear();
        mobileNumberTextFieldController.text =
            sharedAddressModel!.phoneNumber ?? '';
        phoneNumberController.initialValue = PhoneNumber(
          isoCode:
              isoCodeNameMap.values.byName(sharedAddressModel!.isoCode ?? 'SA'),
          nsn: sharedAddressModel!.phoneNumber ?? '',
        );
        phoneNumberController.controller.value = PhoneNumber(
          isoCode:
              isoCodeNameMap.values.byName(sharedAddressModel!.isoCode ?? 'SA'),
          nsn: sharedAddressModel!.phoneNumber ?? '',
        );
        phoneNumberController.defaultCountry =
            isoCodeNameMap.values.byName(sharedAddressModel!.isoCode ?? 'SA');
        phoneValidation =
            phoneNumberController.phoneKey.currentState?.errorText;

        /// Update ActionOfSaveAddressButton state
        actionOfSaveAddressButton.value = ActionOfSaveAddressButton.update;
      }
      if (locationAddressData.address != null) {
        if (areaTextFieldController.text.isEmpty) {
          areaTextFieldController.text = locationAddressData.address?.village ??
              locationAddressData.address?.city ??
              locationAddressData.address?.county ??
              '';
        }
        if (mapAddressTextFieldController.text.isEmpty) {
          mapAddressTextFieldController.text =
              locationAddressData.displayName ?? '';
        }
        if (districtAddressTextFieldController.text.isEmpty) {
          districtAddressTextFieldController.text =
              locationAddressData.address?.cityDistrict ??
                  locationAddressData.address?.stateDistrict ??
                  '';
        }
        if (zipCodeTextFieldController.text.isEmpty) {
          zipCodeTextFieldController.text =
              locationAddressData.address?.postcode ?? '';
        }
        if (cityTextFieldController.text.isEmpty) {
          cityTextFieldController.text = locationAddressData.address?.city ??
              locationAddressData.address?.town ??
              locationAddressData.address?.suburb ??
              locationAddressData.address?.municipality ??
              locationAddressData.address?.cityDistrict ??
              locationAddressData.address?.stateDistrict ??
              '';
        }
        if (stateTextFieldController.text.isEmpty) {
          stateTextFieldController.text =
              locationAddressData.address?.state ?? '';
        }
        if (countryTextFieldController.text.isEmpty) {
          countryTextFieldController.text =
              locationAddressData.address?.country ?? '';
        }
      }
      update();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
  void checkBoxOnChanged(bool? onChange) {
    checkBoxValue = onChange!;
    update();
  }

  void onToggleButtonPressed(int index) {
    for (int i = 0; i < isToggleButtonSelected.length; i++) {
      isToggleButtonSelected[i] = i == index;
      update();
    }
    indexOfSaveAddress = index;
    valueOfSavedAddress = valueOfToggleButtonSelected[index];
    log.i(isToggleButtonSelected[index]);
    update();
  }

  String? fullnameValidation(String? v) {
    String? message = nameValidator.validate(v!).maybeMap(
          invalid: (invalid) => invalid.reasons.first,
          orElse: () => null,
        );
    update();
    return message;
  }

  String? cityNameValidation(String? v) {
    String? message = cityNameValidator.validate(v!).maybeMap(
          invalid: (invalid) => invalid.reasons.first,
          orElse: () => null,
        );
    update();
    return message;
  }

  String? validateAddressType(bool? v) {
    debugPrint('isToggleButtonSelected any init ${v}');
    final addressType = ValidationRule(
        ruler: (value) {
          final bool result =
              isToggleButtonSelected.any((element) => element == true);
          debugPrint('isToggleButtonSelected any ${result}');
          return result;
        },
        rejectionFeedback: "Select any one address type");
    final validResult = addressType.apply(v);
    return validResult.maybeMap(
      invalid: (feedback) {
        addressTypeValidation = feedback.reasons.first;
        debugPrint(
            'isToggleButtonSelected any invalid ${addressTypeValidation!}');
        update();
        return addressTypeValidation;
      },
      orElse: () {
        addressTypeValidation = null;
        debugPrint('isToggleButtonSelected any null');
        update();
        return addressTypeValidation;
      },
    );
  }

  bool validate() {
    return formKey.currentState!.validate() &&
        (phoneNumberController.phoneKey.currentState!.validate());
  }

  void resetForm() {
    formKey.currentState!.reset();
    return;
  }

  void saveForm() {
    formKey.currentState!.save();
    return;
  }

  Future<void> onSaveAddressValidate() async {
    //await validatePhone(mobileNumberTextFieldController.value.text.trim());
    log.i(phoneNumberController.formKey.currentState?.validate());
    log.i(phoneNumberController.controller.value);
    log.i(phoneNumberController.controller.value?.getFormattedNsn().trim());
    var textParse = PhoneNumber.parse(
      phoneNumberController.controller.value?.getFormattedNsn().trim() ?? '',
      destinationCountry:
          phoneNumberController.controller.value?.isoCode ?? IsoCode.AR,
    );
    log.i(textParse.toJson().toString());
    if (validate()) {
      log.i(phoneNumberController.controller.value);
      Get.focusScope!.unfocus();
      saveForm();
    }
  }

  Future<void> onSaveAddress() async {
    //await validatePhone(mobileNumberTextFieldController.value.text.trim());
    if (validate()) {
      Get.focusScope!.unfocus();
      saveForm();
      String collectionPath = AddressConstants.addressCollection +
          "/customers/" +
          user.id.toString();
      AddressRepository addressRepository =
          AddressRepositoryImplement(AddressRemoteDataSource(collectionPath));
      AddressModel newAddressModel = AddressModel(
        userId: user.id,
        fullName: fullNameTextFieldController.value.text.trim(),
        phoneNumber:
            phoneNumberController.controller.value?.getFormattedNsn().trim(),
        countryDialCode: phoneNumberController.controller.value?.countryCode,
        isoCode: phoneNumberController.controller.value?.isoCode.name,
        createdAt: Timestamp.now().millisecondsSinceEpoch,
        updatedAt: Timestamp.now().millisecondsSinceEpoch,
        isDefault: checkBoxValue,
        address: AddressBean(
          city: cityTextFieldController.value.text.trim(),
          state: stateTextFieldController.value.text.trim(),
          country: countryTextFieldController.value.text.trim(),
          savedAddressAs: valueOfSavedAddress,
          indexOfSavedAddressAs: indexOfSaveAddress,
          addressType: locationAddressData.addresstype,
          apartment: buildingTextFieldController.value.text,
          area: areaTextFieldController.value.text,
          category: locationAddressData.category,
          cityCode: -1,
          cityDistrict: locationAddressData.address?.cityDistrict,
          countryCode: -1,
          county: locationAddressData.address?.county,
          district: districtAddressTextFieldController.value.text.trim(),
          //isDefault: checkBoxValue,
          landmark: landmarkTextFieldController.value.text.trim(),
          latitude: sharedLatitude,
          longitude: sharedLongitude,
          municipality: locationAddressData.address?.municipality,
          osmId: locationAddressData.id,
          osmType: locationAddressData.osmType,
          pickupAddress: locationAddressData.displayName,
          placeId: locationAddressData.placeId,
          placeRank: locationAddressData.placeRank,
          postalCode: int.parse(zipCodeTextFieldController.value.text.trim()),
          road: locationAddressData.address?.road,
          stateCode: -1,
          stateDistrict: locationAddressData.address?.stateDistrict,
          suburb: locationAddressData.address?.suburb,
          town: locationAddressData.address?.town,
          type: locationAddressData.type,
          village: locationAddressData.address?.village,
          displayAddressName: mapAddressTextFieldController.value.text.trim(),
        ),
      );
      final ApiResultState<AddressModel> resultState;
      if (actionOfSaveAddressButton == ActionOfSaveAddressButton.create) {
        resultState = await addressRepository.addAddress(newAddressModel);
      } else {
        final updatedAddressModel = newAddressModel.copyWith(
            addressRefId: sharedAddressModel!.addressRefId);
        resultState = await addressRepository.updateAddress(
            updatedAddressModel, user.id!, updatedAddressModel.addressRefId!);
      }
      resultState.when(
        success: (data) async {
          if (actionOfSaveAddressButton == ActionOfSaveAddressButton.create) {
            log.i('Record inserted');
          } else {
            log.i('Record updated');
          }
          if (data.isDefault != null && data.isDefault == true) {
            savedAddressController
                .updateIsDefaultAddress(data,
                    addressRefId: data.addressRefId, closeDialogBox: false)
                .then((value) {
              log.i('onSaveAddress - current address is default true');
              Get.close(2);
            }, onError: (e) {
              log.e(
                  ('onSaveAddress - Error during update the default address of new address- ${e.toString()}'));
            });
          } else {
            log.i('onSaveAddress - current address is default false');
            Get.close(2);
          }
          //Get.toNamed(Routes.SAVED_ADDRESS);
          return;
        },
        failure: (reason, error, exception, stackTrace) {
          log.e('Either create or update record operation failed - ${reason}');
        },
      );
      update();
      return;
    }
  }

  @override
  void dispose() {
    firstAddressTextFieldController.dispose();
    secondAddressTextFieldController.dispose();
    landmarkTextFieldController.dispose();
    buildingTextFieldController.dispose();
    areaTextFieldController.dispose();
    cityTextFieldController.dispose();
    stateTextFieldController.dispose();
    countryTextFieldController.dispose();
    zipCodeTextFieldController.dispose();
    fullNameTextFieldController.dispose();
    mobileNumberTextFieldController.dispose();
    mapAddressTextFieldController.dispose();
    districtAddressTextFieldController.dispose();
    super.dispose();
  }
}
