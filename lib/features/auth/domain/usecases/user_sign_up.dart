import 'package:chronicles/core/error/failures.dart';
import 'package:chronicles/core/usecase/usecase.dart';
import 'package:chronicles/core/common/entities/user.dart';
import 'package:chronicles/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<User, UserSignUpParam> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParam params) async {
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
