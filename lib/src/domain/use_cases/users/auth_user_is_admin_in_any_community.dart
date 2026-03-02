import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class AuthUserIsAdminInAnyCommunity {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  bool call(String authId) {
    final users = _source.getByAuthId(authId).toList();
    return users.any((x) => x.isAdmin);
  }
}