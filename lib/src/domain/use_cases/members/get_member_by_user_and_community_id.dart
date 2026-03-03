import 'package:resipal_core/src/domain/entities/member_entity.dart';

class GetMemberByUserAndCommunityId {
  MemberEntity call({required String communityId, required String userId}) {
    return MemberEntity(name: 'TEST');
  }
}
