import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/data/models/membership_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MembershipDataSource {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  final Map<String, MembershipModel> _cache = {};

  Stream<MembershipModel> watchById(String id) {
    return _client.from('memberships').stream(primaryKey: ['id']).eq('id', id).map((data) {
      // if (data.isEmpty) {
      //   throw Exception('User not found');
      // }
      final model = MembershipModel.fromMap(data.first);
      _cache[model.id] = model;
      return model;
    });
  }

  Stream<List<MembershipModel>> watchByCommunityId(String communityId) {
    return _client
        .from('memberships')
        .stream(primaryKey: ['id'])
        .eq('community_id', communityId)
        .map(
          (data) => data.map((item) {
            final model = MembershipModel.fromMap(item);
            _cache[model.id] = model;
            return model;
          }).toList(),
        );
  }

  MembershipModel? getById(String id) => _cache[id];

  List<MembershipModel> getByCommunityId(String communityId) =>
      _cache.values.where((x) => x.communityId == communityId).toList();

  Future fetchAndCacheAll() async {
    final items = await _client.from('memberships').select();
    for (var item in items) {
      final model = MembershipModel.fromMap(item);
      _cache[model.id] = model;
    }
  }

  Future fetchAndCacheById(String id) async {
    final item = await _client.from('memberships').select().eq('id', id).single();
    final model = MembershipModel.fromMap(item);

    _cache[model.id] = model;
  }

  Future upsert(MembershipModel model) async {
    await _client.from('memberships').upsert(model.toMap());
  }
}
