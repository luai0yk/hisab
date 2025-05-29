import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/localization/locale_key.dart';
import 'package:hisab/core/route/app_routes.dart';
import 'package:hisab/features/hisab/customers/widget/customer_item.dart';
import 'package:hisab/shared/widgets/button/custom_icon_button.dart';
import 'package:hisab/shared/widgets/custom_appbar.dart';
import 'package:hisab/shared/widgets/icon/custom_huge_icon.dart';
import 'package:hisab/shared/widgets/input/custom_text_form_field.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(Constants.spaceWith15x),
          child: Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Text(
              //       LocaleKey.customers.tr,
              //       style: CustomTextTheme.textStyle.copyWith(
              //         fontSize: 22,
              //       ),
              //     ),
              //     const Spacer(),
              //     IconButton(
              //       onPressed: () {},
              //       tooltip: LocaleKey.search,
              //       icon: const HugeIcon(
              //         icon: HugeIcons.strokeRoundedSettings01,
              //         color: CupertinoColors.systemGrey,
              //       ),
              //     )
              //   ],
              // ),

              CustomAppbar(
                title: LocaleKey.customers.tr,
                actions: [
                  CustomIconButton(
                    onPressed: () {},
                    icon: HugeIcons.strokeRoundedSettings01,
                    toolTip: LocaleKey.settings.tr,
                  )
                ],
              ),
              CustomTextFormField(
                hint: LocaleKey.search.tr,
                icon: const CustomHugeIcon(
                  icon: HugeIcons.strokeRoundedSearch01,
                ).icon,
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: Constants.spaceWith15x),
                  children: List.generate(
                    20,
                    (index) => const CustomerItem(),
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Get.toNamed(AppRoutes.addCustomerPage),
          label: Text(
            LocaleKey.add.tr,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              Constants.radius,
            ),
          ),
          backgroundColor: Constants.primaryColor,
          icon: const CustomHugeIcon(
            icon: HugeIcons.strokeRoundedAddTeam,
            color: CupertinoColors.white,
          ),
        ),
      ),
    );
  }
}
