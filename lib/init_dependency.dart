import 'package:chronicles/core/secrets/app_secrets.dart';
import 'package:chronicles/features/auth/data/datasources/auth_supabase_datasource.dart';
import 'package:chronicles/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chronicles/features/auth/domain/repository/auth_repository.dart';
import 'package:chronicles/features/auth/domain/usecases/user_login.dart';
import 'package:chronicles/features/auth/domain/usecases/user_sign_up.dart';
import 'package:chronicles/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  // AuthSupabaseDatasource is passed manually because GetIt
  // does not know that AuthSupaImpl is an implementation of
  // AuthSupaData, which is required in AuthRepoImpl

  serviceLocator.registerFactory<AuthSupabaseDatasource>(
    () => AuthSupabaseDatasourceImpl(
      supabaseClient: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDatasource: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserSignUp(
      authRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserLogin(
      authRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
    ),
  );
}
