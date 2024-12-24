part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus? status;
  final TransactionDashboardResultResponseModel? dashboard;
  final ErrorResponseModel? error;
  final SuccessResponseModel? result;

  const HomeState({
    this.status = HomeStatus.initial,
    this.dashboard,
    this.error,
    this.result,
  });

  HomeState copyWith({
    HomeStatus? status,
    TransactionDashboardResultResponseModel? dashboard,
    ErrorResponseModel? error,
    SuccessResponseModel? result,
  }) {
    return HomeState(
      status: status ?? this.status,
      dashboard: dashboard ?? this.dashboard,
      error: error ?? this.error,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [
        status,
        dashboard,
        error,
        result,
      ];
}
