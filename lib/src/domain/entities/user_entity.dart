import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

class UserEntity extends Equatable {
  final String id;
  final String authId;
  final String communityId;
  final DateTime createdAt;
  final String createdBy;
  final String name;
  final String phoneNumber;
  final String emergencyPhoneNumber;
  final String email;
  final ApplicationStatus applicationStatus;
  final String applicationMessage;
  final bool isAdmin;
  final bool isResident;
  final bool isSecurity;

  final List<InvitationEntity> invitations;
  final PaymentLedgerEntity paymentLedger;
  final PropertyRegistry propertyRegistery;

  const UserEntity({
    required this.id,
    required this.authId,
    required this.communityId,
    required this.createdAt,
    required this.createdBy,
    required this.name,
    required this.phoneNumber,
    required this.emergencyPhoneNumber,
    required this.email,
    required this.applicationStatus,
    required this.applicationMessage,
    required this.isAdmin,
    required this.isResident,
    required this.isSecurity,
    required this.invitations,
    required this.paymentLedger,
    required this.propertyRegistery,
  });

  List<InvitationEntity> get activeInvitations => invitations.where((e) => e.canEnter).toList();

  @override
  List<Object?> get props => [
    id,
    authId,
    communityId,
    createdAt,
    createdBy,
    name,
    phoneNumber,
    emergencyPhoneNumber,
    email,
    applicationStatus,
    applicationMessage,
    isAdmin,
    isResident,
    isSecurity,
    invitations,
    paymentLedger,
    propertyRegistery,
  ];
}
