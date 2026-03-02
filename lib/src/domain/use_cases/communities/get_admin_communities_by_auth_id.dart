import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetAdminCommunityByAuthId {
  final UserDataSource _source = GetIt.I<UserDataSource>();
  final GetCommunityById _getCommunityById = GetCommunityById();

  CommunityEntity call(String authId) {
    final user = _source.getByAuthId(authId);
    if(user == null) throw Exception('User not found');
    if(user.isAdmin == false) throw Exception('User is not admin');

    final community = _getCommunityById.call(user.communityId);
    return community;
  }
}
