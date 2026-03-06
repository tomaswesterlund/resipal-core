import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/data/models/application/create_application_dto.dart';
import 'package:resipal_core/src/domain/use_cases/invitations/send_invitation_email.dart';
import 'package:uuid/uuid.dart';

class CreateApplication {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();

  Future call(CreateApplicationDto dto) async {
    // TODO: Do some validation of the DTO
    await _source.createApplication(dto);
    await SendInvitationEmail().call(email: dto.email, name: dto.name, message: dto.message, communityId: dto.communityId);
    // Send e-mail
    // Send WhatsApp
  }
}
