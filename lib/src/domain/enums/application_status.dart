enum ApplicationStatus {
  pendingApproval('pending_approval'),
  approved('approved'),
  rejected('rejected');

  final String value;
  const ApplicationStatus(this.value);

  factory ApplicationStatus.fromString(String status) {
    return ApplicationStatus.values.firstWhere(
      (e) => e.value == status,
      orElse: () => ApplicationStatus.pendingApproval,
    );
  }
}
