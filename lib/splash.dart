import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:falcon_project/core/config/ui/assets.dart';
import 'package:falcon_project/core/config/ui/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import 'core/app/routes/pages_routes.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double height = 0;
  double width = 0;
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        height = 350.h;
        width = 350.w;
        // Animate to target height
      });
    });
    Timer(const Duration(seconds: 2), () {
      MaintenanceConfig.instantiate(
        MaintenanceConfig(
          customMessage: AppStrings.appUnavailable.tr(),
          customMessageButton: AppStrings.tryAgain.tr(),
          customMessageRetryToast: AppStrings.retrying.tr(),
        ),
      );
      ApiResponseConfig.instantiate(
        ApiResponseConfig(
          customErrorMessage: AppStrings.errorOccurred.tr(),
          customNetworkIssuesMessage: AppStrings.networkIssueDetected.tr(),
          customRequestTimeoutMessage: AppStrings.requestTimedOut.tr(),
        ),
      );
      NoInternetConfig.instantiate(
        NoInternetConfig(
          customMessage: AppStrings.noInternetMessage.tr(),
          customMessageButton: AppStrings.retry.tr(),
        ),
      );
      context.pushReplacementNamed(PagesRoutes.mainLayout);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Align(
        alignment: Alignment.center,
        child: AnimatedContainer(
          height: height,
          width: width,
          duration: Duration(milliseconds: 700),
          // color: Colors.red,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppAssets.logo),
                Expanded(
                  child: Text(
                    AppStrings.whereChampionsAreMade,
                    style: TextStyle().copyWith(fontSize: 20.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
