import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/datasources/transaction_remote_datasource.dart';
import '../../../../data/response/response/error_response_model.dart';
import '../../../../data/response/response/success_response_model.dart';

part 'transaction_update_event.dart';
part 'transaction_update_state.dart';

class TransactionUpdateBloc
    extends Bloc<TransactionUpdateEvent, TransactionUpdateState> {
  final TransactionRemoteDatasource transactionRemoteDatasource;

  TransactionUpdateBloc({
    required this.transactionRemoteDatasource,
  }) : super(const TransactionUpdateState()) {
    on<TransactionUpdateReadyStatus>(_onTransactionUpdateReadyStatus);
    on<TransactionUpdateProcessStatus>(_onTransactionUpdateProcessStatus);

    on<TransactionSetInitialUpdateReady>(_onTransactionSetInitialUpdateReady);
    on<TransactionSetInitialUpdateProcess>(
        _onTransactionSetInitialUpdateProcess);
  }

  void _onTransactionSetInitialUpdateReady(
    TransactionSetInitialUpdateReady event,
    Emitter<TransactionUpdateState> emit,
  ) {
    emit(
      state.copyWith(
        updateReadyStatus: UpdateReadyStatus.initial,
      ),
    );
  }

  void _onTransactionSetInitialUpdateProcess(
    TransactionSetInitialUpdateProcess event,
    Emitter<TransactionUpdateState> emit,
  ) {
    emit(
      state.copyWith(
        updateProcessStatus: UpdateProcessStatus.initial,
      ),
    );
  }

  Future<void> _onTransactionUpdateReadyStatus(
    TransactionUpdateReadyStatus event,
    Emitter<TransactionUpdateState> emit,
  ) async {
    emit(
      state.copyWith(
        updateReadyStatus: UpdateReadyStatus.loading,
      ),
    );

    try {
      final response =
          await transactionRemoteDatasource.fetchUpdateStatusTransaction(
        id: event.id,
        status: event.status,
      );

      response.fold(
        (l) {
          emit(
            state.copyWith(
              updateReadyStatus: UpdateReadyStatus.failure,
              error: l,
            ),
          );

          add(TransactionSetInitialUpdateReady());
        },
        (r) {
          emit(
            state.copyWith(
              updateReadyStatus: UpdateReadyStatus.success,
              result: r,
            ),
          );
          add(TransactionSetInitialUpdateReady());
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          updateReadyStatus: UpdateReadyStatus.failure,
          error: ErrorResponseModel(
            status: "error",
            message: e.toString(),
          ),
        ),
      );
      add(TransactionSetInitialUpdateReady());
    }
  }

  Future<void> _onTransactionUpdateProcessStatus(
    TransactionUpdateProcessStatus event,
    Emitter<TransactionUpdateState> emit,
  ) async {
    emit(
      state.copyWith(
        updateProcessStatus: UpdateProcessStatus.loading,
      ),
    );

    try {
      final response =
          await transactionRemoteDatasource.fetchUpdateStatusTransaction(
        id: event.id,
        status: event.status,
      );

      response.fold(
        (l) {
          emit(
            state.copyWith(
              updateProcessStatus: UpdateProcessStatus.failure,
              error: l,
            ),
          );

          add(TransactionSetInitialUpdateProcess());
        },
        (r) {
          emit(
            state.copyWith(
              updateProcessStatus: UpdateProcessStatus.success,
              result: r,
            ),
          );
          add(TransactionSetInitialUpdateProcess());
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          updateProcessStatus: UpdateProcessStatus.failure,
          error: ErrorResponseModel(
            status: "error",
            message: e.toString(),
          ),
        ),
      );
      add(TransactionSetInitialUpdateProcess());
    }
  }
}
