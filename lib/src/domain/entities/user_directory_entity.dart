import 'package:resipal_core/lib.dart';

class UserDirectoryEntity {
  final List<UserEntity> users;

  UserDirectoryEntity(this.users);

  bool get isEmpty => users.isEmpty;
  int get length => users.length;

  List<UserEntity> get admins => users.where((m) => m.isAdmin).toList();
  List<UserEntity> get securityStaff => users.where((m) => m.isSecurity).toList();
  List<UserEntity> get residents => users.where((m) => m.isResident).toList();
  
  List<UserEntity> get pendingApplications => users.where((m) => m.applicationStatus == ApplicationStatus.pendingReview).toList();


}
