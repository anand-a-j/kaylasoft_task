import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management_app/controller/home_provider.dart';
import 'package:student_management_app/models/student_model.dart';
import 'package:student_management_app/services/student_services.dart';
import 'package:student_management_app/utils/utils.dart';
import 'package:student_management_app/view/home/home_screen.dart';
import 'package:uuid/uuid.dart';

class StudentProvider extends ChangeNotifier {
  final StudentServices _studentServices = StudentServices();
  final HomeProvider homeProvider = HomeProvider();

  bool _isLoading = false;
  final _addStudentFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  ImageSource? _imageSource;
  Uint8List? _image;

  bool get isLoading => _isLoading;
  get addStudentFormKey => _addStudentFormKey;
  TextEditingController get nameController => _nameController;
  TextEditingController get ageController => _ageController;
  ImageSource? get imageSource => _imageSource;
  Uint8List? get image => _image;

  setImageSource(ImageSource imageSource) {
    _imageSource = imageSource;
    selectImage();
  }

  void selectImage() async {
    Uint8List? image = await pickImage(_imageSource!);

    if (image != null) {
      _image = image;
    } else {
      Fluttertoast.showToast(msg: 'Image not selected!');
    }
    notifyListeners();
  }

  uploadImage(Uint8List image) async {
    var response = await _studentServices.uploadImageToStorage(image);
    return response;
  }

  addStudent(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    if (_image != null) {
      if (addStudentFormKey.currentState!.validate()) {
        String imageUrl = await uploadImage(_image!);
        String uid = const Uuid().v1();

        StudentModel student = StudentModel(
          id: uid,
          name: _nameController.text.trim(),
          age: int.parse(_ageController.text),
          profileUrl: imageUrl,
          addedid: FirebaseAuth.instance.currentUser?.uid??"",
        );

        var response = await _studentServices.addStudent(student);

        if (response == 'success') {
          // await homeProvider.getAllStudents();
          if (context.mounted) {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
          }

          Fluttertoast.showToast(msg: 'student added sucessfully');
          disposeValues();
        } else {
          Fluttertoast.showToast(msg: 'Something went wrong!!!');
        }
      }

      _isLoading = false;
      notifyListeners();
    } else {
      _isLoading = false;
      Fluttertoast.showToast(msg: 'Image not selected!!!');
      notifyListeners();
    }
  }

  disposeValues() {
    _image = null;
    _nameController.clear();
    _ageController.clear();
  }
}
