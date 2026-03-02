import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class UpdateUserCommunity {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  void call({required String userId, required String communityId}) {
    final user = _source.getById(userId);
    if(user == null) throw Exception('User not found.');

    final updated = user.copyWith(communityId: communityId);
    _source.upsert(updated);
  }
}
