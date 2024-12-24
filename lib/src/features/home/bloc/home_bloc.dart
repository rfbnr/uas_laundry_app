import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/datasources/transaction_remote_datasource.dart';
import '../../../data/response/response/error_response_model.dart';
import '../../../data/response/response/success_response_model.dart';
import '../../../data/response/response/transaction_dashboard_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TransactionRemoteDatasource transactionRemoteDatasource;
  HomeBloc({
    required this.transactionRemoteDatasource,
  }) : super(const HomeState()) {
    on<HomeLoadDashboardTransaction>(_onHomeLoadDashboardTransaction);
  }

  Future<void> _onHomeLoadDashboardTransaction(
    HomeLoadDashboardTransaction event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        status: HomeStatus.loading,
      ),
    );

    try {
      final response =
          await transactionRemoteDatasource.fetchGetDashboardTransaction();

      response.fold(
        (l) {
          emit(
            state.copyWith(
              status: HomeStatus.failure,
              error: l,
            ),
          );
        },
        (r) {
          emit(
            state.copyWith(
              status: HomeStatus.success,
              dashboard: r.data,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          error: ErrorResponseModel(
            message: e.toString(),
          ),
        ),
      );
    }
  }
}
