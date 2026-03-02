import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetAdminCommunitiesByAuthId {
  final UserDataSource _source = GetIt.I<UserDataSource>();
  final GetCommunityById _getCommunityById = GetCommunityById();

  List<CommunityEntity> call(String authId) {
    final allUserMemberships = _source.getByAuthId(authId);
    final adminMemberships = allUserMemberships.where((user) => user.isAdmin).toList();
    final communities = adminMemberships.map((x) => _getCommunityById.call(x.communityId)).toList();
    return communities;
  }
}
