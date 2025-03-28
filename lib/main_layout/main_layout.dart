import 'package:falcon_project/main_layout/widgets/my_bottom_bar.dart';
import 'package:falcon_project/modules/members/import/members_module_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;
  List<Widget> modules = [
    MembersModuleScreen(bloc: MembersModuleBloc()),
    Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        toolbarHeight: 70.h,
        // Adjust height to fit the logo and search bar
        title: CircleAvatar(
          radius: 45.r,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(
            'assets/images/falcon_logo.png',
          ), // Replace with your logo
        ),
        actions: [
          IconButton(padding: EdgeInsets.all(15.w),
            onPressed: () {},
            icon: Icon(Icons.menu_rounded, size: 30.r),
          ),
        ],
        centerTitle: true,
      ),
      body: modules[currentIndex],
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r)),
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: MyBottomBar(
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        currentIndex: currentIndex,
      ),
    );
  }
}
