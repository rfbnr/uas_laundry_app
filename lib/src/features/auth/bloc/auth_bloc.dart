import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/datasources/auth_local_datasource.dart';
import '../../../data/response/request/register_request_model.dart';
import '../../../data/response/response/error_response_model.dart';
import '../../../data/response/response/success_response_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthLocalDatasource authLocalDatasource;

  AuthBloc({
    required this.authLocalDatasource,
  }) : super(const AuthState()) {
    on<VisibilityPassword>(_onVisibilityPassword);
    on<VisibilityRegisterPassword>(_onVisibilityRegisterPassword);
    on<VisibilityConfirmPassword>(_onVisibilityConfirmPassword);

    on<UserRegister>(_onUserRegister);
    on<UserLogin>(_onUserLogin);
    on<UserLogout>(_onUserLogout);

    on<GetUserLogin>(_onGetUserLogin);

    on<SaveUserLogin>(_onSaveUserLogin);
    on<DeleteUserLogin>(_onDeleteUserLogin);
    on<UserIsLogin>(_onUserIsLogin);

    on<AuthSetInitial>(_onAuthSetInitial);
    on<LoginSetInitial>(_onLoginSetInitial);
    on<RegisterSetInitial>(_onRegisterSetInitial);
  }

  void _onVisibilityPassword(
    VisibilityPassword event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(showPassword: !event.newValue),
    );
  }

  void _onVisibilityRegisterPassword(
    VisibilityRegisterPassword event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(showRegisterPassword: !event.newValue),
    );
  }

  void _onVisibilityConfirmPassword(
    VisibilityConfirmPassword event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(showConfirmPassword: !event.newValue),
    );
  }

  void _onAuthSetInitial(
    AuthSetInitial event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        status: AuthStatus.initial,
        logoutStatus: LogoutStatus.initial,
      ),
    );
  }

  void _onLoginSetInitial(
    LoginSetInitial event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        loginStatus: LoginStatus.initial,
        showPassword: true,
      ),
    );
  }

  void _onRegisterSetInitial(
    RegisterSetInitial event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        registerStatus: RegisterStatus.initial,
        showConfirmPassword: true,
        showRegisterPassword: true,
      ),
    );
  }

  Future<void> _onUserIsLogin(
    UserIsLogin event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final authData = await authLocalDatasource.isLogin();

      authData.fold(
        (error) {
          emit(
            state.copyWith(
              status: AuthStatus.failure,
              error: error,
            ),
          );
        },
        (success) {
          emit(
            state.copyWith(
              status: AuthStatus.success,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          error: ErrorResponseModel(
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onDeleteUserLogin(
    DeleteUserLogin event,
    Emitter<AuthState> emit,
  ) async {
    await authLocalDatasource.removeLogin();
  }

  Future<void> _onSaveUserLogin(
    SaveUserLogin event,
    Emitter<AuthState> emit,
  ) async {
    await authLocalDatasource.saveLogin();
  }

  Future<void> _onGetUserLogin(
    GetUserLogin event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final authData = await authLocalDatasource.getAuthData();

      authData.fold(
        (error) {
          emit(
            state.copyWith(
              dataStatus: DataStatus.failure,
              error: error,
            ),
          );
        },
        (success) {
          emit(
            state.copyWith(
              dataStatus: DataStatus.success,
              dataUser: success,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          dataStatus: DataStatus.failure,
          error: ErrorResponseModel(
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onUserRegister(
    UserRegister event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        registerStatus: RegisterStatus.loading,
      ),
    );

    await Future.delayed(
      const Duration(seconds: 3),
      () async {
        try {
          await authLocalDatasource.saveAuthData(event.body);

          emit(
            state.copyWith(
              registerStatus: RegisterStatus.success,
              result: SuccessResponseModel(
                message: "Register success",
              ),
            ),
          );
          add(RegisterSetInitial());
        } catch (e) {
          emit(
            state.copyWith(
              registerStatus: RegisterStatus.failure,
              error: ErrorResponseModel(
                message: e.toString(),
              ),
            ),
          );
          add(RegisterSetInitial());
        }
      },
    );
  }

  Future<void> _onUserLogin(
    UserLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        loginStatus: LoginStatus.loading,
      ),
    );

    await Future.delayed(
      const Duration(seconds: 3),
      () async {
        try {
          final authData = await authLocalDatasource.getAuthData();

          authData.fold(
            (error) {
              emit(
                state.copyWith(
                  loginStatus: LoginStatus.failure,
                  error: error,
                ),
              );
              add(LoginSetInitial());
            },
            (success) {
              if (success.email == event.email &&
                  success.password == event.password) {
                emit(
                  state.copyWith(
                    loginStatus: LoginStatus.success,
                    result: SuccessResponseModel(
                      message: "Login success",
                    ),
                    dataUser: success,
                  ),
                );
                add(LoginSetInitial());
              } else {
                emit(
                  state.copyWith(
                    loginStatus: LoginStatus.failure,
                    error: ErrorResponseModel(
                      message: "Email or password is wrong",
                    ),
                  ),
                );
                add(LoginSetInitial());
              }
            },
          );
        } catch (e) {
          emit(
            state.copyWith(
              status: AuthStatus.failure,
              error: ErrorResponseModel(
                message: e.toString(),
              ),
            ),
          );
          add(LoginSetInitial());
        }
      },
    );
  }

  Future<void> _onUserLogout(
    UserLogout event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        logoutStatus: LogoutStatus.loading,
      ),
    );

    await Future.delayed(
      const Duration(seconds: 3),
      () async {
        try {
          // await authLocalDatasource.removeAuthData();

          emit(
            state.copyWith(
              logoutStatus: LogoutStatus.success,
              result: SuccessResponseModel(
                message: "Logout success",
              ),
            ),
          );
          // add(AuthSetInitial());
        } catch (e) {
          emit(
            state.copyWith(
              logoutStatus: LogoutStatus.failure,
              error: ErrorResponseModel(
                message: e.toString(),
              ),
            ),
          );
          // add(AuthSetInitial());
        }
      },
    );
  }
}
