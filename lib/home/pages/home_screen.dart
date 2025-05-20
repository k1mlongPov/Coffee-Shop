import 'package:coffeeshop/auth/controller/auth_controller.dart';
import 'package:coffeeshop/home/controller/bottom_nav_controller.dart';
import 'package:coffeeshop/home/controller/cart_controller.dart';
import 'package:coffeeshop/home/controller/search_controller.dart';
import 'package:coffeeshop/home/pages/favorite_screen.dart';
import 'package:coffeeshop/home/pages/home_page.dart';
import 'package:coffeeshop/home/pages/location_screen.dart';
import 'package:coffeeshop/home/pages/profile_screen.dart';
import 'package:coffeeshop/home/widgets/reusable_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatelessWidget {
  final BottomNavController navController = Get.put(BottomNavController());
  final SearchBarController searchController = Get.put(SearchBarController());
  final CartController cartController = Get.put(CartController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            AuthController.instance.signOutUser();
          },
          icon: const Icon(
            Icons.logout_rounded,
          ),
        ),
        actions: [
          IconButton(
            icon: Obx(
              () => Icon(
                searchController.isExpanded.value ? null : Icons.search,
                size: 20,
              ),
            ),
            onPressed: searchController.toggleSearch, // Correctly toggle search
          ),
        ],
        backgroundColor: brownColor,
      ),
      backgroundColor: whiteColor,
      body: Obx(() => pages[navController.selectedIndex.value]),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        height: 85,
        color: brownColor,
        notchMargin: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                bottomAppBarItems(
                  context,
                  Icons.home,
                  Icons.home_outlined,
                  0,
                  'Home',
                ),
                bottomAppBarItems(
                  context,
                  Icons.favorite,
                  Icons.favorite_border,
                  1,
                  'Favorite',
                ),
                bottomAppBarItems(
                  context,
                  Icons.location_on_rounded,
                  Icons.location_on_outlined,
                  2,
                  'Location',
                ),
                bottomAppBarItems(
                  context,
                  Icons.person_2_rounded,
                  Icons.person_4_outlined,
                  3,
                  'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: brownColor,
          onPressed: () {
            Get.toNamed('/cart');
          },
          child: badges.Badge(
            badgeContent: Text(
              '${cartController.cartItems.length}',
              style: const TextStyle(
                color: whiteColor,
              ),
            ),
            badgeStyle: const badges.BadgeStyle(
              badgeColor: Colors.brown,
              padding: EdgeInsets.all(6),
              elevation: 0,
            ),
            child: const Icon(
              Icons.shopping_cart,
              color: whiteColor,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomAppBarItems(BuildContext context, IconData outLineIcon,
      IconData icon, int page, String label) {
    return ZoomTapAnimation(
      onTap: () => navController.changeTabIndex(page),
      child: navController.selectedIndex.value == page
          ? SizedBox(
              width: 90.w,
              height: 70.h,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                        size: 24.w,
                        navController.selectedIndex.value == page
                            ? outLineIcon
                            : icon,
                        color: whiteColor.withOpacity(1)),
                    SizedBox(
                      width: 5.w,
                    ),
                    reusableTxt(label, whiteColor, 12.sp, FontWeight.bold),
                  ],
                ),
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  size: 20.w,
                  navController.selectedIndex.value == page
                      ? outLineIcon
                      : icon,
                  color: whiteColor.withOpacity(0.6),
                ),
                reusableTxt(label, whiteColor, 12.sp, FontWeight.bold),
              ],
            ),
    );
  }
}

final List<Widget> pages = [
  HomePage(),
  //ProductView(),
  FavoriteScreen(),
  LocationScreen(),
  ProfileScreen(),
];


/* // Reactive body
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: navController.selectedIndex.value,
          onTap: navController.changeTabIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorite"),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on), label: "Location"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
      */
