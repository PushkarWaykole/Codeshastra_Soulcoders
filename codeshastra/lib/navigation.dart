import 'package:codeshastra/features/charts/aethestic_chart.dart';
import 'package:codeshastra/features/charts/aethetic_char2.dart';
import 'package:codeshastra/features/charts/line_chart.dart';
import 'package:codeshastra/features/charts/linechart_widget.dart';
import 'package:codeshastra/features/ml/camera_classifier.dart';
import 'package:codeshastra/features/profile/settings.dart';
import 'package:codeshastra/utils/constants/colors.dart';
import 'package:codeshastra/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            backgroundColor: darkMode ? TColors.black : Colors.white,
            indicatorColor: darkMode
                ? TColors.white.withOpacity(0.1)
                : TColors.black.withOpacity(0.1),
            destinations: const [
              NavigationDestination(icon: Icon(Iconsax.home), label: 'home'),
              NavigationDestination(icon: Icon(Iconsax.shop), label: 'store'),
              NavigationDestination(
                  icon: Icon(Iconsax.heart), label: 'Wishlist'),
              NavigationDestination(icon: Icon(Iconsax.user), label: 'user'),
            ]),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    // const HomeScreen(),
    // Container(
    //   color: Color.fromARGB(255, 210, 255, 120),
    // ),
     HomePageCharter(),
    LineChartWidget(pricePoints),
    const CameraView(),
    const SettingsScreen(),
  ];
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}