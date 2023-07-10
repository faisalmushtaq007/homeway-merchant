import 'package:get/get.dart';
import 'package:home_makers_customer_cli/app/core/utils/log_service.dart';
import 'package:home_makers_customer_cli/app/modules/address/presentation/address_list_index.dart';
import 'package:home_makers_customer_cli/app/modules/address/presentation/delivery_address_index.dart';
import 'controller.dart';

class SavedAddressBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SavedAddressController>(() => SavedAddressController());
    Get.put(LogServiceImpl());
  }
}
