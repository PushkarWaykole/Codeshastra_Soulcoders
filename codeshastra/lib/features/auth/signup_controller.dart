import 'package:codeshastra/features/auth/authentication_repository.dart';
import 'package:codeshastra/features/auth/login_screen.dart';
import 'package:codeshastra/features/auth/user_model.dart';
import 'package:codeshastra/features/auth/user_repository.dart';
import 'package:codeshastra/utils/constants/loaders.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find(); // mainly to save the mem
  /*
    use the Get.put() method to create the instance and that will stay in the mem
    then use the find() method to use that instance rather than creating a new one.  
  */

  /// Variables
  /// Rx value needs .value
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController(); // Controller for email input
  final lastName = TextEditingController(); // Controller for last name input
  final username = TextEditingController(); // Controller for username input
  final password = TextEditingController(); // Controller for password input
  final firstName = TextEditingController(); // Controller for first name input
  final phoneNumber =
      TextEditingController(); // Controller for phone number input
  // GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();

  void signup() async {
    try {
      // signupFormKey.currentState!.validate();
      // Start Loading
      // TFullScreenLoader.openLoadingDialog('We are processing your information...',TImages.docerAnimation);
      // Check Internet Connectivity
      // final isConnected = await NetworkManager.instance.isConnected();
      // if (!isConnected) return;
      // if(kDebugMode) {
      //   print('signup page had runned');
      //   print(isConnected);
      // }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) return;

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.');
        return;
      }

      // Register user in the Firebase Authentication & Save user data in the Firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());
// Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '');

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // TFullScreenLoader.stopLoading();
      // Show Success Message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! Verify email to continue.');
      // Get.to(() => const VerifyEmailScreen());
      Get.to(() => const LoginScreen());
    } catch (e) {}
  }
}
