import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skillscan/app/routes/app_pages.dart';
import 'package:skillscan/app/utils/logging.dart';

class HomeController extends GetxController {
  final cvImage = Rx<XFile?>(null);

  onGetImage() {
    Get.toNamed(Routes.REVIEW, arguments: {'data': cvImage});
  }

  Future<XFile?> pickImageFromGallery() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  Future<void> getImageFromGallery() async {
    final image = await pickImageFromGallery();

    if (image != null) {
      try {
        cvImage.value = image;
        onGetImage();
      } catch (e) {
        log.e('Failed to load image from gallery');
      }
    }
  }
}
