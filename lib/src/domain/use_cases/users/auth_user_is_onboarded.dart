import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/user_data_source.dart';

class AuthUserIsOnboarded {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  Future<bool> call(String authId) async {
    final user =  _source.getByAuthId(authId);
    return user != null;
  }
}
