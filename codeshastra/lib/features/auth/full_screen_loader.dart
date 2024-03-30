import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A utility class for managing a full-screen loading dialog.
class TFullScreenLoader {
  /// Open a full-screen loading dialog with a given text and animation.
  /// This method doesn't return anything.
  /// Parameters:
//  text: The text to be displayed in the loading dialog.
  /// - animation: The Lottie animation to be shown.
  static void openLoadingDialog(String text, String animation) {
    if (kDebugMode) {
      print("hellow debug dialog loading");
    }
    showDialog(
              context: Get.overlayContext!,
              barrierDismissible: false, // Dialog cannot be dismissed by tapping outside
              builder: (context) => const LoadingDialog(text: 'Loading...'),
            );
//     showDialog(
//         context:
//             Get.overlayContext!, // Use Get.overlayContext for overlay dialogs
//         barrierDismissible:
//             false, // The dialog can't be dismissed by tapping outside it
//         builder: (_) => WillPopScope(
//               child: Container(
//                 color: THelperFunctions.isDarkMode(Get.context!)
//                     ? TColors.dark
//                     : TColors.white,
//                 width: double.infinity,
//                 height: double.infinity,
//                 child: Column(children: [
//                   const SizedBox(height: 250), // Adjust the spacing as needed
//                   TAnimationLoaderWidget(text: text, animation: animation),
//                 ]),
//               ),
//               onWillPop: () async {
//                 // your logic
//                 if (kDebugMode) {
//                   print("will pop scope");
//                 }
//                 return false;
//               },
//             )
// // builder: (_) => PopScope(
// // canPop: false, // Disable popping with the back button
// // child: Container(
// // color: THelperFunctions.isDarkMode(Get.context!) ? TColors.dark : TColors.white,
// // width: double.infinity,
// // height: double. infinity,
// // child: Column (
// // children: [
// // const SizedBox(height: 250), // Adjust the spacing as needed
// // // AnimationLoaderWidget(text: text, animation: animation),
// // ]
// // ) ,
// // ),
// // ),

//         );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}

class LoadingDialog extends StatelessWidget {
  final String text;

  const LoadingDialog({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(), // Loading indicator
          const SizedBox(height: 16),
          Text(text), // Text to display loading message
        ],
      ),
    );
  }
}