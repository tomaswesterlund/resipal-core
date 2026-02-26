import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/community_data_source.dart';
import 'package:resipal_core/src/data/sources/payment_data_source.dart';
import 'package:resipal_core/src/data/sources/property_data_source.dart';
import 'package:resipal_core/src/domain/entities/community/community_entity.dart';
import 'package:resipal_core/src/domain/use_cases/communities/get_community_by_id.dart';
import 'package:rxdart/streams.dart';

class WatchCommunityById {
  final CommunityDataSource _communitySource = GetIt.I<CommunityDataSource>();
  final PaymentDataSource _paymentDataSource = GetIt.I<PaymentDataSource>();
  final PropertyDataSource _propertyDataSource = GetIt.I<PropertyDataSource>();
  final GetCommunityById _getCommunityById = GetCommunityById();

  Stream<CommunityEntity> call(String id) {
    return CombineLatestStream.combine3(
      _communitySource.watchById(id),
      _paymentDataSource.watchByCommunityId(id),

      _propertyDataSource.watchByCommunityId(id),
      (community, payments, properties) {
        final community = _getCommunityById.call(id);
        return community;
      },
    );
  }
}
