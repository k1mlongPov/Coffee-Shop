import 'package:get/get.dart';

class BottomNavController extends GetxController {
  late BottomNavController controller;
  RxInt selectedIndex = 0.obs; // Observable for reactive updates

  void changeTabIndex(int page) {
    selectedIndex.value = page;
  }
}
