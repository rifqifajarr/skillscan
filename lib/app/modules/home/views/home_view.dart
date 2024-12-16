import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:skillscan/app/core/values/app_colors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/skillscan_logo.png',
              width: 254,
              height: 220,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 43),
              child: ElevatedButton.icon(
                onPressed: () {
                  controller.getImageFromGallery();
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 33, vertical: 21),
                    backgroundColor: AppColors.purple),
                label: const Text(
                  'REVIEW CV',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white),
                ),
                icon: Image.asset(
                  'assets/images/scan_icon.png',
                  width: 28,
                  height: 28,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
