import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isfa_crm/login_module/login_repository.dart';
import 'package:isfa_crm/utility/app_storage.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repo;
  bool isShowingPassword = false;

  LoginBloc(this.repo) : super(LoginInitialState()) {
    on<LoginShowPasswordButtonEvent>((event, emit) {
      isShowingPassword = !isShowingPassword;
      emit(LogInShowPasswordState(isShowingPassword));
    });

    on<LoginTextChangeEvent>((event, emit) {
      emit(LogInValidState());
    });

    on<LoginSubmitEvent>((event, emit) async {
      if (event.username.isEmpty) {
        emit(LogInErrorState("Username is empty"));
      } else if (event.password.isEmpty) {
        emit(LogInErrorState("Password is empty"));
      } else if (event.password.length < 6) {
        emit(LogInErrorState("short password"));
      } else {
        try {
          emit(LogInLoadingState());
          final loginRespone = await repo
              .login(
                  username: event.username.trim(),
                  password: event.password.trim())
              .catchError((onError) {
            throw onError.toString();
          });

          if (loginRespone.statusCode == 200) {
            AppStorage().userDetail = loginRespone;
            emit(LoginedSuccessfullState());
          } else {
            emit(LogInErrorState("User doesn't exist."));
          }
        } catch (err) {
          emit(LogInErrorState(err.toString()));
        }
      }
    });
  }
}
