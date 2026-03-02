import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/community_data_source.dart';
import 'package:resipal_core/src/domain/typedefs.dart';
import 'package:resipal_core/src/domain/use_cases/users/update_user_community.dart';

class CreateCommunity {
  final CommunityDataSource _source = GetIt.I<CommunityDataSource>();

  Future<CommunityId> call({
    required String userId,
    required String name,
    required String? description,
    required String? location,
    required bool isAdmin,
    required bool isSecurity,
    required bool isUser,
  }) async {
    final CommunityId communityId =  await _source.createCommunity(
      userId: userId,
      name: name,
      description: description,
      location: location,
      isAdmin: isAdmin,
      isSecurity: isSecurity,
      isUser: isUser,
    );

    await UpdateUserCommunity().call(userId: userId, communityId: communityId);

    return communityId;
  }
}
