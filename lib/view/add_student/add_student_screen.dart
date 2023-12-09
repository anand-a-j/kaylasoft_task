import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app/controller/student_provider.dart';
import 'package:student_management_app/utils/color.dart';
import 'package:student_management_app/widgets/custom_button.dart';
import 'package:student_management_app/widgets/custom_social_button.dart';
import 'package:student_management_app/widgets/custom_textfield.dart';

class AddStudentScreen extends StatelessWidget {
  static const String routeName = 'add-student-screen';
  const AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Consumer<StudentProvider>(
              builder: (context, studentProvider, _) {
                return Form(
                  key: studentProvider.addStudentFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 120,
                        width: 500,
                        child: Center(
                          child: Text(
                            "Enter Student Details!",
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: kBlack),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () => _pickImage(context),
                        child: studentProvider.image != null
                            ? CircleAvatar(
                                radius: 60,
                                backgroundColor: primaryColor,
                                backgroundImage:
                                    MemoryImage(studentProvider.image!),
                              )
                            : const CircleAvatar(
                                radius: 60,
                                backgroundColor: primaryColor,
                                backgroundImage: AssetImage(
                                  'assets/images/blankprofile.png',
                                ),
                              ),
                      ),
                      const SizedBox(height: 60),
                      CustomTextField(
                        controller: studentProvider.nameController,
                        hintText: 'Name',
                        inputType: TextInputType.name,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        controller: studentProvider.ageController,
                        hintText: 'Age',
                        inputType: TextInputType.number,
                      ),
                      const SizedBox(height: 15),
                      CustomButton(
                        title: "Add Student",
                        onPressed: () {
                          studentProvider.addStudent(context);
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        isLoading: studentProvider.isLoading ? true : false,
                      ),
                      const SizedBox(height: 15),
                      CustomSoicalButton(
                        title: "Cancel",
                        onPressed: () {
                          Navigator.pop(context);
                          studentProvider.disposeValues();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }


  _pickImage(BuildContext context) async {
    final imageSource = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select the image source"),
        actions: [
          ElevatedButton(
            child: const Text("Camera"),
            onPressed: () => Navigator.pop(context, ImageSource.camera),
          ),
          ElevatedButton(
            child: const Text("Gallery"),
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
          ),
        ],
      ),
    );

    if (imageSource != null && context.mounted) {
      context.read<StudentProvider>().setImageSource(imageSource);
    } else {
      return;
    }
  }
}
