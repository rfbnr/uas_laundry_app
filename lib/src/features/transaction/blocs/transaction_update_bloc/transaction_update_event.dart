part of 'transaction_update_bloc.dart';

sealed class TransactionUpdateEvent extends Equatable {
  const TransactionUpdateEvent();

  @override
  List<Object> get props => [];
}

class TransactionUpdateReadyStatus extends TransactionUpdateEvent {
  final int id;
  final String status;

  const TransactionUpdateReadyStatus({
    required this.id,
    required this.status,
  });

  @override
  List<Object> get props => [
        id,
        status,
      ];
}

class TransactionUpdateProcessStatus extends TransactionUpdateEvent {
  final int id;
  final String status;

  const TransactionUpdateProcessStatus({
    required this.id,
    required this.status,
  });

  @override
  List<Object> get props => [
        id,
        status,
      ];
}

class TransactionSetInitialUpdateReady extends TransactionUpdateEvent {}

class TransactionSetInitialUpdateProcess extends TransactionUpdateEvent {}
