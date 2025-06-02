import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/route/app_routes.dart';
import 'package:hisab/shared/widgets/icon/custom_huge_icon.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/localization/locale_key.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../shared/widgets/button/custom_icon_button.dart';
import '../widget/transaction_item.dart';

class ViewTransactionPage extends StatelessWidget {
  const ViewTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.appBar(
        title: LocaleKey.transactions.tr,
        actions: [
          CustomIconButton(
            onPressed: () => null,
            toolTip: LocaleKey.profile.tr,
            icon: HugeIcons.strokeRoundedSchoolReportCard,
          ),
          CustomIconButton(
            onPressed: () => Get.toNamed(AppRoutes.customerProfilePage),
            toolTip: LocaleKey.profile.tr,
            icon: HugeIcons.strokeRoundedUser,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(AppRoutes.addTransactionPage);
        },
        label: Text(LocaleKey.add.tr),
        icon: const CustomHugeIcon(
          icon: HugeIcons.strokeRoundedMoneyAdd02,
          color: CupertinoColors.white,
        ),
      ),
      body: ListView(
        children: const [
          TransactionItem(),
          TransactionItem(),
          TransactionItem(),
          TransactionItem(),
        ],
      ),
    );
  }
}
