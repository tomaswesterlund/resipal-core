import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/membership_data_source.dart';
import 'package:resipal_core/src/domain/entities/membership_entity.dart';
import 'package:resipal_core/src/domain/use_cases/memberships/get_membership_by_id.dart';

class WatchMembershipsByCommunity {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();
  final GetMembershipById _getMembership = GetMembershipById();

  Stream<List<MembershipEntity>> call(String communityId) {
    return _source.watchByCommunityId(communityId).map((models) {
      final entities = models.map((x) => _getMembership(x.id)).toList();
      return entities;
    });
  }
}
