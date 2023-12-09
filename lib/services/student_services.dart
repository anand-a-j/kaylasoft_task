import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:student_management_app/models/student_model.dart';
import 'package:student_management_app/services/auth_services.dart';
import 'package:uuid/uuid.dart';

class StudentServices {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthServices authServices = AuthServices();

  // add new student to the database--------------------------------------------
  Future<String> addStudent(StudentModel student) async {
    String response = '';
    try {
      await _firestore.collection('students').doc().set(student.toMap());

      response = 'success';
      return response;
    } on SocketException {
      response = 'no-internet';
    } catch (e) {
      // print('add student err => ${e.toString()}');
      response = 'fail';
    }
    return response;
  }

  // upload student image to storage--------------------------------------------
  Future<String> uploadImageToStorage(Uint8List file) async {
    String id = const Uuid().v1();

    // put that file into that ref location
    Reference ref = _storage.ref().child('profilePic').child(id);

    // after putting the file a upload task will get
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // get all students-----------------------------------------------------------
  Future<List<StudentModel>> getAllStudents() async {
    List<StudentModel> studentList = [];

    try {
      var snap = await _firestore.collection('students')
          .where('addedid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .get();

      for (var document in snap.docs) {
        Map<String, dynamic> data = document.data();
        StudentModel student = StudentModel.fromMap(data);
        studentList.add(student);
      }
      return studentList;
    } catch (e) {
      return [];
    }
  }
}
