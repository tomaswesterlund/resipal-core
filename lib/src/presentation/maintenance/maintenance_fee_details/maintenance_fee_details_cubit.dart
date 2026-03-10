import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/use_cases/maintenance/watch_maintenance_fee_by_id.dart';
import 'maintenance_fee_details_state.dart';

class MaintenanceFeeDetailsCubit extends Cubit<MaintenanceFeeDetailsState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  
  // Assumes use case exists in your domain layer
  final WatchMaintenanceFeeById _watchFee = WatchMaintenanceFeeById(); 
  StreamSubscription? _streamSubscription;

  MaintenanceFeeDetailsCubit() : super(MaintenanceFeeDetailsInitialState());

  Future<void> initialize(MaintenanceFeeEntity fee) async {
    try {
      emit(MaintenanceFeeDetailsLoadedState(fee));

      _streamSubscription = _watchFee
          .call(fee.id)
          .listen(
            (updatedFee) {
              emit(MaintenanceFeeDetailsLoadedState(updatedFee));
            },
            onError: (e, s) {
              _logger.logException(
                featureArea: 'MaintenanceFeeDetailsCubit.initialize',
                exception: e,
                stackTrace: s,
                metadata: {'feeId': fee.id},
              );
              emit(MaintenanceFeeDetailsErrorState());
            },
          );
    } catch (e, s) {
      _logger.logException(
        exception: e,
        featureArea: 'MaintenanceFeeDetailsCubit.initialize',
        stackTrace: s,
        metadata: {'fee': fee.toMap()},
      );
      emit(MaintenanceFeeDetailsErrorState());
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}