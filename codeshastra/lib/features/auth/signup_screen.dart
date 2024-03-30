import 'package:codeshastra/features/auth/login_screen.dart';
import 'package:codeshastra/features/auth/signup_controller.dart';
import 'package:codeshastra/utils/constants/colors.dart';
import 'package:codeshastra/utils/constants/sizes.dart';
import 'package:codeshastra/utils/constants/text_conts.dart';
import 'package:codeshastra/utils/helpers/helper_functions.dart';
import 'package:codeshastra/utils/helpers/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(SignupController());

    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title
                      Text(TTexts.signupTitle,
                          style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      /// Form
                      Form(
                          key: controller.signupFormKey,
                          child: Column(children: [
                        Row(children: [
                          // firstName
                          Expanded(
                            child: TextFormField(
                              controller: controller.firstName,
                              validator: (value) => TValidator.validateEmptyText('First Name', value),
                              expands: false,
                              decoration: const InputDecoration(
                                  labelText: TTexts.firstName,
                                  prefixIcon: Icon(Iconsax.user)),
                            ),
                          ),
                          const SizedBox(width: TSizes.spaceBtwInputFields),


                          // LastName
                          Expanded(
                            child: TextFormField(
                              controller: controller.lastName,
                              validator: (value) => TValidator.validateEmptyText('Last Name', value),
                              expands: false,
                              decoration: const InputDecoration(
                                  labelText: TTexts.LastName,
                                  prefixIcon: Icon(Iconsax.user)),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: TSizes.spaceBtwInputFields,
                        ),


                        // Username
                        TextFormField(
                          controller: controller.username,
                          expands: false,
                          decoration: const InputDecoration(
                              labelText: TTexts.username,
                              prefixIcon: Icon(Iconsax.user_edit)),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwInputFields,
                        ),
                        // Email
                        TextFormField(
                          controller: controller.email,
                          validator: (value) => TValidator.validateEmail(value),
                          decoration: const InputDecoration(
                              labelText: TTexts.email,
                              prefixIcon: Icon(Iconsax.direct)),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwInputFields,
                        ),

                        
                        // PhoneNo
                        TextFormField(
                          controller: controller.phoneNumber,
                          validator: (value) => TValidator.validatePhoneNumber(value),
                          expands: false,
                          decoration: const InputDecoration(
                              labelText: TTexts.phoneNo,
                              prefixIcon: Icon(Iconsax.call)),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwInputFields,
                        ),


                        // Password
                        TextFormField(
                          controller: controller.password,
                          validator: (value) => TValidator.validatePassword(value),
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: TTexts.password,
                              prefixIcon: Icon(Iconsax.password_check),
                              suffixIcon: Icon(Iconsax.eye_slash)),
                        ),
                        

                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),

                        // Terms & Conditions
                        TermsAndConditions(dark: dark),
                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),


                        // Sign Up Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => controller.signup(),
                            child: const Text(TTexts.createAccount),
                          ),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),
                        //  Social Button
                        const SocialButtonWidget()
                      ]))
                    ]))));
  }
}

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
        width: 24,
        height: 24,
        child: Checkbox(value: true, onChanged: (value) {}),
      ),
      const SizedBox(
        width: TSizes.spaceBtwItems,
      ),
      Text.rich(TextSpan(children: [
        TextSpan(children: [
          TextSpan(
              text: TTexts.iAgreeTo,
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: TTexts.privacyPolicy,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(
                    color: dark
                        ? TColors.white
                        : TColors.primary,
                        decoration: TextDecoration.underline,
                  )),
          TextSpan(
              text: TTexts.and,
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(children: [
            TextSpan(
                text: " ",
                style:
                    Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: '${TTexts.termsOfUse}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(
                        color: dark
                            ? TColors.white
                            : TColors.primary,
                        decoration:
                            TextDecoration.underline,
                        decorationColor: dark
                            ? TColors.white
                            : TColors.primary)),
          ])
        ])
      ]))
    ]);
  }
}
