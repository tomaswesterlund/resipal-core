import 'package:resipal_core/src/domain/entities/resident_entity.dart';
import 'package:resipal_core/src/domain/use_cases/memberships/get_memberships_by_community.dart';

class GetResidentsByCommunity {
  List<ResidentEntity> call(String communityId) {
    final memberships = GetMembershipsByCommunity().call(communityId);
    final residents = memberships.map((x) => x.resident).toList();
    return residents;
  }
}
