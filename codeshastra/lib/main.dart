import 'package:codeshastra/bindings/general_bindings.dart';
import 'package:codeshastra/features/auth/authentication_repository.dart';
import 'package:codeshastra/firebase_options.dart';
import 'package:codeshastra/navigation.dart';
import 'package:codeshastra/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


Future<void> main() async {
  // Todo: Add Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Todo: Init Local Storage
  await GetStorage.init();
  // Todo: Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Todo: Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
    (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );
  // Todo: Initialize Authentication
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      // theme: ThemeData(
      //   textTheme:
      //       const TextTheme(bodyLarge: TextStyle(fontSize: 24, color: Colors.green)),
      // ),
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      debugShowCheckedModeBanner: false,
      // home: const BoardingScreen(),
      home: const NavigationMenu(),
      // home: const VerifyEmailScreen(),
    );
  }
}
