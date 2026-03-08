import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

abstract class ContractListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContractListInitialState extends ContractListState {}

class ContractListLoadingState extends ContractListState {}

class ContractListLoadedState extends ContractListState {
  final List<ContractEntity> contracts;

  ContractListLoadedState(this.contracts);

  @override
  List<Object?> get props => [contracts];
}

class ContractListEmptyState extends ContractListState {}

class ContractListErrorState extends ContractListState {
  final String message;
  ContractListErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
