import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/use_cases/payments/get_payment_by_user_id.dart'; // Ensure ApplicationStatus is exported here

class GetUser {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  UserEntity call(String id) {
    final user = _source.getById(id);

    if (user == null) {
      throw Exception('User $id not found in cache. Ensure the stream is active.');
    }

    final payments = GetPaymentByUserId().call(user.id);
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
