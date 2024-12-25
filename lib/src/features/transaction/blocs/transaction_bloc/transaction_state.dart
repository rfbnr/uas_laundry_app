part of 'transaction_bloc.dart';

enum TransactionStatus { initial, loading, success, failure }

class TransactionState extends Equatable {
  final TransactionStatus? status;
  final ErrorResponseModel? error;
  final SuccessResponseModel? result;

  const TransactionState({
    this.status = TransactionStatus.initial,
    this.error,
    this.result,
  });

  TransactionState copyWith({
    TransactionStatus? status,
    ErrorResponseModel? error,
    SuccessResponseModel? result,
  }) {
    return TransactionState(
      status: status ?? this.status,
      error: error ?? this.error,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [
        status,
        error,
        result,
      ];
}
