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
      final user = GetSignedInUser().call();

      if (user.id != userId && member.isAdmin == false) {
        final error = 'User ${user.id} not allowed to create payment for $userId.';
        _logger.debug('[$featureArea] Authorization failed: $error');
        throw Exception(error);
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
