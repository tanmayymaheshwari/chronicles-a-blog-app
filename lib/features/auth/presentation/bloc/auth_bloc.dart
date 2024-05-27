import 'package:chronicles/features/auth/domain/entities/user.dart';
import 'package:chronicles/features/auth/domain/usecases/user_login.dart';
import 'package:chronicles/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        // Initializer List
        super(AuthInitial()) {
    on<AuthSignUpEvent>(_onAuthSignUpEvent);
    on<AuthLoginEvent>(_onAuthLoginEvent);
  }

  void _onAuthSignUpEvent(
      AuthSignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final response = await _userSignUp(
      UserSignUpParam(
        email: event.email,
        name: event.name,
        password: event.password,
      ),
    );
    response.fold(
      (failure) => emit(AuthFailureState(message: failure.message)),
      (success) => emit(AuthSuccessState(user: success)),
    );
  }

  void _onAuthLoginEvent(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final response = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    response.fold(
      (failure) => emit(AuthFailureState(message: failure.message)),
      (success) => emit(AuthSuccessState(user: success)),
    );
  }
}
