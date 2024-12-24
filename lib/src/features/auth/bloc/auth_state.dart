part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, failure }

enum DataStatus { initial, loading, success, failure }

enum LoginStatus { initial, loading, success, failure }

enum RegisterStatus { initial, loading, success, failure }

enum LogoutStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  final AuthStatus? status;
  final DataStatus? dataStatus;
  final LoginStatus? loginStatus;
  final RegisterStatus? registerStatus;
  final LogoutStatus? logoutStatus;
  final RegisterRequestModel? dataUser;
  final bool? showPassword;
  final bool? showRegisterPassword;
  final bool? showConfirmPassword;
  final String? messageLogout;
  final ErrorResponseModel? error;
  final SuccessResponseModel? result;

  const AuthState({
    this.status = AuthStatus.initial,
    this.dataStatus = DataStatus.initial,
    this.loginStatus = LoginStatus.initial,
    this.registerStatus = RegisterStatus.initial,
    this.logoutStatus = LogoutStatus.initial,
    this.dataUser,
    this.showPassword = true,
    this.showRegisterPassword = true,
    this.showConfirmPassword = true,
    this.messageLogout,
    this.error,
    this.result,
  });

  AuthState copyWith({
    AuthStatus? status,
    DataStatus? dataStatus,
    LoginStatus? loginStatus,
    RegisterStatus? registerStatus,
    LogoutStatus? logoutStatus,
    RegisterRequestModel? dataUser,
    bool? showPassword,
    bool? showRegisterPassword,
    bool? showConfirmPassword,
    String? messageLogout,
    ErrorResponseModel? error,
    SuccessResponseModel? result,
  }) {
    return AuthState(
      status: status ?? this.status,
      dataStatus: dataStatus ?? this.dataStatus,
      loginStatus: loginStatus ?? this.loginStatus,
      registerStatus: registerStatus ?? this.registerStatus,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      dataUser: dataUser ?? this.dataUser,
      showPassword: showPassword ?? this.showPassword,
      showRegisterPassword: showRegisterPassword ?? this.showRegisterPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      messageLogout: messageLogout ?? this.messageLogout,
      error: error ?? this.error,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [
        status,
        dataStatus,
        loginStatus,
        registerStatus,
        logoutStatus,
        showPassword,
        showRegisterPassword,
        showConfirmPassword,
        messageLogout,
        error,
        result,
      ];
}
