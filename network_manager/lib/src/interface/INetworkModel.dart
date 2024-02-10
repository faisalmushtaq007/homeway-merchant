abstract class INetworkModel<T> {
  const INetworkModel();
  Map<String, dynamic>? toJson();
  T fromJson(Map<String, dynamic> json);
}
