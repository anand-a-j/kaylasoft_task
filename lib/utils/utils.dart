import 'package:image_picker/image_picker.dart';

// image picker function
pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();

  XFile? file = await imagePicker.pickImage(source: source);

  if (file != null) {
    return file.readAsBytes();
  }
}
