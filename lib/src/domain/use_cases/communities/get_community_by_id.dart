import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetCommunityById {
  final CommunityDataSource _source = GetIt.I<CommunityDataSource>();

  CommunityEntity call(String communityId) {
    final model = _source.getById(communityId);

    if (model == null) {
      throw Exception('Community $communityId not found in cache. Ensure the stream is active.');
    }

    final applications = GetApplicationsByCommunityId().call(communityId: communityId);
    final members = GetMembersByCommunityId().call(communityId: communityId);
    final payments = GetPayments().byCommunityId(communityId);
    final properties = GetProperties().byCommunityId(communityId);

    return CommunityEntity(
      id: model.id,
      name: model.name,
      location: model.location,
      description: model.description,
      applications: applications,
      paymentLedger: PaymentLedgerEntity(payments),
      propertyRegistry: PropertyRegistry(properties),
      memberDirectory: MemberDirectoryEntity(members),
    );
  }
}
