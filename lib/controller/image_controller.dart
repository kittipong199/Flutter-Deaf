import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  static ImageController get to => Get.find<ImageController>();

  File? image;
  final _picker = ImagePicker();
  var imagePath = ''.obs;
  var isImagePathSet = false.obs;

  Future<String> getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      imagePath.value = pickedFile.path;
      isImagePathSet.value = true;
    } else {
      print('No Image Selected');
      return '';
    }
    update();
    return imagePath.value;
  }
}
