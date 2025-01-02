import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_time/app/data/preferences/session_controller.dart';
import 'package:movie_time/app/data/response/login_response.dart';
import 'package:movie_time/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:movie_time/constant.dart';

class LoginController extends GetxController {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  final sessionController = SessionController();

  final isLoading = (false).obs;

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  bool checkInput() {
    return usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  Future<LoginResponse> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          'password': password,
          'username': username,
        },
      ),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      throw Exception('Invalid username or password');
    } else {
      throw Exception('Login Failed');
    }
  }

  onLogin() async {
    try {
      isLoading.value = true;
      final loginResponse = await login(
        usernameController.text,
        passwordController.text,
      );
      sessionController.saveUserId(loginResponse.userId);
      sessionController.saveUsername(usernameController.text);
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
      Get.offAllNamed(Routes.HOME);
    }
  }

  toRegister() {
    Get.offAndToNamed(Routes.REGISTER);
  }
}
