import 'package:get/get.dart';
import 'package:home_makers_customer_cli/app/core/commons/base/presentation/phonenumber_form_field_index.dart';
import 'package:home_makers_customer_cli/app/core/utils/log_service.dart';
import 'package:home_makers_customer_cli/app/modules/address/presentation/address_list_index.dart';
import 'package:home_makers_customer_cli/app/modules/address/presentation/saved_address_index.dart';
import 'controller.dart';

class DeliveryAddressBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryAddressController>(() => DeliveryAddressController());
    Get.put(LogServiceImpl());
    Get.lazyPut<SavedAddressController>(() => SavedAddressController());
    Get.lazyPut<PhoneNumberController>(() => PhoneNumberController());
  }
}
