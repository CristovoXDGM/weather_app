import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/app/features/login/data/params/login_params.dart';

class AuthService {
  final isAuthenticated = ValueNotifier<bool>(false);

  Future<void> logInUser(LoginParams params) async {
    final prefs = await SharedPreferences.getInstance();

    if (params.password.trim() == "123456" && params.userName.trim() == "admin") {
      await prefs.setBool('isAuthenticated', true);
      return;
    }

    await prefs.setBool('isAuthenticated', false);
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', false);
  }

  Future<void> getAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();

    isAuthenticated.value = prefs.getBool("isAuthenticated") ?? false;
  }
}
