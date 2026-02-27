import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:rxdart/streams.dart';

class WatchMembershipsByCommunity {
  final MembershipDataSource _membershipSource = GetIt.I<MembershipDataSource>();
  final PaymentDataSource _paymentSource = GetIt.I<PaymentDataSource>();
  final PropertyDataSource _propertySource = GetIt.I<PropertyDataSource>();
  final GetMembershipById _getMembership = GetMembershipById();

  Stream<List<MembershipEntity>> call(String communityId) {
    return CombineLatestStream.combine3(
      _membershipSource.watchByCommunityId(communityId),
      _paymentSource.watchByCommunityId(communityId),
      _propertySource.watchByCommunityId(communityId),
      (memberships, payments, properties) {
        final entities = memberships.map((x) => _getMembership(x.id)).toList();
        return entities;
      },
    );
  }
}
