import 'package:codeshastra/features/auth/authentication_repository.dart';
import 'package:codeshastra/features/auth/full_screen_loader.dart';
import 'package:codeshastra/navigation.dart';
import 'package:codeshastra/utils/constants/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  // Variables
  final rememberMe = false.obs;
  final hidePassword = false.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  // GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    if(localStorage.read('REMEMBER_ME_EMAIL')!=null) {
      email.text = localStorage.read('REMEMBER_ME_EMAIL');
      password.text = localStorage.read('REMEMBER_ME_PASSWORD');
    }
    super.onInit();
  }

  /// -- Email and Password SignIn
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      // TFullScreenLoader.openLoadingDialog('Logging you in...', TImages.docerAnimation);
      // Check Internet Connectivity
      // final isConnected = await NetworkManager.instance.isConnected;
      // if (!isConnected) {
      // TFullScreenLoader.stopLoading();
      // return;
      // }
      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Save Data if Remember Me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }
      // Login user using EMail & Password Authentication
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      // Remove Loader
      TFullScreenLoader.stopLoading();
      // Redirect
      // AuthenticationRepository.instance.screenRedirect();
      Get.to(() => const NavigationMenu());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: '0h Snap', message: e.toString());
    }
  }
}
