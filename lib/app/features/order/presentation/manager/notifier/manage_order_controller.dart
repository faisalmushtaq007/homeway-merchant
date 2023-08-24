part of 'package:homemakers_merchant/app/features/order/index.dart';

class ManageOrderController with ChangeNotifier {
  ManageOrderController();

  Future<void> loadAll() async {
    _currentOrderIndex = 0;
  }

  late int _currentOrderIndex;

  int get currentOrderIndex => _currentOrderIndex;

  void setCurrentOrderIndex(int? value, [bool notify = true]) {
    if (value == null) return;
    if (value == _currentOrderIndex) return;
    _currentOrderIndex = value;
    if (notify) notifyListeners();
    unawaited(Future(() => value));
  }
}
