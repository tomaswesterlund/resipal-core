import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResipalSupabase {
  Future<void> init() async {
    final config = GetIt.I<ResipalSupabaseConfig>();

    await Supabase.initialize(url: config.url, anonKey: config.anonKey);
  }

  SupabaseClient get client => Supabase.instance.client;
}

class ResipalSupabaseConfig {
  final String url;
  final String anonKey;

  ResipalSupabaseConfig({required this.url, required this.anonKey});
}
