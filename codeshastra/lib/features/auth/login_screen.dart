import 'package:codeshastra/features/auth/login_controller.dart';
import 'package:codeshastra/features/auth/signup_screen.dart';
import 'package:codeshastra/utils/constants/colors.dart';
import 'package:codeshastra/utils/constants/image_strings.dart';
import 'package:codeshastra/utils/constants/sizes.dart';
import 'package:codeshastra/utils/constants/text_conts.dart';
import 'package:codeshastra/utils/helpers/helper_functions.dart';
import 'package:codeshastra/utils/helpers/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: TSpacingstyle.paddingWithAppBarHeight,
                child: Column(children: [
                  // Logo, Title and Subtitle
                  const LoginHeaderWidget(),

                  // Form
                  const LoginFormWidget(),

                  // Divider
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Flexible(
                        child: Divider(
                            color: dark ? TColors.darkGrey : Colors.grey,
                            thickness: 0.5,
                            indent: 60,
                            endIndent: 5)),
                    Text(TTexts.orSignInwith.capitalize!,
                        style: Theme.of(context).textTheme.labelMedium),
                    Flexible(
                        child: Divider(
                            color: dark ? TColors.darkGrey : Colors.grey,
                            thickness: 0.5,
                            indent: 5,
                            endIndent: 60)),
                  ]),

                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  // Footer
                  const SocialButtonWidget()

// decoration: BoxDecoration(border: Border.all(color: TColors.grey), borderRadius: BorderRadius. circular (100)),
                ]))));
  }
}

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
        key: controller.loginFormKey,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
          child: Column(children: [
            // email
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: TTexts.email),
              validator: (value) => TValidator.validateEmail(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => TValidator.validatePassword(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                    labelText: TTexts.password,
                    prefixIcon: const Icon(Iconsax.password_check),
                    // suffixIcon: Icon(Iconsax.eye_slash)),
                    suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye))),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Remember Me
                Row(children: [
                  Obx(() => Checkbox(
                      value: controller.rememberMe.value,
                      onChanged: (value) => controller.rememberMe.value =
                          !controller.rememberMe.value)),
                  const Text(TTexts.rememberMe),
                ]),
                TextButton(
                  onPressed: () {},
                  child: const Text(TTexts.forgetPassword),
                )
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignIn() ,
                child: const Text(TTexts.signIn),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignupScreen()),
                child: const Text(TTexts.createAccount),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
          ]),
        ));
  }
}

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Image(
          image: AssetImage(TImages.darkAppLogo),
          height: 150,
        ),
        Text(
          TTexts.LoginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: TSizes.sm,
        ),
        Text(
          TTexts.LoginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }
}




class SocialButtonWidget extends StatelessWidget {
  const SocialButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        child: IconButton(
          onPressed: () {},
          icon: const Image(
            width: TSizes.iconMd,
            height: TSizes.iconMd,
            image: AssetImage(TImages.google),
          ),
        ),
      ),
      const SizedBox(width: TSizes.spaceBtwItems),
      Container(
        child: IconButton(
          onPressed: () {},
          icon: const Image(
            width: TSizes.iconMd,
            height: TSizes.iconMd,
            image: AssetImage(TImages.facebook),
          ),
        ),
      ),
    ]);
  }
}