import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/color_extension.dart';
import 'package:hisab/core/localization/locale_key.dart';
import 'package:hisab/features/hisab/home_controller.dart';
import 'package:hisab/shared/widgets/icon/custom_huge_icon.dart';
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
          indicatorColor: Constants.primaryColor.withOpacity(.1),
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
              icon: const CustomHugeIcon(
                icon: HugeIcons.strokeRoundedUserGroup,
              ),
              selectedIcon: CustomHugeIcon(
                icon: HugeIcons.strokeRoundedUserGroup,
                color: Constants.primaryColor,
              ),
              label: LocaleKey.customers.tr,
            ),
            NavigationDestination(
              icon: const CustomHugeIcon(
                icon: HugeIcons.strokeRoundedAnalyticsUp,
              ),
              selectedIcon: CustomHugeIcon(
                icon: HugeIcons.strokeRoundedAnalyticsUp,
                color: Constants.primaryColor,
              ),
              label: 'Overview',
            ),
            NavigationDestination(
              icon: const CustomHugeIcon(
                icon: HugeIcons.strokeRoundedTransactionHistory,
              ),
              selectedIcon: CustomHugeIcon(
                icon: HugeIcons.strokeRoundedTransactionHistory,
                color: Constants.primaryColor,
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
