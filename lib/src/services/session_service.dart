class SessionService {
  late String _selectedCommunityId;
  String get communityId => _selectedCommunityId;

  void setSelectedCommunityId(String communityId) => _selectedCommunityId = communityId;
}
