part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class TransactionCreateData extends TransactionEvent {
  final TransactionRequestModel body;

  const TransactionCreateData({
    required this.body,
  });

  @override
  List<Object> get props => [
        body,
      ];
}

class TransactionSetInitial extends TransactionEvent {}
