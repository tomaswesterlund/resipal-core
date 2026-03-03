import 'package:resipal_core/lib.dart';

class MemberEntity {
  final String name;
  final UserRef user;
  final List<PropertyEntity> properties;

  MemberEntity({required this.name, required this.user, required this.properties});
}
