import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../domain/usecases/logout_use_use_case.dart';

import '../../../../../core/utils/services/service_locator.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/login_user_use_case.dart';
import '../../../domain/usecases/retreive_access_token_use_case.dart';
import '../../../domain/usecases/retreive_user_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginUserUseCase loginUserUseCase;
  RetreiveAccessTokenUseCase retreiveAccessTokenUseCase;
  RetreiveUserUseCase retreiveUserUseCase;
  LogoutUserUseCase logoutUserUseCase;
  LoginCubit()
    : loginUserUseCase = getIt(),
      logoutUserUseCase = getIt(),
      retreiveAccessTokenUseCase = getIt(),
      retreiveUserUseCase = getIt(),
      super(const LoginInitial()) {
    log("login cubit is created");
  }
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool rememberMe = false;

  final formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    log("isPasswordVisible: $isPasswordVisible");
    emit(LoginInitial(dummy: !state.dummy));
  }

  void toggleRememberMe() {
    rememberMe = !rememberMe;
    emit(LoginInitial(dummy: state.dummy));
  }

  Future<void> login() async {
    emit(LoginLoading());

    final result = await loginUserUseCase.call(
      body: {
        'username': usernameController.text,
        'password': passwordController.text,
      },
    );

    result.fold(
      (failure) => emit(LoginFailure(errorMessage: failure.errMessage)),
      (user) => emit(LoginSuccess(user: user)),
    );
  }

  retrieveUser() async {
    log("retrieving user");
    final result = await retreiveUserUseCase.call();
    result.fold(
      (failure) {
        log("failure: ${failure.errMessage}");
        emit(LoginFailure(errorMessage: failure.errMessage));
      },
      (user) {
        log("user: $user");
        emit(LoginSuccess(user: user));
      },
    );
  }

  logout() async {
    emit(LoginLoading());
    final result = await logoutUserUseCase.call();
    result.fold(
      (failure) => emit(LoginFailure(errorMessage: failure.errMessage)),
      (data) => emit(LogoutSuccess(message: data.message)),
    );
  }

  void resetState() {
    emit(LoginInitial());
  }

  @override
  Future<void> close() async {
    usernameController.dispose();
    passwordController.dispose();
    log("login cubit is closed");
    return super.close();
  }

  @override
  void onChange(Change<LoginState> change) {
    log("is state changed: ${change.currentState == change.nextState}");
    super.onChange(change);
  }
}
