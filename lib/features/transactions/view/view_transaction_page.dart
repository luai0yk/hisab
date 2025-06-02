import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/route/app_routes.dart';
import 'package:hisab/features/transactions/controller/view_transaction_controller.dart';
import 'package:hisab/features/transactions/model/transaction_model.dart';
import 'package:hisab/shared/widgets/icon/custom_huge_icon.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/localization/locale_key.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../core/constants/theme/custom_theme/custom_hint_style.dart';
import '../../../shared/widgets/button/custom_icon_button.dart';
import '../widget/transaction_item.dart';

class ViewTransactionPage extends GetView<ViewTransactionController> {
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
          Get.toNamed(AppRoutes.addTransactionPage)!.then(
            (value) async {
              await controller.viewTransaction();
            },
          );
        },
        label: Text(LocaleKey.add.tr),
        icon: const CustomHugeIcon(
          icon: HugeIcons.strokeRoundedMoneyAdd02,
          color: CupertinoColors.white,
        ),
      ),
      body: GetBuilder<ViewTransactionController>(
        id: 'transaction_list',
        initState: (state) async => await controller.viewTransaction(),
        builder: (controller) {
          if (controller.transactionList == null) {
            return Center(
              child: Text(
                LocaleKey.loading.tr,
                style: CustomHintStyle.hintStyle,
              ),
            );
          } else if (controller.transactionList!.isEmpty) {
            return Center(
              child: Text(
                'No transactions!',
                style: CustomHintStyle.hintStyle,
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.transactionList!.length,
            itemBuilder: (context, index) {
              TransactionModel transaction = controller.transactionList![index];
              return TransactionItem(transaction: transaction);
            },
          );
        },
      ),
    );
  }
}
