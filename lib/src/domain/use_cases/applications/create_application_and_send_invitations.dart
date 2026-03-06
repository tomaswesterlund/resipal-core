import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class CreateApplicationAndSendInvitations {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();

  Future call(CreateApplicationDto dto) async {
    // TODO: Do some validation of the DTO
    await _source.createApplication(dto);
    await SendInvitationEmail().call(email: dto.email, name: dto.name, message: dto.message, communityId: dto.communityId);
    // Send WhatsApp
  }
}
