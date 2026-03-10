import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class CanPayMaintenanceFee {
  final LoggerService _logger = GetIt.I<LoggerService>();
  static const String _featureArea = 'CanPayMaintenanceFee';

  bool call({required String maintenanceFeeId}) {
    final fee = GetMaintenanceFee().call(maintenanceFeeId);
    final member = GetSignedInMember().call();
    final property = GetPropertyById().call(fee.property.id);

    // 1. Check Balance
    if (member.totalMemberBalanceInCents < fee.amountInCents) {
      _logDecision(
        false,
        'Insufficient balance: ${member.totalMemberBalanceInCents} < ${fee.amountInCents}',
        maintenanceFeeId,
      );
      return false;
    }

    // 2. Check if already paid
    if (fee.status == MaintenanceFeeStatus.paid) {
      _logDecision(false, 'Fee is already paid.', maintenanceFeeId);
      return false;
    }

    // 3. Admin Override
    if (member.isAdmin) {
      _logDecision(true, 'User is Admin.', maintenanceFeeId);
      return true;
    }

    // 4. Resident Validation
    if (property.resident == null) {
      _logDecision(false, 'Property has no resident assigned.', maintenanceFeeId);
      return false;
    }

    if (property.resident!.id == member.user.id) {
      _logDecision(true, 'User is the assigned resident of the property.', maintenanceFeeId);
      return true;
    }

    // Default Fallback
    _logDecision(false, 'User has no legal relation to this property or fee.', maintenanceFeeId);
    return false;
  }

  void _logDecision(bool allowed, String reason, String feeId) {
    _logger.info(
      featureArea: _featureArea,
      message: 'Payment eligibility check: ${allowed ? "ALLOWED" : "DENIED"}',
      metadata: {'fee_id': feeId, 'reason': reason, 'allowed': allowed},
    );
  }
}
