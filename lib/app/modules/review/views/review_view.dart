import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_time/app/theme.dart';

import '../controllers/review_controller.dart';

class ReviewView extends GetView<ReviewController> {
  const ReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(gradient: AppGradients.backgroundGradient),
          child: Obx(() {
            return controller.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.pink,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Review',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Apa pendapatmu tentang film ini?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 24),
                        Center(
                          child: Container(
                            width: 172,
                            height: 262,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                controller.image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            controller.movieName,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Rating: ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Obx(() {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Buruk',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              ToggleButtons(
                                isSelected: List.generate(
                                  5,
                                  (index) =>
                                      index == controller.selectedIndex.value,
                                ),
                                onPressed: (int index) {
                                  controller.selectIndex(index);
                                },
                                color: Colors.transparent,
                                borderColor: Colors.white,
                                selectedBorderColor: Colors.white,
                                fillColor: controller.getColor(),
                                borderRadius: BorderRadius.circular(8),
                                children: List.generate(
                                  5,
                                  (index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      child: Text(
                                        '${index + 1}',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Text(
                                'Baik',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          );
                        }),
                        SizedBox(height: 12),
                        Text(
                          'Review: ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          child: TextField(
                            controller: controller.reviewController,
                            maxLines: 4,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(22, 12, 22, 12),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.only(left: 88, right: 88),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: controller.checkInput()
                                  ? () {
                                      controller.onSubmit();
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
                                'Submit',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
