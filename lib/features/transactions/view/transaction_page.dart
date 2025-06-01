import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/shared/widgets/icon/custom_huge_icon.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/localization/locale_key.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../widget/transaction_item.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.appBar(
        title: LocaleKey.transactions.tr,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(LocaleKey.add.tr),
        icon: const CustomHugeIcon(
          icon: HugeIcons.strokeRoundedMoneyAdd02,
          color: CupertinoColors.white,
        ),
      ),
      body: ListView(
        children: [
          TransactionItem(),
          TransactionItem(),
          TransactionItem(),
          TransactionItem(),
        ],
      ),
    );
  }
}
