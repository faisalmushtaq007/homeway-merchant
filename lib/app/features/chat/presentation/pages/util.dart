part of 'package:homemakers_merchant/app/features/chat/index.dart';

const colors = [
  Color(0xffff6767),
  Color(0xff66e0da),
  Color(0xfff5a2d9),
  Color(0xfff0c722),
  Color(0xff6a85e5),
  Color(0xfffd9a6f),
  Color(0xff92db6e),
  Color(0xff73b8e5),
  Color(0xfffd7590),
  Color(0xffc78ae5),
];

Color getUserAvatarNameColor(ChatUser user) {
  final index = user.id.hashCode % colors.length;
  return colors[index];
}

String getUserName(ChatUser user) =>
    '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();
