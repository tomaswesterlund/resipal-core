import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class UserHasJoinedCommunity {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  bool call(String authId) {
    final user = _source.getByAuthId(authId);
    if(user == null) return false;
    return user.applicationStatus == ApplicationStatus.approved;
  }
}
