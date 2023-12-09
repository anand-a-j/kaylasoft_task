// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StudentModel {
  String id;
  String name;
  int age;
  String profileUrl;
  String addedid;

  StudentModel({
    required this.id,
    required this.name,
    required this.age,
    required this.profileUrl,
    required this.addedid
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'profileUrl': profileUrl,
      'addedid': addedid
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'] as String,
      name: map['name'] as String,
      age: map['age'] as int,
      profileUrl: map['profileUrl'] as String,
      addedid: map['addedid'] as String
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentModel.fromJson(String source) =>
      StudentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
