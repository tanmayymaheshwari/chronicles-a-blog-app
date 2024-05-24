import 'package:chronicles/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({required UserSignUp userSignUp})
      : _userSignUp = userSignUp, // Initializer List
        super(AuthInitial()) {
    on<AuthSignUpEvent>((event, emit) async {
      final response = await _userSignUp(UserSignUpParam(
        email: event.email,
        name: event.name,
        password: event.password,
      ));

      response.fold(
        (failure) => emit(AuthFailureState(message: failure.message)),
        (success) => emit(AuthSuccessState(uid: success)),
      );
    });
  }
}
