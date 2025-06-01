import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../customers/view/view_customer_page.dart';

class HomeController extends GetxController {
  int selectedIndex = 0;

  final List<Widget> pages = [
    ViewCustomerPage(),
  ];

  final PageController pageController = PageController();

  changeIndex({index}) {
    selectedIndex = index;
    pageController.jumpToPage(index);
    update(['bottom_navigation']);
  }
}
