import 'package:get/get.dart';
import 'package:home_makers_customer_cli/app/core/utils/log_service.dart';
import 'package:home_makers_customer_cli/app/modules/address/presentation/delivery_address_index.dart';
import 'package:home_makers_customer_cli/app/modules/address/presentation/saved_address_index.dart';
import 'controller.dart';

class AddressListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressListController>(() => AddressListController());
    Get.put(LogServiceImpl());
  }
}
