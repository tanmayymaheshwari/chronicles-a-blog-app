import 'dart:developer';

import 'package:chronicles/core/error/exceptions.dart';
import 'package:chronicles/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthSupabaseDatasource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthSupabaseDatasourceImpl implements AuthSupabaseDatasource {
  final SupabaseClient supabaseClient;

  AuthSupabaseDatasourceImpl({required this.supabaseClient});
  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );
      if (response.user == null) {
        throw ServerException(message: "User is null");
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      log(e.toString());
      throw ServerException(message: "User is null");
    }
  }
}
