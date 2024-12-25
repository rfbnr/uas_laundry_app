import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/datasources/transaction_remote_datasource.dart';
import '../../../../data/response/request/transaction_request_model.dart';
import '../../../../data/response/response/error_response_model.dart';
import '../../../../data/response/response/success_response_model.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRemoteDatasource transactionRemoteDatasource;

  TransactionBloc({
    required this.transactionRemoteDatasource,
  }) : super(const TransactionState()) {
    on<TransactionCreateData>(_onTransactionCreateData);

    on<TransactionSetInitial>(_onTransactionSetInitial);
  }

  void _onTransactionSetInitial(
    TransactionSetInitial event,
    Emitter<TransactionState> emit,
  ) {
    emit(
      state.copyWith(
        status: TransactionStatus.initial,
      ),
    );
  }

  Future<void> _onTransactionCreateData(
    TransactionCreateData event,
    Emitter<TransactionState> emit,
  ) async {
    emit(
      state.copyWith(
        status: TransactionStatus.loading,
      ),
    );

    try {
      final response =
          await transactionRemoteDatasource.fetchRequestTransaction(
        body: event.body,
      );

      response.fold(
        (l) {
          emit(
            state.copyWith(
              status: TransactionStatus.failure,
              error: l,
            ),
          );
        },
        (r) {
          emit(
            state.copyWith(
              status: TransactionStatus.success,
              result: r,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TransactionStatus.failure,
          error: ErrorResponseModel(message: e.toString()),
        ),
      );
    }
  }
}
