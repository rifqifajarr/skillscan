import 'package:get/get.dart';
import 'package:movie_time/app/data/preferences/session_controller.dart';
import 'package:movie_time/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  final sessionController = SessionController();
  final username = ('').obs;

  @override
  void onInit() {
    super.onInit();
    getUsername();
  }

  Future<void> getUsername() async {
    username.value = await sessionController.getUsername() ?? '';
  }

  toHome() {
    Get.toNamed(Routes.HOME);
  }

  onLogout() {
    sessionController.clearSession();
    Get.offAllNamed(Routes.HOME);
  }
}
