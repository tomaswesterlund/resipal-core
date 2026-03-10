import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/use_cases/maintenance/can_pay_maintenance_fee.dart';
import 'package:resipal_core/src/domain/use_cases/maintenance/pay_maintenance_fee.dart';

class MaintenanceFeeDetailsCubit extends Cubit<MaintenanceFeeDetailsState> {
  final LoggerService _logger = GetIt.I<LoggerService>();

  // Assumes use case exists in your domain layer
  final WatchMaintenanceFeeById _watchFee = WatchMaintenanceFeeById();
  StreamSubscription? _streamSubscription;

  MaintenanceFeeDetailsCubit() : super(MaintenanceFeeDetailsInitialState());

  Future<void> initialize(MaintenanceFeeEntity fee) async {
    try {
      final canPayFee = CanPayMaintenanceFee().call(maintenanceFeeId: fee.id);
      emit(MaintenanceFeeDetailsLoadedState(fee: fee, canPay: canPayFee));

      _streamSubscription = _watchFee
          .call(fee.id)
          .listen(
            (updatedFee) {
              final canPayFee = CanPayMaintenanceFee().call(maintenanceFeeId: updatedFee.id);
              emit(MaintenanceFeeDetailsLoadedState(fee: updatedFee, canPay: canPayFee));
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

  Future payMaintenanceFee(MaintenanceFeeEntity fee) async {
    try {
      await PayMaintenanceFee().call(fee.id);
    } catch (e, s) {
      _logger.logException(featureArea: 'MaintenanceFeeDetailsCubit.payMaintenanceFee', exception: e, stackTrace: s);
      emit(MaintenanceFeeDetailsErrorState());
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
