import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserDataSource {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  final Map<String, UserModel> _cache = {};

  Stream<UserModel> watchById(String id) {
    return _client.from('users').stream(primaryKey: ['id']).eq('id', id).map((data) {
      if (data.isEmpty) {
        throw Exception('User not found');
      }
      final model = UserModel.fromMap(data.first);
      _cache[model.id] = model;
      return model;
    });
  }

  Stream<List<UserModel>> watchByCommunityId(String communityId) {
    return _client
        .from('users')
        .stream(primaryKey: ['id'])
        .eq('community_id', communityId)
        .map(
          (data) => data.map((item) {
            final model = UserModel.fromMap(item);
            _cache[model.id] = model;
            return model;
          }).toList(),
        );
  }

  UserModel? getById(String id) => _cache[id];

  List<UserModel> getByCommunityId(String communityId) =>
      _cache.values.where((x) => x.communityId == communityId).toList();

  bool userExistsInCache(String id) => _cache.containsKey(id);

  Future<bool> userExistsInDatabase(String id, {bool cacheExistingUser = true}) async {
    final item = await _client.from('users').select().eq('id', id).maybeSingle();

    // Cache
    if (cacheExistingUser && item != null) {
      final model = UserModel.fromMap(item);
      _cache[model.id] = model;
    }

    return item != null;
  }

  Future fetchAndCacheAll() async {
    final items = await _client.from('users').select();
    for (var item in items) {
      final model = UserModel.fromMap(item);
      _cache[model.id] = model;
    }
  }

  Future fetchAndCacheById(String id) async {
    final item = await _client.from('users').select().eq('id', id).single();
    final model = UserModel.fromMap(item);

    _cache[model.id] = model;
  }

  Future fetchAndCacheByAuthId(String authId) async {
    final items = await _client.from('users').select().eq('auth_id', authId);
    for (var item in items) {
      final model = UserModel.fromMap(item);
      _cache[model.id] = model;
    }
  }

  Future<UserId> createUser({
    required String name,
    required String phoneNumber,
    required String? emergencyPhoneNumber,
    required String email,
    required String applicationStatus,
    required String applicationMessage,
    required bool isAdmin,
    required bool isResident,
    required bool isSecurity,
  }) async {
    final userId = await _client.rpc(
      'fn_create_user',
      params: {
        'p_name': name,
        'p_phone_number': phoneNumber,
        'p_emergency_phone_number': emergencyPhoneNumber,
        'p_email': email,
        'p_application_status': applicationStatus,
        'p_application_message': applicationMessage,
        'p_is_admin': isAdmin,
        'p_is_resident': isResident,
        'p_is_security': isSecurity,
      },
    );

    return userId as String;
  }

  Future upsert(UserModel model) async {
    await _client.from('users').upsert(model.toMap());
  }
}
