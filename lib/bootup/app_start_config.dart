import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:homemakers_merchant/app/features/address/index.dart';
import 'package:homemakers_merchant/app/features/order/index.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/translate_api.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/src/object.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'dart:async';
import 'dart:ui';

import 'package:homemakers_merchant/utils/universal_platform/src/universal_platform.dart';

class AppStartConfig {
  AppStartConfig._privateConstructor();

  static var shared = AppStartConfig._privateConstructor();

  Future<void> startApp() async {
    if (UniversalPlatform.isAndroid) {
      await FlutterDisplayMode.setHighRefreshRate();
    }
    await setupGetIt();
    return;
  }

  /// Indicates to the rest of the app that bootstrap has not completed.
  /// The router will use this to prevent redirects while bootstrapping.
  bool isBootstrapComplete = false;

  /// Indicates which orientations the app will allow be default. Affects Android/iOS devices only.
  /// Default s to both landscape (hz) and portrait (vt)
  List<Axis> supportedOrientations = [Axis.vertical, Axis.horizontal];

  /// Allow a view to override the currently supported orientations. For example, [FullscreenVideoViewer] always wants to enable both landscape and portrait.
  /// If a view sets this override, they are responsible for setting it back to null when finished.
  List<Axis>? _supportedOrientationsOverride;

  set supportedOrientationsOverride(List<Axis>? value) {
    if (_supportedOrientationsOverride != value) {
      _supportedOrientationsOverride = value;
      _updateSystemOrientation();
    }
  }

  /*Future<T?> showFullscreenDialogRoute<T>(BuildContext context, Widget child, {bool transparent = false}) async {
    return await Navigator.of(context).push<T>(
      PageRoutes.dialog<T>(child, duration: $styles.times.pageTransition),
    );
  }*/

