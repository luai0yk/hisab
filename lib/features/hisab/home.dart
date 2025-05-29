import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/color_extension.dart';
import 'package:hisab/core/localization/locale_key.dart';
import 'package:hisab/features/hisab/home_controller.dart';
import 'package:hugeicons/hugeicons.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorExtension customColors = Get.theme.extension<ColorExtension>()!;

    return Scaffold(
      bottomNavigationBar: GetBuilder<HomeController>(
        id: 'bottom_navigation',
        builder: (controller) => NavigationBar(
          indicatorColor: customColors.backgroundGray,
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              Constants.radius,
            ),
          ),
          backgroundColor:
              Get.isDarkMode ? CupertinoColors.black : CupertinoColors.white,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: controller.selectedIndex,
          onDestinationSelected: (value) =>
              controller.changeIndex(index: value),
          destinations: [
            NavigationDestination(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedUserGroup,
                color: customColors.foregroundGray,
              ),
              label: LocaleKey.customers.tr,
            ),
            NavigationDestination(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedAnalyticsUp,
                color: customColors.foregroundGray,
              ),
              label: 'Overview',
            ),
            NavigationDestination(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedTransactionHistory,
                color: customColors.foregroundGray,
              ),
              label: 'History',
            ),
          ],
        ),
      ),
      body: PageView(
        onPageChanged: (value) => controller.changeIndex(index: value),
        controller: controller.pageController,
        children: controller.pages,
      ),
    );
  }
}
