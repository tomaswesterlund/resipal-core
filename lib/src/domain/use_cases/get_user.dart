import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart'; // Ensure ApplicationStatus is exported here
import 'package:resipal_core/src/data/sources/user_data_source.dart';
import 'package:resipal_core/src/domain/entities/payment/payment_ledger_entity.dart';
import 'package:resipal_core/src/domain/entities/property_registry.dart';
import 'package:resipal_core/src/domain/entities/user_entity.dart';
import 'package:resipal_core/src/domain/use_cases/payments/get_payments.dart';
import 'package:resipal_core/src/domain/use_cases/get_user_invitations.dart';
import 'package:resipal_core/src/domain/use_cases/get_user_properties.dart';

class GetUser {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  UserEntity call(String id) {
    final user = _source.getById(id);

    if (user == null) {
      throw Exception('User $id not found in cache. Ensure the stream is active.');
    }

    final payments = GetPayments().byUserId(user.id);
    final properties = GetUserProperties().call(id);

    return UserEntity(
      // Identity & Metadata
      id: user.id,
      authId: user.authId,
      communityId: user.communityId,
      createdAt: user.createdAt,
      createdBy: user.createdBy,

      // Personal Info
      name: user.name,
      phoneNumber: user.phoneNumber,
      emergencyPhoneNumber: user.emergencyPhoneNumber,
      email: user.email,

      // Application Status & Messaging
      applicationStatus: ApplicationStatus.fromString(user.applicationStatus),
      applicationMessage: user.applicationMessage,

      // Role Flags
      isAdmin: user.isAdmin,
      isResident: user.isResident,
      isSecurity: user.isSecurity,

      // Related Data Entities
      invitations: GetUserInvitations().call(id),
      paymentLedger: PaymentLedgerEntity(payments),
      propertyRegistery: PropertyRegistry(properties),
    );
  }
}
