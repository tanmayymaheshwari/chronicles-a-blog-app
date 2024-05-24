import 'package:chronicles/core/error/failure.dart';
import 'package:chronicles/core/usecase/usecase.dart';
import 'package:chronicles/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements Usecase<String, UserSignUpParam> {
  final AuthRepository authRepository;
  UserSignUp({required this.authRepository});

  @override
  Future<Either<Failure, String>> call(UserSignUpParam params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParam {
  final String email;
  final String name;
  final String password;

  UserSignUpParam({
    required this.email,
    required this.name,
    required this.password,
  });
}
