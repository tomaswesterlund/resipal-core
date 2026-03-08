import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'contract_list_state.dart';

class ContractListCubit extends Cubit<ContractListState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SessionService _sessionService = GetIt.I<SessionService>();

  final WatchContractsByCommunity _watchContractsByCommunity = WatchContractsByCommunity();
  StreamSubscription? _streamSubscription;

  ContractListCubit() : super(ContractListInitialState());

  Future<void> initialize() async {
    try {
      emit(ContractListLoadingState());

      final communityId = _sessionService.communityId;

      _streamSubscription = _watchContractsByCommunity
          .call(communityId)
          .listen(
            (contracts) {
              if (contracts.isEmpty) {
                emit(ContractListEmptyState());
              } else {
                emit(ContractListLoadedState(contracts));
              }
            },
            onError: (e, s) {
              _logger.logException(exception: e, stackTrace: s, featureArea: 'ContractListCubit.initialize / listener');
              emit(ContractListErrorState('No se pudieron cargar los contratos'));
            },
          );
    } catch (e, s) {
      _logger.logException(exception: e, stackTrace: s, featureArea: 'ContractListCubit.initialize');
      emit(ContractListErrorState('No se pudieron cargar los contratos'));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
