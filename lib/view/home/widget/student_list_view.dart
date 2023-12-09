import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_management_app/controller/home_provider.dart';
import 'package:student_management_app/utils/color.dart';

class StudentListView extends StatelessWidget {
  final HomeProvider homeProvider;
  const StudentListView({super.key, required this.homeProvider});

  @override
  Widget build(BuildContext context) {
    return !homeProvider.isLoading
        ? homeProvider.filteredStudents.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: homeProvider.filteredStudents.length,
                itemBuilder: (context, index) {
                  var student = homeProvider.filteredStudents[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: kGreyShade,
                      backgroundImage: NetworkImage(student.profileUrl),      
                    ),
                    title: Text(student.name),
                    subtitle: Text(student.age.toString()),
                  );
                })
            : const Center(
                child: Text("Student not added\nTap + add students"),
              )
        : const StudentListViewShimmer();
  }
}

class StudentListViewShimmer extends StatelessWidget {
  const StudentListViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xffcccccc),
      highlightColor: const Color(0xffcccccc),
      enabled: true,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 15,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xffcccccc),
            ),
            title: Container(
              height: 18,
              width: 100,
              color: const Color(0xffcccccc),
            ),
            subtitle: Container(
              height: 10,
              width: 100,
              color: const Color(0xffcccccc),
            ),
          );
        },
      ),
    );
  }
}
