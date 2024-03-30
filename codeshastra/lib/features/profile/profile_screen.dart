
import 'package:codeshastra/features/profile/custom_appbar.dart';
import 'package:codeshastra/features/profile/settings.dart';
import 'package:codeshastra/features/profile/tcircular_image.dart';
import 'package:codeshastra/utils/constants/image_strings.dart';
import 'package:codeshastra/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(showBackArrow: true, title: Text('Profile')),

        /// -- Body
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(children: [
            /// Profile Picture
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const TCircularImage(
                      image: TImages.user, width: 80, height: 80),
                  TextButton(
                      onPressed: () {},
                      child: const Text('Change Profile Picture')),
                ],
              ),
            ),

            /// Details
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            const Divider(),
            const SizedBox(height: TSizes.spaceBtwItems),
            const TSectionHeading(
                title: 'Profile Information', showActionButton: false),
            const SizedBox(height: TSizes.spaceBtwItems),
          ]),
        )));
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.onPressed,
    required this.title,
    required this.value,
    this.icon = Iconsax.arrow_right_34,
  });
  final IconData icon;
  final VoidCallback onPressed;
  final String title, value;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: TSizes.spaceBtwItems / 1.5),
            child: Row(children: [
              Expanded(
                  flex: 3,
                  child: Text(title,
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis)),
              Expanded(
                  flex: 5,
                  child: Text(value,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis)),
              Expanded(child: Icon(icon, size: 18)),
            ])));
  }
}
