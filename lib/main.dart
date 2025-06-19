import 'package:coffeeshop/auth/controllers/auth_controller.dart';
import 'package:coffeeshop/auth/pages/auth_screen.dart';
import 'package:coffeeshop/auth/pages/get_started_screen.dart';
import 'package:coffeeshop/auth/pages/register_screen.dart';
import 'package:coffeeshop/auth/pages/sign_in_screen.dart';
import 'package:coffeeshop/auth/pages/phone_auth_screen.dart';
import 'package:coffeeshop/home/controller/favorite_controller.dart';
import 'package:coffeeshop/home/pages/favorite_screen.dart';
import 'package:coffeeshop/home/pages/home_page.dart';
import 'package:coffeeshop/home/pages/home_screen.dart';
import 'package:coffeeshop/home/pages/location_screen.dart';
import 'package:coffeeshop/home/pages/profile_screen.dart';
import 'package:coffeeshop/home/pages/shopping_cart_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(Phoenix(child: const MyApp()));
  if (FirebaseAuth.instance.currentUser != null) {
    await Get.find<FavoriteController>().fetchFavorites();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: const GetStartedScreen(),
        initialRoute: '/',
        getPages: [
          GetPage(
              name: '/',
              page: () => HomeScreen()), // binding: HomeController()),
          GetPage(name: '/home', page: () => HomeScreen()),
          GetPage(name: '/getstarted', page: () => const GetStartedScreen()),
          GetPage(name: '/signin', page: () => SignInScreen()),
          GetPage(name: '/register', page: () => RegisterScreen()),
          GetPage(name: '/auth', page: () => AuthScreen()),
          GetPage(name: '/phone', page: () => PhoneAuthScreen()),
          GetPage(name: '/homepage', page: () => HomePage()),
          GetPage(name: '/favorite', page: () => FavoriteScreen()),
          GetPage(name: '/location', page: () => const LocationScreen()),
          GetPage(name: '/profile', page: () => ProfileScreen()),
          GetPage(name: '/cart', page: () => const ShoppingCartScreen()),
          // Add more routes as needed
        ],
      ),
    );
  }
}
