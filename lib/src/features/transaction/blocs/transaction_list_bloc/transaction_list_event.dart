part of 'transaction_list_bloc.dart';

sealed class TransactionListEvent extends Equatable {
  const TransactionListEvent();

  @override
  List<Object> get props => [];
}

class LoadTransactionByStatusProcess extends TransactionListEvent {}

class LoadTransactionByStatusReady extends TransactionListEvent {}

class LoadTransactionByStatusComplete extends TransactionListEvent {}
