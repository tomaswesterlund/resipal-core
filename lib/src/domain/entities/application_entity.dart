import 'package:resipal_core/src/domain/enums/community_application_status.dart';
import 'package:resipal_core/src/domain/refs/community_ref.dart';
import 'package:resipal_core/src/domain/refs/user_ref.dart';

class ApplicationEntity {
  final String id;
  final DateTime createdAt;
  final String createdBy;
  final CommunityRef community;
  final UserRef? user;
  final ApplicationStatus status;
  final String name;
  final String email;
  final String phoneNumber;
  final String? message;

  ApplicationEntity({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.community,
    required this.user,
    required this.status,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.message,
  });
}
