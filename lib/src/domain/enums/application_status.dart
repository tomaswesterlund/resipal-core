enum ApplicationStatus {
  approved,
  pendingReview,
  rejected,
  revoked;

  static ApplicationStatus fromString(String value) {
    return switch (value) {
      'approved' => ApplicationStatus.approved,
      'pending_review' => ApplicationStatus.pendingReview,
      'rejected' => ApplicationStatus.rejected,
      'revoked' => ApplicationStatus.revoked,
      _ => throw UnimplementedError('Unknown UserCommunityStatus: $value'),
    };
  }

  @override
  String toString() {
    return switch (this) {
      ApplicationStatus.approved => 'approved',
      ApplicationStatus.pendingReview => 'pending_review',
      ApplicationStatus.rejected => 'rejected',
      ApplicationStatus.revoked => 'revoked',
    };
  }
}
