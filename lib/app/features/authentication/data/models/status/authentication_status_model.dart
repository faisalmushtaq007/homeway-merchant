import 'package:json_annotation/json_annotation.dart';
import 'package:network_manager/network_manager.dart';

part 'authentication_status_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  genericArgumentFactories: true,
)
@JsonSerializable()
class AuthenticationStatusModel extends INetworkModel<AuthenticationStatusModel>{
  @JsonKey(name: "status")
  final int status;
  @JsonKey(name: "uid")
  final int uid;

  AuthenticationStatusModel({
    required this.status,
    required this.uid,
  });

  factory AuthenticationStatusModel.fromMap(Map<String, dynamic> json) => _$AuthenticationStatusModelFromJson(json);

  Map<String, dynamic> toMap() => _$AuthenticationStatusModelToJson(this);

  @override
  AuthenticationStatusModel fromJson(Map<String, dynamic> json) {
    return AuthenticationStatusModel.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson() =>toMap();
}
