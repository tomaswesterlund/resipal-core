import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class UserIsAdminInAnyCommunity {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  bool call(String authId) {
    final user = _source.getById(authId);
    if (user == null) return false;
    return user.isAdmin;
  }
}
