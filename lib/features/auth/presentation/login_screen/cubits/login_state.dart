part of 'login_cubit.dart';

sealed class LoginState {
  final bool dummy;
  const LoginState({this.dummy = false});
}

class LoginInitial extends LoginState {
  const LoginInitial({super.dummy});
  LoginInitial copyWith({bool? dummy}) =>
      LoginInitial(dummy: dummy ?? this.dummy);
}

class LoginLoading extends LoginState {
  const LoginLoading({super.dummy});
  LoginLoading copyWith({bool? dummy}) =>
      LoginLoading(dummy: dummy ?? this.dummy);
}

class LoginSuccess extends LoginState {
  final UserEntity user;
  const LoginSuccess({super.dummy, required this.user});
  LoginSuccess copyWith({bool? dummy, UserEntity? user}) =>
      LoginSuccess(dummy: dummy ?? this.dummy, user: user ?? this.user);
}

class LogoutSuccess extends LoginState {
  final String message;
  const LogoutSuccess({super.dummy, required this.message});
  LogoutSuccess copyWith({bool? dummy, String? message}) => LogoutSuccess(
    dummy: dummy ?? this.dummy,
    message: message ?? this.message,
  );
}

class LoginFailure extends LoginState {
  final String errorMessage;
  const LoginFailure({super.dummy, required this.errorMessage});
  LoginFailure copyWith({bool? dummy, String? errorMessage}) => LoginFailure(
    dummy: dummy ?? this.dummy,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
