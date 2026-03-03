import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetMembersByCommunityId {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();
  final GetMemberByUserAndCommunityId _getMemberByUserAndCommunityId = GetMemberByUserAndCommunityId();

  List<MemberEntity> call({required String communityId}) {
    final models = _source.getByCommunityId(communityId);
    final entities = models
        .map((x) => _getMemberByUserAndCommunityId(communityId: x.communityId, userId: x.userId))
        .toList();

    return entities;
  }
}
