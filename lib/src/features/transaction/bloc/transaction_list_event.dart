part of 'transaction_list_bloc.dart';

sealed class TransactionListEvent extends Equatable {
  const TransactionListEvent();

  @override
  List<Object> get props => [];
}

class LoadTransactionByStatusProcess extends TransactionListEvent {}

class LoadTransactionByStatusReady extends TransactionListEvent {}

class LoadTransactionByStatusComplete extends TransactionListEvent {}

class TransactionUpdateStatusProcess extends TransactionListEvent {
  final int id;
  final String status;

  const TransactionUpdateStatusProcess({
    required this.id,
    required this.status,
  });

  @override
  List<Object> get props => [
        id,
        status,
      ];
}

class TransactionUpdateStatusReady extends TransactionListEvent {
  final int id;
  final String status;

  const TransactionUpdateStatusReady({
    required this.id,
    required this.status,
  });

  @override
  List<Object> get props => [
        id,
        status,
      ];
}

class TransactionSetInitialUpdate extends TransactionListEvent {}
