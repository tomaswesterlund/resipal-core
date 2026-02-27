import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetApplicationById {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();
  final GetCommunityRef _getCommunityRef = GetCommunityRef();
  final GetUserRef _getUserRef = GetUserRef();

  ApplicationEntity call(String id) {
    final model = _source.getById(id);

    if (model == null) {
      throw Exception('Application $id not found in cache. Ensure the stream is active.');
    }

    final user = model.userId == null ? null : _getUserRef.fromId(model.userId!);

    return ApplicationEntity(
      id: model.id,
      createdAt: model.createdAt,
      createdBy: model.createdBy,
      community: _getCommunityRef.fromId(model.communityId),
      user: user,
      email: model.email,
      phoneNumber: model.phoneNumber,
      status: ApplicationStatus.fromString(model.status),
      message: model.message,
    );
  }
}
