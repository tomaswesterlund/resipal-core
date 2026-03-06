import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/use_cases/applications/create_application.dart';

class CreateApplicationAndSendInvitations {
  Future call(CreateApplicationDto dto) async {
    // TODO: Do some validation of the DTO
    await CreateApplication().call(dto);
    await SendInvitationEmail().call(
      email: dto.email,
      name: dto.name,
      message: dto.message,
      communityId: dto.communityId,
    );
    // Send WhatsApp
  }
}
