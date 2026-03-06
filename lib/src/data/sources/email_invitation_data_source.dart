import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/data/models/email_invitation_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EmailInvitationDataSource {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  final Map<String, EmailInvitationModel> _cache = {};

  Stream<EmailInvitationModel> watchById(String id) {
    return _client.from('email_invitations').stream(primaryKey: ['id']).eq('id', id).map((data) {
      if (data.isEmpty) throw Exception('Invitation not found');
      final model = EmailInvitationModel.fromMap(data.first);
      _cache[model.id] = model;
      return model;
    });
  }

  Stream<List<EmailInvitationModel>> watchByCommunityId(String communityId) {
    return _client
        .from('email_invitations')
        .stream(primaryKey: ['id'])
        .eq('community_id', communityId)
        .map(
          (data) => data.map((item) {
            final model = EmailInvitationModel.fromMap(item);
            _cache[model.id] = model;
            return model;
          }).toList(),
        );
  }

  EmailInvitationModel? getById(String id) => _cache[id];

  Future fetchAndCacheByCommunityId(String communityId) async {
    final items = await _client.from('email_invitations').select().eq('community_id', communityId);
    for (var item in items) {
      final model = EmailInvitationModel.fromMap(item);
      _cache[model.id] = model;
    }
  }
}
