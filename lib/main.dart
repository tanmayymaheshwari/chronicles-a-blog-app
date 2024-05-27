import 'package:chronicles/core/secrets/app_secrets.dart';
import 'package:chronicles/core/theme/theme.dart';
import 'package:chronicles/features/auth/data/datasources/auth_supabase_datasource.dart';
import 'package:chronicles/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chronicles/features/auth/domain/usecases/user_sign_up.dart';
import 'package:chronicles/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chronicles/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBloc(
          userSignUp: UserSignUp(
            authRepository: AuthRepositoryImpl(
              remoteDatasource: AuthSupabaseDatasourceImpl(
                supabaseClient: supabase.client
              ),
            ),
          ),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chronicles',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
