import 'package:chronicles/core/error/failure.dart';
import 'package:chronicles/core/usecase/usecase.dart';
import 'package:chronicles/core/common/entities/user.dart';
import 'package:chronicles/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements Usecase<User, NoParams> {
  
  final AuthRepository authRepository;
  CurrentUser({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
