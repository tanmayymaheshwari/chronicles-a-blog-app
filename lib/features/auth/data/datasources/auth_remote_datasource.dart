import 'dart:developer';

import 'package:chronicles/core/error/exceptions.dart';
import 'package:chronicles/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Session? get currentUserSession;

  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabaseClient;

  AuthRemoteDatasourceImpl({required this.supabaseClient});

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient.from('profiles').select().eq(
              'id',
              currentUserSession!.user.id,
            ); // 'from' directly connects to the database
        return UserModel.fromJson(userData.first).copyWith(
          email: currentUserSession!.user.email,
          // since email is not stored in the database
        );
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      // signInWithPassword method from package
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw ServerException("User is null!");
      }
      // return UserModel.fromJson(response.user!.toJson());
      return UserModel.fromJson(response.user!.toJson()).copyWith(
          email: currentUserSession!.user.email,
      );
    } catch (e) {
      log(e.toString());
      throw ServerException("User is null");
    }
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
        throw ServerException("User is null");
      }
      // return UserModel.fromJson(response.user!.toJson());
      return UserModel.fromJson(response.user!.toJson()).copyWith(
          email: currentUserSession!.user.email,
      );
    } catch (e) {
      log(e.toString());
      throw ServerException("User is null");
    }
  }
}
