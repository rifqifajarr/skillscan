import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_time/app/theme.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: AppGradients.backgroundGradient,
          ),
          child: Obx(() {
            return controller.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.pink,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Container(height: 96),
                        Center(
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 105,
                          ),
                        ),
                        Container(height: 48),
                        Padding(
                          padding: const EdgeInsets.only(left: 42, right: 42),
                          child: TextField(
                            controller: controller.usernameController,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Username',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              filled: true,
                              fillColor: AppColors.grey.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                              contentPadding:
                                  EdgeInsets.only(left: 22, right: 22),
                            ),
                          ),
                        ),
                        Container(height: 12),
                        Padding(
                          padding: const EdgeInsets.only(left: 42, right: 42),
                          child: TextField(
                            controller: controller.passwordController,
                            obscureText: true,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              filled: true,
                              fillColor: AppColors.grey.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                              contentPadding:
                                  EdgeInsets.only(left: 22, right: 22),
                            ),
                          ),
                        ),
                        Container(height: 48),
                        Padding(
                          padding: const EdgeInsets.only(left: 88, right: 88),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: controller.checkInput()
                                  ? () {
                                      controller.onLogin();
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                disabledBackgroundColor:
                                    AppColors.purple.withOpacity(0.5),
                                backgroundColor: AppColors.purple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Belum punya akun?",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.toRegister();
                              },
                              child: Text(
                                "Daftar Sekarang!",
                                style: TextStyle(
                                  color: AppColors.pink,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
