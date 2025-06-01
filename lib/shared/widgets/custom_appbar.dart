import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/shared/widgets/button/custom_icon_button.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../core/constants/theme/custom_theme/custom_text_theme.dart';

class CustomAppbar {
  static AppBar appBar({List<Widget>? actions, required String title}) {
    bool canGoBack = Get.key.currentState!.canPop();

    return AppBar(
      actions: actions,
      // toolbarHeight: 70,
      // leadingWidth: 30,
      // titleSpacing: 0,
      automaticallyImplyLeading: true,
      leading: canGoBack
          ? CustomIconButton(
              onPressed: () => Get.back(),
              icon: HugeIcons.strokeRoundedMultiplicationSign,
            )
          : null,
      title: Text(
        title.toUpperCase(),
        style: CustomTextTheme.textStyle.copyWith(fontSize: 20),
      ),
    );
  }
}
