import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class SendInvitationEmail {
  final EmailInvitationDataSource _invitationDataSource = GetIt.I<EmailInvitationDataSource>();
  final EmailLogDataSource _logDataSource = GetIt.I<EmailLogDataSource>();

  Future<void> call({
    required String email,
    required String name,
    required String message,
    required String communityId,
  }) async {
    try {
      final model = EmailInvitationModel(
        id: '',
        communityId: communityId,
        createdAt: DateTime.now(),
        createdBy: '',
        email: email,
        name: name,
        message: message,
      );

      await _invitationDataSource.upsert(model.toUpsertMap());

      // 2. Trigger the Edge Function
      // Note: You might want your Edge Function to return the resend_id
      // so you can pass it to the logger.
      await _invitationDataSource.invokeSendInvitationEmail(
        bearerKey: 'sb_publishable_I1FzA8ioJ1zPOhpFjld_vA_p2Pip5pw',
        email: email, name: name, message: message);

      // 3. Log the success (Optional: pass resend_id if returned by function)
      //await _logDataSource.logAttempt(invitationId: invitationId, resendId: 'pending_or_returned_id');
    } catch (e) {
      // Handle or rethrow errors
      rethrow;
    }
  }
}
