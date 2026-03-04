import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/data/models/application/create_application_dto.dart';
import 'package:uuid/uuid.dart';

class CreateApplication {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();

  Future call(CreateApplicationDto dto) async {
    // TODO: Do some validation of the DTO
    await _source.createApplication(dto);
  }
}
