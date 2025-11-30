import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/route/app_routes.dart';
import 'package:hisab/features/transactions/controller/transaction_controller.dart';
import 'package:hisab/features/transactions/model/transaction_model.dart';
import 'package:hisab/shared/model/customer_model.dart';
import 'package:hisab/shared/widgets/card/progress_card.dart';
import 'package:hisab/shared/widgets/icon/custom_huge_icon.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/localization/locale_key.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../core/constants/theme/custom_theme/custom_hint_style.dart';
import '../../../core/utils/dialog_helper.dart';
import '../../../shared/widgets/button/custom_icon_button.dart';
import '../../../shared/widgets/custom_list_tile.dart';
import '../../../shared/widgets/dialog/app_dialog.dart';
import '../widget/transaction_item.dart';

class ViewTransactionPage extends GetView<TransactionController> {
  final CustomerModel customer = Get.arguments;
  ViewTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.appBar(
        title: LocaleKey.transactions.tr,
        actions: [
          CustomIconButton(
            onPressed: () {},
            toolTip: LocaleKey.report.tr,
            icon: HugeIcons.strokeRoundedPdf01,
          ),
          CustomIconButton(
            onPressed: () => Get.toNamed(AppRoutes.customerProfilePage),
            toolTip: LocaleKey.profile.tr,
            icon: HugeIcons.strokeRoundedUser,
          ),
        ],
      ),
      body: GetBuilder<TransactionController>(
        builder: (controller) {
          return FutureBuilder<List<TransactionModel>>(
            future: controller.getAllCustomerTransactions(customer: customer),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ProgressCard(message: LocaleKey.loading.tr);
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error Occurred",
                    style: CustomHintStyle.hintStyle,
                  ),
                );
              } else {
                final transactionList = snapshot.data as List<TransactionModel>;
                if (transactionList.isEmpty) {
                  return Center(
                    child: Text(
                      LocaleKey.noTransaction.tr,
                      style: CustomHintStyle.hintStyle,
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(Constants.spaceWith10x),
                  itemCount: transactionList.length,
                  itemBuilder: (context, index) {
                    TransactionModel transaction = transactionList[index];
                    return TransactionItem(
                      customer: customer,
                      transaction: transaction,
                      onLongPress: () => _showOptionDialog(
                        context: context,
                        transaction: transaction,
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(AppRoutes.addTransactionPage, arguments: customer.id);
        },
        label: Text(LocaleKey.add.tr),
        icon: const CustomHugeIcon(
          icon: HugeIcons.strokeRoundedMoneyAdd02,
          color: CupertinoColors.white,
        ),
      ),
    );
  }

  _showOptionDialog(
      {required BuildContext context, required TransactionModel transaction}) {
    DialogHelper.show(
      context: context,
      child: AppDialog(
        title: LocaleKey.options.tr,
        customContent: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomListTile(
              title: LocaleKey.edit.tr,
              icon: HugeIcons.strokeRoundedEdit01,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.editTransactionPage,
                    arguments: transaction);
              },
            ),
            CustomListTile(
              title: LocaleKey.delete.tr,
              icon: HugeIcons.strokeRoundedDelete01,
              onTap: () {
                _showConfirmationDeleteDialog(
                  context: context,
                  transaction: transaction,
                );
              },
            ),
          ],
        ),
        cancelText: LocaleKey.cancel.tr,
        onCancel: () => null,
      ),
    );
  }

  _showConfirmationDeleteDialog({
    required BuildContext context,
    required TransactionModel transaction,
  }) {
    Get.back();
    DialogHelper.show(
      context: context,
      child: AppDialog(
        title: LocaleKey.delete.tr,
        content: LocaleKey.areYouSureToDeleteTransaction.tr,
        onCancel: () => null,
        onOkay: () async {
          await controller.deleteTransaction(transaction.id!);
        },
        okayColor: CupertinoColors.systemRed,
      ),
    );
  }
}
