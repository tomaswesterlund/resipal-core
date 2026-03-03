import 'package:resipal_core/lib.dart';

class GetMemberByUserAndCommunityId {
  MemberEntity call({required String communityId, required String userId}) {
    final userRef = GetUserRefById().call(userId: userId);
    final properties = GetPropertiesByResidentId().call(residentId: userId);

    return MemberEntity(name: userRef.name, user: userRef, properties: properties);
  }
}
