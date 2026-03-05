import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/services/pdf_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ServiceLocator {
  Future<void> initializeContainers() async {
    final sl = GetIt.instance;

    final supabase = ResipalSupabase();
    await supabase.init();
    sl.registerSingleton<ResipalSupabase>(supabase);
    sl.registerSingleton<SupabaseClient>(supabase.client);

    // Services
    sl.registerLazySingleton(() => AuthService());
    sl.registerLazySingleton(() => ImageService());
    sl.registerLazySingleton(() => LoggerService());
    sl.registerLazySingleton(() => PdfService());
  
    // Data sources
    sl.registerLazySingleton(() => AccessLogDataSource());
    sl.registerLazySingleton(() => ApplicationDataSource());
    sl.registerLazySingleton(() => CommunityDataSource());
    sl.registerLazySingleton(() => ErrorLogDataSource());
    sl.registerLazySingleton(() => InvitationDataSource());
    sl.registerLazySingleton(() => ContractDataSource());
    sl.registerLazySingleton(() => MaintenanceFeeDataSource());
    sl.registerLazySingleton(() => MembershipDataSource());
    sl.registerLazySingleton(() => MovementDataSource());
    sl.registerLazySingleton(() => PaymentDataSource());
    sl.registerLazySingleton(() => PropertyDataSource());
    sl.registerLazySingleton(() => VisitorDataSource());
    sl.registerLazySingleton(() => UserDataSource());
  }
}
