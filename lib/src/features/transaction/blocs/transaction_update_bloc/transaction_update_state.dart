part of 'transaction_update_bloc.dart';

enum UpdateReadyStatus { initial, loading, success, failure }

enum UpdateProcessStatus { initial, loading, success, failure }

class TransactionUpdateState extends Equatable {
  final UpdateReadyStatus? updateReadyStatus;
  final UpdateProcessStatus? updateProcessStatus;
  final ErrorResponseModel? error;
  final SuccessResponseModel? result;

  const TransactionUpdateState({
    this.updateProcessStatus = UpdateProcessStatus.initial,
    this.updateReadyStatus = UpdateReadyStatus.initial,
    this.error,
    this.result,
  });

  TransactionUpdateState copyWith({
    UpdateReadyStatus? updateReadyStatus,
    UpdateProcessStatus? updateProcessStatus,
    ErrorResponseModel? error,
    SuccessResponseModel? result,
  }) {
    return TransactionUpdateState(
      updateReadyStatus: updateReadyStatus ?? this.updateReadyStatus,
      updateProcessStatus: updateProcessStatus ?? this.updateProcessStatus,
      error: error ?? this.error,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [
        updateReadyStatus,
        updateProcessStatus,
        error,
        result,
      ];
}
