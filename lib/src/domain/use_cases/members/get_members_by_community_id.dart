import 'package:resipal_core/src/domain/entities/member_entity.dart';

class GetMembersByCommunityId {
  List<MemberEntity> call({required String communityId}) {
    return [
      MemberEntity(name: 'TEST'),
      MemberEntity(name: 'TEST2'),
      MemberEntity(name: 'TEST3')
    ];
  }
}