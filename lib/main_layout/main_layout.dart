import 'package:falcon_project/main_layout/widgets/my_bottom_bar.dart';
import 'package:falcon_project/modules/members/import/members_module_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

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
        scrolledUnderElevation: 0,
        elevation: 0,
        toolbarHeight: 70.h,
        // Adjust height to fit the logo and search bar
        backgroundColor: context.colorScheme.secondary,
        title: CircleAvatar(
          radius: 45.r,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(
            'assets/images/falcon_logo.png',
          ), // Replace with your logo
        ),
        centerTitle: true,
      ),
      body: modules[currentIndex],
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        mini: false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: context.colorScheme.primary,
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
