import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/data/sources/payment_data_source.dart';
import 'package:resipal_core/src/domain/use_cases/users/get_signed_in_user.dart';

class RegisterPayment {
  final PaymentDataSource _source = GetIt.I<PaymentDataSource>();

  Future call({
    required String communityId,
    required String userId,
    required int amountInCents,
    required DateTime date,
    required String? reference,
    required String? note,
    required String receiptPath,
  }) async {
    final member = GetMemberByUserAndCommunityId().call(communityId: communityId, userId: userId);
    final user = GetSignedInUser().call();

    if(user.id != userId && member.isAdmin == false) {
      throw Exception('User not allowed to create payment.');
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
  }
}
