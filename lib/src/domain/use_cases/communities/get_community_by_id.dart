import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/community_data_source.dart';
import 'package:resipal_core/src/domain/entities/user_directory_entity.dart';
import 'package:resipal_core/src/domain/entities/community_entity.dart';
import 'package:resipal_core/src/domain/entities/payment/payment_ledger_entity.dart';
import 'package:resipal_core/src/domain/entities/property_registry.dart';
import 'package:resipal_core/src/domain/use_cases/payments/get_payments.dart';
import 'package:resipal_core/src/domain/use_cases/properties/get_properties.dart';
import 'package:resipal_core/src/domain/use_cases/users/get_users_by_community.dart';

class GetCommunityById {
  final CommunityDataSource _source = GetIt.I<CommunityDataSource>();

  CommunityEntity call(String communityId) {
    final model = _source.getById(communityId);

    if (model == null) {
      throw Exception('Community $communityId not found in cache. Ensure the stream is active.');
    }

    final payments = GetPayments().byCommunityId(communityId);
    final properties = GetProperties().byCommunityId(communityId);
    final users = GetUsersByCommunity().call(communityId);

    return CommunityEntity(
      id: model.id,
      name: model.name,
      location: model.location,
      description: model.description,
      paymentLedger: PaymentLedgerEntity(payments),
      propertyRegistry: PropertyRegistry(properties),
      users: users,
    );
  }
}
