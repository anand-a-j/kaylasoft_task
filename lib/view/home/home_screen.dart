import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app/controller/auth_provider.dart';
import 'package:student_management_app/controller/home_provider.dart';
import 'package:student_management_app/utils/color.dart';
import 'package:student_management_app/view/add_student/add_student_screen.dart';
import 'package:student_management_app/view/home/widget/student_list_view.dart';
import 'widget/range_slider.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).getAllStudents();
    });

    return SafeArea(
      child: Consumer<HomeProvider>(builder: (context, homeProvider, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: searchBar(homeProvider),
            actions: [
              logoutButton(context),
            ],
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: RangeSliderWidget(),
            ),
          ),
          body: StudentListView(homeProvider: homeProvider),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddStudentScreen.routeName);
              homeProvider.searchController.clear();
            },
            backgroundColor: primaryColor,
            child: const Icon(Icons.add),
          ),
        );
      }),
    );
  }

  Container logoutButton(BuildContext context) {
    BoxDecoration decoration = BoxDecoration(
        color: Colors.red.shade400,
        border: Border.all(
            color: const Color.fromARGB(255, 200, 200, 200), width: 0.7),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffcccccc),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ]);

    return Container(
      margin: const EdgeInsets.only(top: 5, left: 10, right: 5),
      width: 50,
      height: 50,
      decoration: decoration,
      child: IconButton(
        onPressed: () {
          Provider.of<HomeProvider>(context, listen: false)
              .searchController
              .clear();
          Provider.of<AuthProvider>(context, listen: false).signOut(context);
        },
        icon: const Icon(Icons.logout),
      ),
    );
  }

  Container searchBar(HomeProvider homeProvider) {
    BoxDecoration decoration = BoxDecoration(
      color: bgColor,
      border: Border.all(
          color: const Color.fromARGB(255, 200, 200, 200), width: 0.7),
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Color(0xffcccccc),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ],
    );

    return Container(
      margin: const EdgeInsets.only(top: 5, left: 10, right: 70),
      padding: const EdgeInsets.only(left: 10),
      width: double.infinity,
      height: 50,
      decoration: decoration,
      child: TextField(
        controller: homeProvider.searchController,
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.search),
          hintText: "Search here...",
          border: InputBorder.none,
        ),
        onChanged: (value) {
          homeProvider.updateFilteredStudents();
        },
      ),
    );
  }
}
