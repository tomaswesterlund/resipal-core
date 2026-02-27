import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class WatchApplicationsByCommunity {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();
  final GetApplicationFromModel _getApplicationFromModel = GetApplicationFromModel();

  Stream<List<ApplicationEntity>> call(String communityId) {
    return _source.watchByCommunityId(communityId).map((models) {
      final entities = models.map((x) => _getApplicationFromModel(x)).toList();
      return entities;
    });
  }
}
