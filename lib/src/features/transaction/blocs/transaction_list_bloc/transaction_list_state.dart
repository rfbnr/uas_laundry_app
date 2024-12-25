part of 'transaction_list_bloc.dart';

enum TransactionProcessStatus { initial, loading, success, failure }

enum TransactionReadyStatus { initial, loading, success, failure }

enum TransactionCompleteStatus { initial, loading, success, failure }

class TransactionListState extends Equatable {
  final TransactionProcessStatus? statusProcess;
  final TransactionReadyStatus? statusReady;
  final TransactionCompleteStatus? statusComplete;
  final List<TransactionResultResponseModel>? transactionsProcess;
  final List<TransactionResultResponseModel>? transactionsReady;
  final List<TransactionResultResponseModel>? transactionsComplete;
  final ErrorResponseModel? error;
  final SuccessResponseModel? result;

  const TransactionListState({
    this.statusProcess = TransactionProcessStatus.initial,
    this.statusReady = TransactionReadyStatus.initial,
    this.statusComplete = TransactionCompleteStatus.initial,
    this.transactionsProcess = const <TransactionResultResponseModel>[],
    this.transactionsReady = const <TransactionResultResponseModel>[],
    this.transactionsComplete = const <TransactionResultResponseModel>[],
    this.error,
    this.result,
  });

  TransactionListState copyWith({
    TransactionProcessStatus? statusProcess,
    TransactionReadyStatus? statusReady,
    TransactionCompleteStatus? statusComplete,
    List<TransactionResultResponseModel>? transactionsProcess,
    List<TransactionResultResponseModel>? transactionsReady,
    List<TransactionResultResponseModel>? transactionsComplete,
    ErrorResponseModel? error,
    SuccessResponseModel? result,
  }) {
    return TransactionListState(
      statusProcess: statusProcess ?? this.statusProcess,
      statusReady: statusReady ?? this.statusReady,
      statusComplete: statusComplete ?? this.statusComplete,
      transactionsProcess: transactionsProcess ?? this.transactionsProcess,
      transactionsReady: transactionsReady ?? this.transactionsReady,
      transactionsComplete: transactionsComplete ?? this.transactionsComplete,
      error: error ?? this.error,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [
        statusProcess,
        statusReady,
        statusComplete,
        transactionsProcess,
        transactionsReady,
        transactionsComplete,
        error,
        result,
      ];
}
