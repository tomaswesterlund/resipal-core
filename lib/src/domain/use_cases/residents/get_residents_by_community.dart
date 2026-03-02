import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/use_cases/residents/get_resident_by_user_id.dart';

class GetResidentsByCommunity {
  final UserDataSource _source = GetIt.I<UserDataSource>();
  final GetResidentByUserId _getResidentByUserId = GetResidentByUserId();

  List<ResidentEntity> call(String communityId) {
    final users = _source.getByCommunityId(communityId);
    final residents = users.where((x) => x.isResident);
    final entities = residents.map((x) => _getResidentByUserId(x.id)).toList();

    return entities;
  }
}
