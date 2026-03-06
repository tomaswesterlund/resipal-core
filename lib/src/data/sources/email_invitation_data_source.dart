import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/data/models/email_invitation_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EmailInvitationDataSource {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final ResipalSupabase _resipalSupabase = GetIt.I<ResipalSupabase>();

  final Map<String, EmailInvitationModel> _cache = {};

  Stream<EmailInvitationModel> watchById(String id) {
    return _resipalSupabase.client.from('email_invitations').stream(primaryKey: ['id']).eq('id', id).map((data) {
      if (data.isEmpty) throw Exception('Invitation not found');
      final model = EmailInvitationModel.fromMap(data.first);
      _cache[model.id] = model;
      return model;
    });
  }

  Stream<List<EmailInvitationModel>> watchByCommunityId(String communityId) {
    return _resipalSupabase.client
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
    final items = await _resipalSupabase.client.from('email_invitations').select().eq('community_id', communityId);
    for (var item in items) {
      final model = EmailInvitationModel.fromMap(item);
      _cache[model.id] = model;
    }
  }

  Future upsert(Map<String, dynamic> map) async {
    await _resipalSupabase.client.from('email_invitations').upsert(map);
  }

  Future<void> invokeSendInvitationEmail({required String email, required String name, required String message}) async {
    await _resipalSupabase.client.auth.refreshSession();
    final authHeader = Supabase.instance.client.auth.headers['Authorization'] ?? '';

    final String? token = _resipalSupabase.client.auth.currentSession?.accessToken;

    await _resipalSupabase.client.functions.invoke(
      'send_invitation_via_email',
      body: {
        'record': {'email': email, 'name': name, 'message': message},
      },
      headers: {
         'Authorization': authHeader,
        'Content-Type': 'application/json'},
    );
  }
}
