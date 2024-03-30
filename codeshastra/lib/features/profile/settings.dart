import 'package:codeshastra/features/profile/custom_appbar.dart';
import 'package:codeshastra/features/profile/profile_screen.dart';
import 'package:codeshastra/features/profile/tcircular_image.dart';
import 'package:codeshastra/utils/constants/colors.dart';
import 'package:codeshastra/utils/constants/image_strings.dart';
import 'package:codeshastra/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        HomeHeaderWidget(
          heighter: 200.0,
            child: Column(
          children: [
            // AppBar
            CustomAppBar(
                title: Text('Account',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: Colors.white))),
            // User Profile
            TUserProfileTile(onPressed: () => Get.to(() => const ProfileScreen()),),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            )
          ],
        )),

        /// -- Body
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// -- Account Settings
              const TSectionHeading(
                  title: 'Account Settings', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSettingsMenuTile(
                  icon: Iconsax.safe_home,
                  title: 'My Addresses',
                  subTitle: 'Set shopping delivery address'),
              const TSettingsMenuTile(
                  icon: Iconsax.shopping_cart,
                  title: 'My Cart',
                  subTitle: 'Add, remove products and move to checkout'),
              const TSettingsMenuTile(
                  icon: Iconsax.bag_tick,
                  title: 'My Orders',
                  subTitle: 'In-progress and Completed Orders'),
              const TSettingsMenuTile(
                  icon: Iconsax.bank,
                  title: 'Bank Account',
                  subTitle: 'Withdraw balance to registered bank account'),
              const TSettingsMenuTile(
                  icon: Iconsax.discount_shape,
                  title: 'My Coupons',
                  subTitle: 'List of all the discounted coupons'),
              const TSettingsMenuTile(
                  icon: Iconsax.notification,
                  title: 'Notifications',
                  subTitle: 'Set any kind of notification message'),
              const TSettingsMenuTile(
                  icon: Iconsax.security_card,
                  title: 'Account Privacy',
                  subTitle: 'Manage data usage and connected accounts'),
              // -- App Settings
              const SizedBox(height: TSizes.spaceBtwSections),
              const TSectionHeading(title: 'App Settings', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSettingsMenuTile(
                  icon: Iconsax.document_upload,
                  title: 'Load Data',
                  subTitle: 'Upload Data to your Cloud Firebase'),

              // With trailing button having the switch button
              TSettingsMenuTile(
                icon: Iconsax.location,
                title: 'Geolocation',
                subTitle: 'Set recommendation based on location',
                trailing: Switch(value: true, onChanged: (value) {}),
              ), 
              TSettingsMenuTile(
                icon: Iconsax.security_user,
                title: 'Safe Mode',
                subTitle: 'Search result is safe for all ages',
                trailing: Switch(value: false, onChanged: (value) {}),
              ), 
              TSettingsMenuTile(
                icon: Iconsax.image,
                title: 'HD Image Quality',
                subTitle: 'Set image quality to be seen',
                trailing: Switch(value: false, onChanged: (value) {}),
              ), 



              /// -- Logout Button
              const SizedBox(height: TSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {}, child: const Text('Logout')),
              ),
              const SizedBox(height: TSizes.spaceBtwSections * 2.5),
            ],
          ),
        )
      ]),
    ));
  }
}

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key, this.onPressed,
  });
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const TCircularImage(
          image: TImages.user, width: 50, height: 50, padding: 0),
      title: Text('Sarvagya',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: Colors.white)),
      subtitle: Text('sarvagya1947@gmail.com',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: TColors.white)),
      trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(Iconsax.edit, color: Colors.white)),
    );
  }
}

class TSettingsMenuTile extends StatelessWidget {
  const TSettingsMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.trailing,
    this.onTap,
  });
  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 28, color: TColors.primary),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(subTitle, style: Theme.of(context).textTheme.labelMedium),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class TSectionHeading extends StatelessWidget {
  const TSectionHeading({
    super.key,
    this.onPressed,
    this.textColor,
    this.buttonTitle = 'View all',
    required this.title,
    this.showActionButton = true,
  });
  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitle;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: textColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis), // Text
        if (showActionButton)
          TextButton(onPressed: onPressed, child: Text(buttonTitle))
      ],
    );
  }
}


class HomeHeaderWidget extends StatelessWidget {
  final heighter;
  const HomeHeaderWidget({
    super.key,
    required this.child,
    this.heighter = 400.0
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CustomCurvedEdgesWidget(
      child: SizedBox(
        height: heighter,
        child: Container(
          color: TColors.primary,
          child: Stack(children: [
            Positioned(
                top: -150,
                right: -250,
                child: CircularWidget(
                  backgroundColor: TColors.textWhite.withOpacity(0.1),
                )),
            Positioned(
                top: 100,
                right: -300,
                child: CircularWidget(
                  backgroundColor: TColors.textWhite.withOpacity(0.1),
                )),
            child,
          ]),
        ),
      ),
    );
  }
}

class CustomCurvedEdgesWidget extends StatelessWidget {
  const CustomCurvedEdgesWidget({super.key, this.child});

  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: CustomCurvedEdges(), child: child);
  }
}


class CustomCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height);
    final firstCurve = Offset(0, size.height - 20);
    final lastCurve = Offset(30, size.height - 20);
    path.quadraticBezierTo(
        firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);

    final secondFirstCurve = Offset(0, size.height - 20);
    final secondLastCurve = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(secondFirstCurve.dx, secondFirstCurve.dy,
        secondLastCurve.dx, secondLastCurve.dy);

    final thirdFirstCurve = Offset(size.width, size.height - 20);
    final thirdLastCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdFirstCurve.dx, thirdFirstCurve.dy,
        thirdLastCurve.dx, thirdLastCurve.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}



class CircularWidget extends StatelessWidget {
  const CircularWidget({
    super.key,
    this.child,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.padding = 0,
    this.backgroundColor = TColors.white, this.margin,
  });

  final double? width;
  final double? height;
  final double? radius;
  final double padding;
  final EdgeInsets? margin;
  final Widget? child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: TColors.primary,
      padding: const EdgeInsets.all(0),
      child: Stack(children: [
        Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(400),
            color: TColors.textWhite.withOpacity(0.1),
          ),
        )
      ]),
    );
  }
}