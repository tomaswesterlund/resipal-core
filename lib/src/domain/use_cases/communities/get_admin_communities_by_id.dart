import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetAdminCommunityById {
  final UserDataSource _source = GetIt.I<UserDataSource>();
  final GetCommunityById _getCommunityById = GetCommunityById();

  CommunityEntity call(String id) {
    final user = _source.getById(id);
    if(user == null) throw Exception('User not found');
    if(user.isAdmin == false) throw Exception('User is not admin');
    if(user.communityId == null) throw Exception('User has no attached community.');

    final community = _getCommunityById.call(user.communityId!);
    return community;
  }
}
