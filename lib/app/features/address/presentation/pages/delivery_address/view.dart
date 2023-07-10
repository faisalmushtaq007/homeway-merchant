import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:home_makers_customer_cli/app/core/commons/base/presentation/phonenumber_form_field_index.dart';
import 'package:home_makers_customer_cli/app/core/commons/base/presentation/styles/textsyle.dart';
import 'package:home_makers_customer_cli/app/core/commons/common_widgets.dart';
import 'package:home_makers_customer_cli/app/core/theme/app_colors.dart';
import 'package:home_makers_customer_cli/app/modules/address/presentation/widgets/address_form_maker_widget.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../delivery_address_index.dart';

class DeliveryAddressPage extends GetView<DeliveryAddressController> {
  DeliveryAddressPage({Key? key}) : super(key: key);
  final PhoneNumberController phoneNumberController =
      Get.put(PhoneNumberController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryAddressController>(
      init: DeliveryAddressController(),
      //id: "delivery_address",
      builder: (deliveryAddressController) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Enter complete address"),
            //backgroundColor: kScaffoldBackroundColor,
          ),
          //backgroundColor: Get.theme.colorScheme.secondary,
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            child: Form(
              key: deliveryAddressController.formKey,
              child: ListView(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  AddressFormMakerWidget(
                    key: const Key('address-user-mobile-number'),
                    title: 'Mobile number',
                    child: PhoneNumberFieldWidget(
                      //key: Key('address-phone-number-widget'),
                      isCountryChipPersistent: false,
                      outlineBorder: true,
                      selectorNavigator:
                          CountrySelectorNavigator.searchDelegate(),
                      shouldFormat: true,
                      useRtl: false,
                      withLabel: true,
                      decoration: commonTextFieldInputDecoration.copyWith(
                        hintText: 'Required',
                        errorText: deliveryAddressController.phoneValidation,
                        helperText:
                            "We'll call this number to coordinate delivery",
                      ),
                    ),
                    /*child: TextFormField(
                      controller: deliveryAddressController
                          .mobileNumberTextFieldController,
                      keyboardType: TextInputType.number,
                      decoration: commonTextFieldInputDecoration.copyWith(
                        hintText: 'Required',
                        errorText: deliveryAddressController.phoneValidation,
                        helperText:
                            "We'll call this number to coordinate delivery",
                      ),
                      validator: (value) {
                        return deliveryAddressController
                            .phoneNumberValidation(value!);
                      },
                    ),*/
                  ),
                  AddressFormMakerWidget(
                    key: const Key('address-user-full-name'),
                    title: 'Full name (First and Last name)',
                    child: TextFormField(
                      controller:
                          deliveryAddressController.fullNameTextFieldController,
                      keyboardType: TextInputType.text,
                      decoration: commonTextFieldInputDecoration.copyWith(
                        hintText: 'Required',
                      ),
                      validator: (value) {
                        debugPrint('Full name value ->${value}');
                        return deliveryAddressController
                            .fullnameValidation(value!);
                      },
                    ),
                  ),
                  AddressFormMakerWidget(
                    key: const Key('address-user-flat-building'),
                    title: 'Flat, House no., Building, Company, Apartment',
                    child: TextFormField(
                      controller:
                          deliveryAddressController.buildingTextFieldController,
                      keyboardType: TextInputType.text,
                      decoration: commonTextFieldInputDecoration.copyWith(
                        hintText: 'Optional',
                      ),
                    ),
                  ),
                  AddressFormMakerWidget(
                    key: const Key('address-user-area-street'),
                    title: 'Area, Street, Sector, Village',
                    child: TextFormField(
                      controller:
                          deliveryAddressController.areaTextFieldController,
                      keyboardType: TextInputType.text,
                      decoration: commonTextFieldInputDecoration.copyWith(
                        hintText: 'Optional',
                      ),
                    ),
                  ),
                  AddressFormMakerWidget(
                    key: const Key('address-user-landmark'),
                    title: 'Landmark',
                    child: TextFormField(
                      controller:
                          deliveryAddressController.landmarkTextFieldController,
                      keyboardType: TextInputType.text,
                      decoration: commonTextFieldInputDecoration.copyWith(
                        hintText: 'Optional',
                      ),
                    ),
                  ),
                  AddressFormMakerWidget(
                    key: const Key('address-user-map-address'),
                    title: 'Selected address',
                    child: TextFormField(
                      controller: deliveryAddressController
                          .mapAddressTextFieldController,
                      keyboardType: TextInputType.text,
                      decoration: commonTextFieldInputDecoration.copyWith(
                        hintText: 'Required',
                        helperText:
                            'Your selected location is being shown here from the map',
                      ),
                    ),
                  ),
                  AddressFormMakerWidget(
                    key: const Key('address-user-district'),
                    title: 'District',
                    child: TextFormField(
                      controller: deliveryAddressController
                          .districtAddressTextFieldController,
                      keyboardType: TextInputType.text,
                      decoration: commonTextFieldInputDecoration.copyWith(
                        hintText: 'Optional',
                      ),
                    ),
                  ),
                  AddressFormMakerWidget(
                    key: const Key('address-user-zipcode'),
                    title: 'Postal code',
                    child: TextFormField(
                      controller:
                          deliveryAddressController.zipCodeTextFieldController,
                      keyboardType: TextInputType.number,
                      decoration: commonTextFieldInputDecoration.copyWith(
                        hintText: 'Optional',
                      ),
                    ),
                  ),
                  AddressFormMakerWidget(
                    key: const Key('address-user-city'),
                    title: 'Town/City',
                    child: TextFormField(
                      controller:
                          deliveryAddressController.cityTextFieldController,
                      keyboardType: TextInputType.text,
                      decoration: commonTextFieldInputDecoration.copyWith(
                        hintText: 'Required',
                      ),
                      validator: (value) {
                        debugPrint('Town/City value ->${value}');
                        return deliveryAddressController
                            .cityNameValidation(value!);
                      },
                    ),
                  ),
                  AddressFormMakerWidget(
                    key: const Key('address-user-state'),
                    title: 'State',
                    child: TextFormField(
                      controller:
                          deliveryAddressController.stateTextFieldController,
                      keyboardType: TextInputType.text,
                      decoration: commonTextFieldInputDecoration.copyWith(
                        hintText: 'Required',
                      ),
                      enabled: false,
                    ),
                  ),
                  AddressFormMakerWidget(
                    key: const Key('address-user-country'),
                    title: 'Country',
                    gap: 1,
                    child: TextFormField(
                      controller:
                          deliveryAddressController.countryTextFieldController,
                      keyboardType: TextInputType.text,
                      decoration: commonTextFieldInputDecoration.copyWith(
                        hintText: 'Required',
                      ),
                      enabled: false,
                    ),
                  ),
                  ListTileTheme(
                    contentPadding: EdgeInsets.zero,
                    minVerticalPadding: 2,
                    horizontalTitleGap: 0,
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text('Make this is my default address'),
                      value: deliveryAddressController.checkBoxValue,
                      onChanged: deliveryAddressController.checkBoxOnChanged,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AddressFormMakerWidget(
                    key: const Key('address-user-address-type'),
                    title: 'Save address as',
                    child: FormField<bool>(
                      initialValue:
                          deliveryAddressController.isToggleButtonSelected[0],
                      validator: (value) {
                        return deliveryAddressController
                            .validateAddressType(value!);
                      },
                      builder: (FormFieldState<bool> field) {
                        return InputDecorator(
                          decoration: commonTextFieldInputDecoration.copyWith(
                            errorText:
                                deliveryAddressController.addressTypeValidation,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                          child: ToggleButtons(
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: kSecondaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                            selectedBorderColor: kMainColor,
                            borderColor: kMainColor.withOpacity(0.7),
                            selectedColor: Colors.white,
                            constraints: const BoxConstraints(minHeight: 44),
                            color: kMainColor,
                            fillColor: kMainColor,
                            isSelected: deliveryAddressController
                                .isToggleButtonSelected,
                            onPressed:
                                deliveryAddressController.onToggleButtonPressed,
                            children: deliveryAddressController
                                .valueOfToggleButtonSelected
                                .map((name) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  name,
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      deliveryAddressController.onSaveAddress();
                      //deliveryAddressController.onSaveAddressValidate();
                      return;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kMainColor,
                      foregroundColor: Colors.white,
                      fixedSize: const Size(64, 46),
                    ),
                    child: Text(
                      'Save Address',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
