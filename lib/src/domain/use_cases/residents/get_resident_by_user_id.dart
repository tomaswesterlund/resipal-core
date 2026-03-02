import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/use_cases/payments/get_payment_by_user_id.dart';
import 'package:resipal_core/src/domain/use_cases/properties/get_properties_by_resident_id.dart';

class GetResidentByUserId {
  ResidentEntity call(String userId) {
    final user = GetUserRef().fromId(userId);
    final properties = GetPropertiesByResidentId().call(userId);
    final payments = GetPaymentByUserId().call(userId);
    final ledger = PaymentLedgerEntity(payments);
    final registry = PropertyRegistry(properties);

    return ResidentEntity(id: user.id, user: user, paymentLedger: ledger, propertyRegistery: registry);
  }
}
