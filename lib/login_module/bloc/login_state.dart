part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LogInInvalidState extends LoginState {}

class LogInValidState extends LoginState {}

class LogInErrorState extends LoginState {
  final String errorMessage;
  LogInErrorState(this.errorMessage);
}

class LogInLoadingState extends LoginState {}

class LogInShowPasswordState extends LoginState {
  final bool visible;
  LogInShowPasswordState(this.visible);
}

class LoginedSuccessfullState extends LoginState {}

class MoveToSetPinState extends LoginState {}