  /// Enable landscape, portrait or both. Views can call this method to override the default settings.
  /// For example, the [FullscreenVideoViewer] always wants to enable both landscape and portrait.
  /// If a view overrides this, it is responsible for setting it back to [supportedOrientations] when disposed.
  void _updateSystemOrientation() {
    final axisList = _supportedOrientationsOverride ?? supportedOrientations;
    //debugPrint('updateDeviceOrientation, supportedAxis: $axisList');
    final orientations = <DeviceOrientation>[];
    if (axisList.contains(Axis.vertical)) {
      orientations.addAll([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    if (axisList.contains(Axis.horizontal)) {
      orientations.addAll([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    SystemChrome.setPreferredOrientations(orientations);
  }

  Future<void> saveAllTempOrderData() async {
    //final deleteAll=await serviceLocator<DeleteAllOrderUseCase>()();
    final getAllOrderResult = await serviceLocator<GetAllOrderUseCase>()((0, 10,null,OrderType.all,null,null,null,null));
    await getAllOrderResult.when(remote: (data, meta) {

    }, localDb: (data, meta) async {
      if(data.isNotNull && data!.isNotEmpty){
        appLog.d('Get all orders length $data!.length');
      }else{
        final data = <OrderEntity>[
          OrderEntity(
            orderID: 1,
            orderDateTime: DateTime.now().subtract(const Duration(minutes: 15)),
            orderDeliveryDateTime: DateTime.now().add(const Duration(minutes: 15)),
            userInfo: UserInfo(
              userName: 'Sonu',
              deliveryAddress: DeliveryAddress(),
            ),
            store: Store(
              storeID: 1,
              storeName: 'Life Cafe',
              location: AddressLocation(),
              menu: [
                Menu(
                  quantity: 1,
                  menuID: 21,
                  menuName: 'Chicken Biryani',
                  menuImage:
                  'https://img.freepik.com/premium-photo/fish-biriyani-south-indian-style-fish-biriyani-arranged-traditionally-brass-vessel_527904-1690.jpg',
                  addons: [],
                  tasteType: 'Spicy',
                  tasteLevel: 'Medium',
                  numberOfServingPerson: 2,
                  unit: '1',
                  orderPortion: const OrderPortion(
                    portionSize: 1,
                    portionUnit: 'Bowl',
                  ),
                  isInstantMenu: true,
                ),
              ],
            ),
            orderStatus: OrderStatus.newOrder.index,
            orderType: OrderType.newOrder.index,
            driver: DeliveryDriver(),
            payment: Payment(
              mode: 'COD',
              amount: 30,
              paymentID: 222,
              paymentDateTime: DateTime.now().subtract(const Duration(minutes: 15)),
              deliveryAmount: 2,
              serviceAmount: 2,
            ),
          ),
          OrderEntity(
            orderID: 2,
            orderDateTime: DateTime.now().subtract(const Duration(minutes: 5)),
            orderDeliveryDateTime: DateTime.now().add(const Duration(minutes: 15)),
            userInfo: UserInfo(
              userName: 'Mr Ahmed',
              deliveryAddress: DeliveryAddress(),
            ),
            store: Store(
              storeID: 2,
              storeName: 'Good Cafe',
              location: AddressLocation(),
              menu: [
                Menu(
                  quantity: 2,
                  menuID: 13,
                  menuName: 'Vegetable Rice Briyani',
                  menuImage:
                  'https://img.freepik.com/premium-photo/dum-handi-chicken-biryani-is-prepared-earthen-clay-pot-called-haandi-popular-indian-non-vegetarian-food_466689-52225.jpg',
                  addons: [
                    Addon(
                      addonsName: 'Sweets',
                      orderPortion: const OrderPortion(
                        portionSize: 1,
                        portionUnit: 'Medium',
                      ),
                      addonsId: 4,
                      price: 2,
                      addonsImage:
                      'https://img.freepik.com/premium-photo/gulab-jamun-indian-dessert-topped-with-pistachio_136354-1769.jpg',
                    ),
                  ],
                  tasteType: 'Pungent',
                  tasteLevel: 'Medium',
                  numberOfServingPerson: 2,
                  unit: '1',
                  orderPortion: const OrderPortion(
                    portionSize: 1,
                    portionUnit: 'Bowl',
                  ),
                ),
              ],
            ),
            orderStatus: OrderStatus.preparing.index,
            orderType: OrderType.onProcess.index,
            driver: DeliveryDriver(),
            payment: Payment(
              mode: 'COD',
              amount: 10,
              paymentID: 101,
              paymentDateTime: DateTime.now().subtract(const Duration(minutes: 5)),
              deliveryAmount: 2,
              serviceAmount: 2,
            ),
          ),
          OrderEntity(
            orderID: 3,
            orderDateTime: DateTime.now()
                .subtract(const Duration(days: 1, hours: 12, minutes: 30)),
            orderDeliveryDateTime: DateTime.now()
                .subtract(const Duration(days: 1, hours: 12, minutes: 45)),
            userInfo: UserInfo(
              userName: 'Nilu',
              deliveryAddress: DeliveryAddress(),
            ),
            store: Store(
              storeID: 3,
              storeName: 'Indian Cafe',
              location: AddressLocation(),
              menu: [
                Menu(
                  quantity: 1,
                  menuID: 2,
                  menuName: 'Paneer Butter Masala',
                  menuImage:
                  'https://img.freepik.com/premium-photo/traditional-indian-butter-chicken-murg-makhanwala-which-is-creamy-main-course-curry-recipe_466689-49661.jpg',
                ),
                Menu(
                  quantity: 1,
                  menuID: 16,
                  price: 10,
                  menuName: 'Veg Briyani',
                  menuImage:
                  'https://img.freepik.com/premium-photo/indian-vegetable-pulav-biryani-made-using-basmati-rice-served-terracotta-bowl-selective-focus_466689-55615.jpg',
                  addons: [
                    Addon(
                      addonsName: 'Salad',
                      orderPortion: const OrderPortion(
                        portionSize: 1,
                        portionUnit: 'Plate',
                      ),
                      addonsId: 12,
                      price: 2,
                      addonsImage:
                      'https://img.freepik.com/free-photo/fresh-vegetables-colorful-sliced-such-as-cucumbers-red-tomatoes-onion-wooden-rustic-surface_140725-14178.jpg',
                    ),
                    Addon(
                      addonsName: 'Sweets',
                      orderPortion: const OrderPortion(
                        portionSize: 1,
                        portionUnit: 'Medium',
                      ),
                      addonsId: 4,
                      price: 2,
                      addonsImage:
                      'https://img.freepik.com/premium-photo/gulab-jamun-indian-dessert-topped-with-pistachio_136354-1769.jpg',
                    ),
                  ],
                  tasteType: 'Pungent',
                  tasteLevel: 'Medium',
                  numberOfServingPerson: 2,
                  unit: '1',
                  orderPortion: const OrderPortion(
                    portionSize: 1,
                    portionUnit: 'Bowl',
                  ),
                ),
              ],
            ),
            orderStatus: OrderStatus.delivered.index,
            orderType: OrderType.deliver.index,
            driver: DeliveryDriver(),
            payment: Payment(
              mode: 'PAID',
              amount: 22,
              paymentID: 11,
              paymentDateTime: DateTime.now()
                  .subtract(const Duration(days: 1, hours: 12, minutes: 30)),
              deliveryAmount: 2,
              serviceAmount: 2,
            ),
          ),
          OrderEntity(
            orderID: 4,
            orderDateTime: DateTime.now().subtract(const Duration(minutes: 30)),
            orderDeliveryDateTime:
            DateTime.now().subtract(const Duration(minutes: 45)),
            userInfo: UserInfo(
              userName: 'Shivam',
              deliveryAddress: DeliveryAddress(),
            ),
            store: Store(
              storeID: 4,
              storeName: 'American Food Plaza',
              location: AddressLocation(),
              menu: [
                Menu(
                  quantity: 1,
                  menuID: 25,
                  menuName: 'Burger',
                  menuImage:
                  'https://img.freepik.com/free-photo/front-view-yummy-meat-cheeseburger-with-french-fries-dark-background-dinner-burgers-snack-fast-food-sandwich-salad-dish-toast_140725-159215.jpg?',
                  addons: [
                    Addon(
                      addonsName: 'Salad',
                      orderPortion: const OrderPortion(
                        portionSize: 1,
                        portionUnit: 'Plate',
                      ),
                      addonsId: 12,
                      price: 2,
                      addonsImage:
                      'https://img.freepik.com/free-photo/fresh-vegetables-colorful-sliced-such-as-cucumbers-red-tomatoes-onion-wooden-rustic-surface_140725-14178.jpg',
                    ),
                    Addon(
                      addonsName: 'Sweets',
                      orderPortion: const OrderPortion(
                        portionSize: 1,
                        portionUnit: 'Medium',
                      ),
                      addonsId: 4,
                      price: 2,
                      addonsImage:
                      'https://img.freepik.com/premium-photo/gulab-jamun-indian-dessert-topped-with-pistachio_136354-1769.jpg',
                    ),
                  ],
                  tasteType: 'Pungent',
                  tasteLevel: 'Medium',
                  numberOfServingPerson: 2,
                  unit: '1',
                  orderPortion: const OrderPortion(
                    portionSize: 1,
                    portionUnit: 'Bowl',
                  ),
                ),
              ],
            ),
            orderStatus: OrderStatus.cancelByUser.index,
            orderType: OrderType.cancel.index,
            driver: DeliveryDriver(),
            payment: Payment(
              mode: 'CANCEL',
              amount: 10,
              paymentID: 61,
              paymentDateTime: DateTime.now().subtract(const Duration(minutes: 30)),
              deliveryAmount: 2,
              serviceAmount: 2,
            ),
          ),
          OrderEntity(
            orderID: 8,
            orderDateTime: DateTime.now().subtract(const Duration(hours: 1)),
            orderDeliveryDateTime:
            DateTime.now().subtract(const Duration(hours: 1, minutes: 15)),
            userInfo: UserInfo(
              userName: 'Ashutosh',
              deliveryAddress: DeliveryAddress(),
            ),
            store: Store(
              storeID: 4,
              storeName: 'American Food Plaza',
              location: AddressLocation(),
              menu: [
                Menu(
                  quantity: 1,
                  menuID: 21,
                  menuName: 'Cheese Pizza',
                  menuImage:
                  'https://img.freepik.com/free-photo/crispy-mixed-pizza-with-olives-sausage_140725-3095.jpg',
                  addons: [
                    Addon(
                      addonsName: 'Salad',
                      orderPortion: const OrderPortion(
                        portionSize: 1,
                        portionUnit: 'Plate',
                      ),
                      addonsId: 12,
                      price: 2,
                      addonsImage:
                      'https://img.freepik.com/free-photo/fresh-vegetables-colorful-sliced-such-as-cucumbers-red-tomatoes-onion-wooden-rustic-surface_140725-14178.jpg',
                    ),
                    Addon(
                      addonsName: 'Sweets',
                      orderPortion: const OrderPortion(
                        portionSize: 1,
                        portionUnit: 'Medium',
                      ),
                      addonsId: 4,
                      price: 2,
                      addonsImage:
                      'https://img.freepik.com/premium-photo/gulab-jamun-indian-dessert-topped-with-pistachio_136354-1769.jpg',
                    ),
                  ],
                  tasteType: 'Pungent',
                  tasteLevel: 'Medium',
                  numberOfServingPerson: 2,
                  unit: '1',
                  orderPortion: const OrderPortion(
                    portionSize: 1,
                    portionUnit: 'Bowl',
                  ),
                ),
              ],
            ),
            orderStatus: OrderStatus.onTheWay.index,
            orderType: OrderType.deliver.index,
            driver: DeliveryDriver(
              driverID: 1,
              driverName: 'Mr. Abdul Wahab',
              driverContactNumber: '+966 559781276',
              driverAddress: AddressBean(
                latitude: 23.86,
                longitude: 45.27,
                displayAddressName:
                '12 King Fahd Rd, Al Islamiah, Jeddah, Jeddah,57513,Saudi Arabia',
              ),
            ),
            payment: Payment(
              mode: 'PAID',
              amount: 15,
              paymentID: 897,
              paymentDateTime: DateTime.now().subtract(const Duration(hours: 1)),
              deliveryAmount: 2,
              serviceAmount: 2,
            ),
          ),
          OrderEntity(
            orderID: 9,
            orderDateTime: DateTime.now().subtract(const Duration(hours: 2)),
            orderDeliveryDateTime:
            DateTime.now().subtract(const Duration(hours: 2, minutes: 30)),
            userInfo: UserInfo(
              userName: 'Ashutosh',
              deliveryAddress: DeliveryAddress(),
            ),
            store: Store(
              storeID: 4,
              storeName: 'American Food Plaza',
              location: AddressLocation(),
              menu: [
                Menu(
                  quantity: 1,
                  menuID: 21,
                  menuName: 'Cheese Pizza',
                  menuImage:
                  'https://img.freepik.com/free-photo/crispy-mixed-pizza-with-olives-sausage_140725-3095.jpg',
                  addons: [
                    Addon(
                      addonsName: 'Salad',
                      orderPortion: const OrderPortion(
                        portionSize: 1,
                        portionUnit: 'Plate',
                      ),
                      addonsId: 12,
                      price: 2,
                      addonsImage:
                      'https://img.freepik.com/free-photo/fresh-vegetables-colorful-sliced-such-as-cucumbers-red-tomatoes-onion-wooden-rustic-surface_140725-14178.jpg',
                    ),
                    Addon(
                      addonsName: 'Sweets',
                      orderPortion: const OrderPortion(
                        portionSize: 1,
                        portionUnit: 'Medium',
                      ),
                      addonsId: 4,
                      price: 2,
                      addonsImage:
                      'https://img.freepik.com/premium-photo/gulab-jamun-indian-dessert-topped-with-pistachio_136354-1769.jpg',
                    ),
                  ],
                  tasteType: 'Pungent',
                  tasteLevel: 'Medium',
                  numberOfServingPerson: 2,
                  unit: '1',
                  orderPortion: const OrderPortion(
                    portionSize: 1,
                    portionUnit: 'Bowl',
                  ),
                ),
              ],
            ),
            orderStatus: OrderStatus.readyToPickup.index,
            orderType: OrderType.onProcess.index,
            driver: DeliveryDriver(
              driverID: 1,
              driverName: 'Mr. Sakib Ahmed',
              driverContactNumber: '+966 556789456',
              driverAddress: AddressBean(
                latitude: 23.56,
                longitude: 45.67,
                displayAddressName:
                '11 Sayed Al Shouhada, Al Masani, Al Munawwarah,Buraydah,42313,Saudi Arabia',
              ),
            ),
            payment: Payment(
              mode: 'COD',
              amount: 23.0,
              paymentID: 347,
              paymentDateTime: DateTime.now().subtract(const Duration(hours: 2)),
              deliveryAmount: 2,
              serviceAmount: 2,
            ),
          ),
        ];
        final result = await serviceLocator<SaveAllOrderUseCase>()(data.toList());
        await Future.delayed(const Duration(milliseconds: 500),(){});
        result.when(
          remote: (data, meta) {
            appLog.d('Saved all orders to remote ${data?.length}');
          },
          localDb: (data, meta) {
            appLog.d('Saved all orders to local ${data?.length}');
          },
          error: (dataSourceFailure, reason, error, networkException, stackTrace,
              exception, extra) {
            appLog.d('Saved all orders to error $reason');
          },
        );
      }
    }, error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
      appLog.d('Get all orders to error $reason');
    },);

  }

}

class AppImageCache extends WidgetsFlutterBinding {
  @override
  ImageCache createImageCache() {
    this.imageCache.maximumSizeBytes = 250 << 20; // 250mb
    return super.createImageCache();
  }
}


