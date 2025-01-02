import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_time/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:movie_time/constant.dart';

class RegisterController extends GetxController {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  final isLoading = (false).obs;

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  bool checkInput() {
    return usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        validatePassword() == null;
  }

  String? validatePassword() {
    if (passwordController.text != confirmPasswordController.text) {
      return "Password tidak sesuai";
    } else {
      return null;
    }
  }

  Future register(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
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

    if (response.statusCode == 201) {
      toLogin();
    } else {
      throw Exception('Register Failed');
    }
  }

  onRegister() async {
    try {
      isLoading.value = true;
      await register(usernameController.text, passwordController.text);
    } catch (e) {
      Get.snackbar(
        'Register Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  toLogin() {
    Get.offAndToNamed(Routes.LOGIN);
  }
}
