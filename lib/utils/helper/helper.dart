

class AppHelper {
  // static CancelFunc showCustomLoading(cancelFunc) {
  //    BotToast.showCustomLoading(
  //     toastBuilder: (func) {
  //       cancelFunc = func;
  //       return Center(
  //         child: Stack(
  //           alignment: Alignment.center,
  //           children: [
  //             Container(
  //               // Full-screen overlay
  //               width: double.infinity,
  //               height: double.infinity,
  //               color: Colors.black54,
  //             ),
  //             Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Image.asset(
  //                   "assets/images/falcon_logo.png",
  //                   fit: BoxFit.cover,
  //                   height: 200.h,
  //                 ),
  //                 SizedBox(
  //                   width: 80.w,
  //                   child: LinearProgressIndicator(color: Colors.red),
  //                 ),
  //                 // Custom color
  //               ],
  //             ),
  //           ],
  //         ),
  //       );
  //
  //     },
  //     backgroundColor: Colors.transparent, // Remove default overlay
  //     allowClick: false, // Prevent taps
  //   );
  //    return cancelFunc;
  //
  // }

  static String? validateNotEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "";
    }
    return null;
  }


}
