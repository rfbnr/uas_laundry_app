import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/datasources/transaction_remote_datasource.dart';
import '../../../../data/response/response/error_response_model.dart';
import '../../../../data/response/response/success_response_model.dart';
import '../../../../data/response/response/transaction_response_model.dart';

part 'transaction_list_event.dart';
part 'transaction_list_state.dart';

class TransactionListBloc
    extends Bloc<TransactionListEvent, TransactionListState> {
  final TransactionRemoteDatasource transactionRemoteDatasource;

  TransactionListBloc({
    required this.transactionRemoteDatasource,
  }) : super(const TransactionListState()) {
    on<LoadTransactionByStatusProcess>(_onLoadTransactionByStatusProcess);
    on<LoadTransactionByStatusReady>(_onLoadTransactionByStatusReady);
    on<LoadTransactionByStatusComplete>(_onLoadTransactionByStatusComplete);
  }

  Future<void> _onLoadTransactionByStatusProcess(
    LoadTransactionByStatusProcess event,
    Emitter<TransactionListState> emit,
  ) async {
    emit(
      state.copyWith(
        statusProcess: TransactionProcessStatus.loading,
      ),
    );

    try {
      final response =
          await transactionRemoteDatasource.fetchGetTransactionByStatus(
        status: "process",
      );

      response.fold(
        (l) {
          emit(
            state.copyWith(
              statusProcess: TransactionProcessStatus.failure,
              error: l,
            ),
          );
        },
        (r) {
          emit(
            state.copyWith(
              statusProcess: TransactionProcessStatus.success,
              transactionsProcess: r.data,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          statusProcess: TransactionProcessStatus.failure,
          error: ErrorResponseModel(
            status: "error",
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onLoadTransactionByStatusReady(
    LoadTransactionByStatusReady event,
    Emitter<TransactionListState> emit,
  ) async {
    emit(
      state.copyWith(
        statusReady: TransactionReadyStatus.loading,
      ),
    );

    try {
      final response =
          await transactionRemoteDatasource.fetchGetTransactionByStatus(
        status: "ready",
      );

      response.fold(
        (l) {
          emit(
            state.copyWith(
              statusReady: TransactionReadyStatus.failure,
              error: l,
            ),
          );
        },
        (r) {
          emit(
            state.copyWith(
              statusReady: TransactionReadyStatus.success,
              transactionsReady: r.data,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          statusReady: TransactionReadyStatus.failure,
          error: ErrorResponseModel(
            status: "error",
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onLoadTransactionByStatusComplete(
    LoadTransactionByStatusComplete event,
    Emitter<TransactionListState> emit,
  ) async {
    emit(
      state.copyWith(
        statusComplete: TransactionCompleteStatus.loading,
      ),
    );

    try {
      final response =
          await transactionRemoteDatasource.fetchGetTransactionByStatus(
        status: "completed",
      );

      response.fold(
        (l) {
          emit(
            state.copyWith(
              statusComplete: TransactionCompleteStatus.failure,
              error: l,
            ),
          );
        },
        (r) {
          emit(
            state.copyWith(
              statusComplete: TransactionCompleteStatus.success,
              transactionsComplete: r.data,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          statusComplete: TransactionCompleteStatus.failure,
          error: ErrorResponseModel(
            status: "error",
            message: e.toString(),
          ),
        ),
      );
    }
  }
}
