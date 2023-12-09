import 'package:flutter/material.dart';
import 'package:student_management_app/models/student_model.dart';
import 'package:student_management_app/services/student_services.dart';

class HomeProvider extends ChangeNotifier {
  final StudentServices _studentServices = StudentServices();

  bool _isLoading = false;
  List<StudentModel> _allStudents = [];
  List<StudentModel> _filteredStudents = [];
  RangeValues _rangeValues = const RangeValues(0, 50);
  final TextEditingController _searchController = TextEditingController();

  bool get isLoading => _isLoading;
  List<StudentModel> get allStudents => _allStudents;
  List<StudentModel> get filteredStudents => _filteredStudents;
  RangeValues get rangeValues => _rangeValues;
  TextEditingController get searchController => _searchController;

  setRangeValues(RangeValues range) {
    _rangeValues = range;
    updateFilteredStudents();
    notifyListeners();
  }

  updateFilteredStudents() {
    List<StudentModel> filteredStudents = _allStudents
        .where((student) =>
            _rangeValues.start <= student.age &&
            student.age <= _rangeValues.end)
        .toList();

    // search filter
    String searchValue = _searchController.text.toLowerCase().trim();
    if (searchValue.isNotEmpty) {
      filteredStudents = filteredStudents
          .where((student) => student.name.toLowerCase().contains(searchValue))
          .toList();
    }

    _filteredStudents = filteredStudents;
    notifyListeners();
  }

  // fetch all students from database--------------------------------------------
  getAllStudents() async {
    _isLoading = true;
    notifyListeners();

    var data = await _studentServices.getAllStudents();
    print(data);
    _allStudents = data;
    updateFilteredStudents();

    _isLoading = false;
    notifyListeners();
  }
}
