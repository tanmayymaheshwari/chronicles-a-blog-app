import 'package:chronicles/core/usecase/usecase.dart';
import 'package:chronicles/features/auth/domain/entities/user.dart';
import 'package:chronicles/features/auth/domain/usecases/current_user.dart';
import 'package:chronicles/features/auth/domain/usecases/user_login.dart';
import 'package:chronicles/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        // Initializer List
        super(AuthInitial()) {
    on<AuthSignUpEvent>(_onAuthSignUpEvent);
    on<AuthLoginEvent>(_onAuthLoginEvent);
    on<AuthIsUserLoggedInEvent>(_onAuthIsUserLoggedInEvent);
  }

  void _onAuthIsUserLoggedInEvent(
    AuthIsUserLoggedInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _currentUser(
      NoParams(),
    );
    response.fold(
      (failure) => emit(AuthFailureState(message: failure.message)),
      (success) => print(success.email),
    );
  }

  void _onAuthSignUpEvent(
    AuthSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
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
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
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
