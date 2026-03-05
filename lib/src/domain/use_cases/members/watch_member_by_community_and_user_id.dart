import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class WatchMemberByCommunityAndUserId {
  final CommunityDataSource _communityDataSource = GetIt.I<CommunityDataSource>();
  final PaymentDataSource _paymentDataSource = GetIt.I<PaymentDataSource>();
  final PropertyDataSource _propertyDataSource = GetIt.I<PropertyDataSource>();
  final UserDataSource _userDataSource = GetIt.I<UserDataSource>();
  
  // TODO: Watch community, payments and properties (fees also?)

  Stream<MemberEntity> call({required String communityId, required String userId}) {
    return _userDataSource.watchById(userId).map((user) {
        final member = GetMemberByUserAndCommunityId().call(communityId: communityId, userId: userId);
        return member;
    });
  }
}
