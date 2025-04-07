import 'package:falcon_project/core/constants/my_assets.dart';
import 'package:falcon_project/core/routes/pages_routes.dart';
import 'package:falcon_project/main_layout/widgets/my_bottom_bar.dart';
import 'package:falcon_project/modules/analytics/import/analytics_module_import.dart';
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
  MembersModuleBloc membersBloc = MembersModuleBloc();

  bool get isAnalyticsScreenActive => currentIndex == 1;

  List<Widget> get modules =>
      [
        AllMembersScreen(bloc: membersBloc), // Always stays alive
        isAnalyticsScreenActive
            ? AnalyticsScreen(
            bloc: AnalyticsModuleBloc(MembersModuleBloc.allMembers))
            : const SizedBox.shrink(), // Released when not active
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        toolbarHeight: 70.h,
        title: CircleAvatar(
          radius: 45.r,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(MyAssets.logo), // Replace with your logo
        ),
        centerTitle: true,
      ),
      body: IndexedStack(
          index: currentIndex,
          children: modules),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        onPressed: () {
          context.pushNamed(PagesRoutes.addMember);
        },
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
