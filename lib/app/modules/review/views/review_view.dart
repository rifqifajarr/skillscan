import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skillscan/app/core/values/app_colors.dart';
import 'package:skillscan/app/utils/border_painter.dart';
import 'package:skillscan/app/utils/scan_animation.dart';

import '../controllers/review_controller.dart';

class ReviewView extends GetView<ReviewController> {
  const ReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          backgroundColor: controller.isLoading.value
              ? AppColors.purpleDark
              : AppColors.purpleLight,
          appBar: controller.isLoading.value
              ? null
              : AppBar(
                  title: Text(
                    'Hasil Review',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.purple,
                      fontSize: 20,
                    ),
                  ),
                  backgroundColor: AppColors.purpleLight,
                  centerTitle: true,
                  toolbarHeight: 64,
                  leading: Container(),
                  shape: Border(
                      bottom: BorderSide(
                    color: AppColors.purple,
                    width: 2,
                  )),
                ),
          body: Obx(
            () {
              return Stack(
                children: [
                  controller.isLoading.value
                      ? buildCvImage(
                          image: controller.cvImage.value ?? XFile(''),
                          animation: controller.animationController
                              as Animation<double>,
                          animationStopped: controller.animationStopped.value,
                        )
                      : buildReviewResult(
                          image: controller.cvImage.value ?? XFile(''),
                          review: controller.review.value,
                        ),
                ],
              );
            },
          ),
          floatingActionButton: controller.isLoading.value
              ? null
              : Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.onBackButtonPressed();
                    },
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                        backgroundColor: AppColors.purple),
                    child: Text(
                      'BACK',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white),
                    ),
                  ),
                ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}

Widget buildCvImage({
  required XFile image,
  required Animation<double> animation,
  required bool animationStopped,
}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: Stack(
        children: [
          CustomPaint(
            foregroundPainter: BorderPainter(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Image.file(
                File(image.path),
                fit: BoxFit.contain,
              ),
            ),
          ),
          ScannerAnimation(
            animationStopped,
            512,
            animation: animation,
          )
        ],
      ),
    ),
  );
}

Widget buildReviewResult({
  required XFile image,
  required String review,
}) {
  return SingleChildScrollView(
    physics: const ClampingScrollPhysics(),
    child: Padding(
      padding: const EdgeInsets.all(23),
      child: Column(
        children: [
          Center(
            child: Image.file(
              File(image.path),
              fit: BoxFit.contain,
              height: 485,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 22, bottom: 40),
            child: MarkdownBody(
              data: review,
              styleSheet: MarkdownStyleSheet(
                h1: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Kadwa',
                ),
                p: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Kadwa',
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
