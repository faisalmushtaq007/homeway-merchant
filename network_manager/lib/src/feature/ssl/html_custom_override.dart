import 'package:network_manager/src/feature/ssl/http_custom_override.dart';

HttpCustomOverride createAdapter() => _GeneralCustomOverride();

class _GeneralCustomOverride extends HttpCustomOverride {
  @override
  void make() {}
}
