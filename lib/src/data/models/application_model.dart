class ApplicationModel {
  final String id;
  final DateTime createdAt;
  final String createdBy;
  final String communityId;
  final String? userId;
  final String status;
  final String name;
  final String email;
  final String phoneNumber;
  final String? message;

  ApplicationModel({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.communityId,
    required this.userId,
    required this.status,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.message,
  });

  factory ApplicationModel.fromMap(Map<String, dynamic> map) {
    return ApplicationModel(
      id: map['id'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      createdBy: map['created_by'] as String,
      communityId: map['community_id'] as String,
      userId: map['user_id'] != null ? map['message'] as String : null,
      status: map['status'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phoneNumber: map['phone_number'] as String,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }
}
