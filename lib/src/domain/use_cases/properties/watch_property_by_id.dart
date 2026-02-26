import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/property_data_source.dart';
import 'package:resipal_core/src/domain/entities/property_entity.dart';
import 'package:resipal_core/src/domain/use_cases/properties/get_property_by_id.dart';

class WatchPropertyById {
  final PropertyDataSource _source = GetIt.I<PropertyDataSource>();
  final GetPropertyById _getProperty = GetPropertyById();

  Stream<PropertyEntity> call(String id) {
    return _source.watchById(id).map((model) {
      final entity = _getProperty.call(model.id);
      return entity;
    });
  }
}
