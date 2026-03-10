import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class RegisterPayment {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final PaymentDataSource _source = GetIt.I<PaymentDataSource>();

  Future<void> call({
    required String communityId,
    required String residentId,
    required int amountInCents,
    required DateTime date,
    required String? reference,
    required String? note,
    required String receiptPath,
  }) async {
    const String featureArea = 'RegisterPayment';

    try {
      _logger.info('[$featureArea] Starting payment registration for user: $residentId in community: $communityId');

      final signedInUser = GetSignedInUser().call();
      final signedInMember = GetMemberByUserAndCommunityId().call(communityId: communityId, userId: signedInUser.id);
      

      final bool isSelf = signedInUser.id == residentId;
      final bool isAdmin = signedInMember.isAdmin == true;

      if (!isSelf && !isAdmin) {
        final String roleStatus = isAdmin ? 'Admin' : 'Resident';
        final String error =
            'Authorization Denied: User ${signedInUser.id} ($roleStatus) attempted to register a payment for $residentId but is not the owner or an Admin.';

        // Log the specific failure with the user's role context
        _logger.debug('[$featureArea] $error');

        // Send to Supabase via logException for security monitoring
        await _logger.logException(
          featureArea: featureArea,
          exception: 'Unauthorized Payment Attempt',
          metadata: {
            'actor_id': signedInUser.id,
            'target_id': residentId,
            'is_admin': isAdmin,
            'is_self': isSelf,
            'community_id': communityId,
          },
        );

        throw Exception('No tienes permisos para registrar pagos de otros usuarios.');
      }

      await _source.registerPayment(
        communityId: communityId,
        userId: residentId,
        amountInCents: amountInCents,
        date: date,
        reference: reference,
        note: note,
        receiptPath: receiptPath,
      );

      _logger.info('[$featureArea] Payment successfully registered. Amount: $amountInCents cents');
    } catch (e, stackTrace) {
      await _logger.logException(
        featureArea: featureArea,
        exception: e,
        stackTrace: stackTrace,
        metadata: {
          'community_id': communityId,
          'target_user_id': residentId,
          'amount': amountInCents,
          'has_receipt': receiptPath.isNotEmpty,
        },
      );

      rethrow;
    }
  }
}
