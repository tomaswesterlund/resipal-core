import 'package:resipal_core/lib.dart';

class CommunityEntity {
  final String id;
  final String name;
  final String location;
  final String? description;
  final PaymentLedgerEntity paymentLedger;
  final PropertyRegistry propertyRegistry;
  final MemberDirectoryEntity memberDirectory;

  CommunityEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.paymentLedger,
    required this.propertyRegistry,
    required this.memberDirectory,
  });
}
