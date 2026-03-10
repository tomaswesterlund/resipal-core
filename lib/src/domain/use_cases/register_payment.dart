import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class RegisterPayment {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final PaymentDataSource _source = GetIt.I<PaymentDataSource>();

  Future<void> call({
    required String communityId,
    required String userId,
    required int amountInCents,
    required DateTime date,
    required String? reference,
    required String? note,
    required String receiptPath,
  }) async {
    const String featureArea = 'RegisterPayment';

    try {
      _logger.info('[$featureArea] Starting payment registration for user: $userId in community: $communityId');

      final member = GetMemberByUserAndCommunityId().call(communityId: communityId, userId: userId);
      final signedInUser = GetSignedInUser().call();

      final bool isSelf = signedInUser.id == userId;
      final bool isAdmin = member.isAdmin == true;

      if (!isSelf && !isAdmin) {
        final String roleStatus = isAdmin ? 'Admin' : 'Resident';
        final String error =
            'Authorization Denied: User ${signedInUser.id} ($roleStatus) attempted to register a payment for $userId but is not the owner or an Admin.';

        // Log the specific failure with the user's role context
        _logger.debug('[$featureArea] $error');

        // Send to Supabase via logException for security monitoring
        await _logger.logException(
          featureArea: featureArea,
          exception: 'Unauthorized Payment Attempt',
          metadata: {
            'actor_id': signedInUser.id,
            'target_id': userId,
            'is_admin': isAdmin,
            'is_self': isSelf,
            'community_id': communityId,
          },
        );

        throw Exception('No tienes permisos para registrar pagos de otros usuarios.');
      }

      await _source.registerPayment(
        communityId: communityId,
        userId: userId,
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
          'target_user_id': userId,
          'amount': amountInCents,
          'has_receipt': receiptPath.isNotEmpty,
        },
      );

      rethrow;
    }
  }
}
