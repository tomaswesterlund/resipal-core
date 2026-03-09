import 'package:resipal_core/src/domain/enums/maintenance_fee_status.dart';
import 'package:resipal_core/src/domain/refs/contract_ref.dart';

class MaintenanceFeeEntity {
  final String id;
  final ContractRef contract;
  final DateTime createdAt;
  final int amountInCents;
  final DateTime dueDate;
  final DateTime? paymentDate;
  final DateTime fromDate;
  final DateTime toDate;
  final String? note;

  MaintenanceFeeEntity({
    required this.id,
    required this.contract,
    required this.createdAt,
    required this.amountInCents,
    required this.dueDate,
    required this.paymentDate,
    required this.fromDate,
    required this.toDate,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'contract': contract.toMap(),
      'createdAt': createdAt.toIso8601String(),
      'amountInCents': amountInCents,
      'dueDate': dueDate.toIso8601String(),
      'paymentDate': paymentDate?.toIso8601String(),
      'fromDate': fromDate.toIso8601String(),
      'toDate': toDate.toIso8601String(),
      'note': note,
      'status': status.name,
      'isPaid': isPaid,
    };
  }

  bool get isPaid => paymentDate != null;

  MaintenanceFeeStatus get status {
    final today = DateTime.now();
    if (isPaid) return MaintenanceFeeStatus.paid;
    if (today.isAfter(dueDate)) return MaintenanceFeeStatus.overdue;
    if (today.isAfter(fromDate) || today.isAtSameMomentAs(fromDate)) {
      return MaintenanceFeeStatus.pending;
    }
    return MaintenanceFeeStatus.upcoming;
  }
}
