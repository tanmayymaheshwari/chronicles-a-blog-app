import 'package:chronicles/core/error/exceptions.dart';
import 'package:chronicles/core/error/failure.dart';
import 'package:chronicles/features/auth/data/datasources/auth_supabase_datasource.dart';
import 'package:chronicles/features/auth/domain/entities/user.dart';
import 'package:chronicles/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthSupabaseDatasource remoteDatasource;
  AuthRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(
        () async => await remoteDatasource.loginWithEmailPassword(
          email: email,
          password: password,
        ),
      );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDatasource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    }
  }
  
}
