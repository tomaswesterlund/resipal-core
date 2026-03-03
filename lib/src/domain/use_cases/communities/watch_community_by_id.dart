import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:rxdart/streams.dart';

class WatchCommunityById {
  final CommunityDataSource _communitySource = GetIt.I<CommunityDataSource>();
  final PaymentDataSource _paymentDataSource = GetIt.I<PaymentDataSource>();
  final PropertyDataSource _propertyDataSource = GetIt.I<PropertyDataSource>();
  final UserDataSource _userDataSource = GetIt.I<UserDataSource>();

  final GetCommunityById _getCommunityById = GetCommunityById();

  Stream<CommunityEntity> call({required String communityId}) {
    return CombineLatestStream.combine3(
      _communitySource.watchById(communityId),
      _paymentDataSource.watchByCommunityId(communityId),
      _propertyDataSource.watchByCommunityId(communityId),

      (community, payments, properties) {
        final community = _getCommunityById.call(communityId);
        return community;
      },
    ).distinct();
  }
}
