import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class UserHasJoinedCommunity {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  bool call(String id) {
    final user = _source.getById(id);
    if(user == null) return false;
    return user.applicationStatus == ApplicationStatus.approved;
  }
}
