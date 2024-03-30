import 'package:codeshastra/features/onboarding/onboarding_controller.dart';
import 'package:codeshastra/utils/constants/colors.dart';
import 'package:codeshastra/utils/constants/image_strings.dart';
import 'package:codeshastra/utils/constants/sizes.dart';
import 'package:codeshastra/utils/constants/text_conts.dart';
import 'package:codeshastra/utils/helpers/device_check.dart';
import 'package:codeshastra/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingScreen extends StatelessWidget {
  const BoardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
        body: Stack(children: [
      /// Horizontal Scrollable Pages
      PageView(
        controller: controller.pageController,
        onPageChanged: controller.updatePageIndicator,
        children: const [
          OnBoardingScreen(
            image: TImages.onBoardingImagel,
            title: TTexts.onBoardingTitle1,
            subtitle: TTexts.onBoardingSubTitle1,
          ),
          OnBoardingScreen(
            image: TImages.onBoardingImage2,
            title: TTexts.onBoardingTitle2,
            subtitle: TTexts.onBoardingSubTitle2,
          ),
          OnBoardingScreen(
            image: TImages.onBoardingImage3,
            title: TTexts.onBoardingTitle3,
            subtitle: TTexts.onBoardingSubTitle3,
          )
        ],
      ),

      /// Skip Button
      const OnBoardingSkip(),

      /// Dot Navigation SmoothPageIndicator
      const OnBoardingNavigation(),

      /// Circular Button
      const OnBoardingNextButton()
    ]));
  }
}

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
        right: TSizes.defaultSpace,
        bottom: TDeviceUtils.getBottomNavigationBarHeight(),
        child: ElevatedButton(
            onPressed: () => OnBoardingController.instance.nextPage(),
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: dark ? TColors.primary : Colors.black),
            child: const Icon(Iconsax.arrow_right_3)));
  }
}

class OnBoardingNavigation extends StatelessWidget {
  const OnBoardingNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = OnBoardingController.instance;

    return Positioned(
        bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
        left: TSizes.defaultSpace,
        child: SmoothPageIndicator(
            // controller: PageController(),
            count: 3,
            controller: controller.pageController,
            onDotClicked: controller.dotNavigationClick,
            effect: ExpandingDotsEffect(
                activeDotColor: dark ? TColors.light : TColors.dark,
                dotHeight: 6)));
  }
}

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: TDeviceUtils.getAppBarHeight(),
        right: TSizes.defaultSpace,
        child: TextButton(
          onPressed: () => OnBoardingController.instance.skipPage(),
          child: const Text('Skip'),
        ));
  }
}

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          Image(
              width: THelperFunctions.screenWidth()*0.7,
              height: THelperFunctions.screenHeight()*0.7,
              image: AssetImage(image)),
          Text(title,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center),
          const SizedBox(height: TSizes.spaceBtwItems),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
