import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:rxdart/streams.dart';

class WatchCommunityById {
  final ApplicationDataSource _applicationDataSource = GetIt.I<ApplicationDataSource>();
  final CommunityDataSource _communitySource = GetIt.I<CommunityDataSource>();
  final MembershipDataSource _membershipDataSource = GetIt.I<MembershipDataSource>();
  final PaymentDataSource _paymentDataSource = GetIt.I<PaymentDataSource>();
  final PropertyDataSource _propertyDataSource = GetIt.I<PropertyDataSource>();
  final UserDataSource _userDataSource = GetIt.I<UserDataSource>();

  final GetCommunityById _getCommunityById = GetCommunityById();

  Stream<CommunityEntity> call(String id) {
    return CombineLatestStream.combine6(
      _applicationDataSource.watchByCommunityId(id),
      _communitySource.watchById(id),
      _membershipDataSource.watchByCommunityId(id),
      _paymentDataSource.watchByCommunityId(id),
      _propertyDataSource.watchByCommunityId(id),
      _userDataSource.watchByCommunityId(id),

      (applications, community, memebrships, payments, properties, users) {
        final community = _getCommunityById.call(id);
        return community;
      },
    ).distinct();
  }
}
