import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_time/app/data/preferences/session_controller.dart';
import 'package:movie_time/app/routes/app_pages.dart';
import 'package:movie_time/app/theme.dart';
import 'package:http/http.dart' as http;
import 'package:movie_time/constant.dart';

class ReviewController extends GetxController {
  final image = Get.arguments['image'];
  final movieId = Get.arguments['id'];
  final movieName = Get.arguments['name'];
  int? userId = 0;
  final selectedIndex = (-1).obs;

  var reviewController = TextEditingController();

  final sessionController = SessionController();

  final isLoading = (false).obs;

  Future submitReview(
      int movieId, String review, int rating, int userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/giverating'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, dynamic>{
          'comment': review,
          'movie_id': movieId,
          'rating': rating,
          'user_id': userId
        },
      ),
    );

    if (response.statusCode == 201) {
      sessionController.changeStartedStatus();
      isLoading.value = false;
      Get.offAllNamed(Routes.HOME);
    } else {
      throw Exception('Failed to add data');
    }
  }

  onSubmit() async {
    try {
      isLoading.value = true;
      await submitReview(
          movieId, reviewController.text, selectedIndex.value + 1, userId ?? 0);
    } catch (e) {
      Get.snackbar(
        'Failed to add review',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    }
  }

  selectIndex(int index) {
    selectedIndex.value = index;
  }

  Color getColor() {
    switch (selectedIndex.value) {
      case 0:
        return AppColors.red;
      case 1:
        return AppColors.orange;
      case 2:
        return AppColors.yellow;
      case 3:
        return AppColors.lightGreen;
      case 4:
        return AppColors.green;
      default:
        return Colors.white;
    }
  }

  bool checkInput() {
    return reviewController.text.isNotEmpty && selectedIndex.value != -1;
  }

  @override
  void onClose() {
    reviewController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    getUserId();
  }

  Future getUserId() async {
    userId = await sessionController.getUserId();
  }
}
