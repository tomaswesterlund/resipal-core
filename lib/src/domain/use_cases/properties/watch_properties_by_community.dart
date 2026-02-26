import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/property_data_source.dart';
import 'package:resipal_core/src/domain/entities/property_entity.dart';
import 'package:resipal_core/src/domain/use_cases/properties/get_property_by_id.dart';

class WatchPropertiesByCommunity {
  final PropertyDataSource _source = GetIt.I<PropertyDataSource>();
  final GetPropertyById _getProperty = GetPropertyById();

  Stream<List<PropertyEntity>> call(String communityId) {
    return _source.watchByCommunityId(communityId).map((models) {
      final entities = models.map((x) => _getProperty(x.id)).toList();
      return entities;
    });
  }
}
