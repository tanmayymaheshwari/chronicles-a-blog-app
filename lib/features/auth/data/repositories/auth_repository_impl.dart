import 'package:chronicles/core/error/exceptions.dart';
import 'package:chronicles/core/error/failure.dart';
import 'package:chronicles/features/auth/data/datasources/auth_supabase_datasource.dart';
import 'package:chronicles/features/auth/domain/entities/user.dart';
import 'package:chronicles/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthSupabaseDatasource remoteDatasource;
  AuthRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDatasource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
