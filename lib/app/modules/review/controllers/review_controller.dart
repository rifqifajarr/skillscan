import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skillscan/app/routes/app_pages.dart';
import 'package:skillscan/app/utils/logging.dart';

class ReviewController extends GetxController
    with SingleGetTickerProviderMixin {
  Rx<XFile?> cvImage = Get.arguments['data'];
  final isLoading = true.obs;

  late AnimationController animationController;
  RxBool animationStopped = false.obs;

  final review = "".obs;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animateScanAnimation(reverse: true);
      } else if (status == AnimationStatus.dismissed) {
        animateScanAnimation(reverse: false);
      }
    });

    if (isLoading.value) {
      animationController.repeat(reverse: true);
    } else {
      animationController.dispose();
    }

    getReview();
  }

  void animateScanAnimation({required bool reverse}) {
    if (reverse) {
      animationController.reverse(from: 1.0);
    } else {
      animationController.reverse(from: 0.0);
    }
  }

  onBackButtonPressed() {
    Get.offAndToNamed(Routes.HOME);
  }

  Future getReview() async {
    final GenerativeModel model = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: dotenv.env['GEMINI_API_KEY'] ?? 'API key not found',
    );

    Future<DataPart> fileToPart(String mimeType, String path) async {
      return DataPart(mimeType, await File(path).readAsBytes());
    }

    final prompt =
        'analisa cv berikut dengan format kelebihan, kekurangan, dan rekomendasi. tidak perlu menambahkan kata-kata tambahan diluar format tersebut';
    final image = await fileToPart('image/png', cvImage.value?.path ?? '');

    try {
      final response = await model.generateContent([
        Content.multi([TextPart(prompt), image])
      ]);
      review.value = response.text ?? '';
    } catch (e) {
      log.e("Error during getting response: $e");
      review.value = "Failed to get response.";
    } finally {
      isLoading.value = false;
      animationController.stop();
    }
  }
}
