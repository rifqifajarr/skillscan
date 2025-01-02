import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_time/app/theme.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: AppGradients.backgroundGradient),
      child: Padding(
        padding: EdgeInsets.all(28),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Profil',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.toHome();
                    },
                    icon: Icon(Icons.home),
                    color: Colors.white,
                    iconSize: 42,
                  )
                ],
              ),
              SizedBox(
                height: 38,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    SizedBox(height: 186),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: 354,
                        height: 96,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.pink,
                            borderRadius: BorderRadius.circular(12)),
                        child: Obx(() {
                          return Text(
                            controller.username.value,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          );
                        }),
                      ),
                    ),
                    Center(
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/profile.jpg',
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 88, right: 88, top: 32),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.onLogout();
                    },
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor:
                          AppColors.purple.withOpacity(0.5),
                      backgroundColor: AppColors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      'Log Out',
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
        ),
      ),
    ));
  }
}
