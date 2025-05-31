import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_hint_style.dart';
import 'package:hisab/core/localization/locale_key.dart';
import 'package:hisab/core/route/app_routes.dart';
import 'package:hisab/features/hisab/customers/controllers/view_customer_controller.dart';
import 'package:hisab/features/hisab/customers/model/customer_model.dart';
import 'package:hisab/features/hisab/customers/widget/customer_item.dart';
import 'package:hisab/shared/widgets/custom_appbar.dart';
import 'package:hisab/shared/widgets/icon/custom_huge_icon.dart';
import 'package:hisab/shared/widgets/input/custom_text_form_field.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../main.dart';
import '../../../../shared/widgets/button/custom_icon_button.dart';

class ViewCustomerPage extends GetView<ViewCustomerController> {
  const ViewCustomerPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.appBar(title: LocaleKey.customers.tr, actions: [
        CustomIconButton(
          onPressed: () async {
            prefs!.setBool(Constants.isLoggedIn, false);
            Get.offAllNamed(AppRoutes.loginPage);
          },
          icon: HugeIcons.strokeRoundedSettings01,
          toolTip: LocaleKey.settings.tr,
        ),
      ]),
      body: Column(
        children: [
          CustomTextFormField(
            hint: LocaleKey.search.tr,
            withMargin: true,
            onChanged: (text) => controller.searchCustomer(query: text),
            controller: controller.searchController,
            icon: const CustomHugeIcon(
              icon: HugeIcons.strokeRoundedSearch01,
            ).icon,
          ),
          Expanded(
            child: GetBuilder<ViewCustomerController>(
              id: 'customer_list',
              initState: (state) async {
                await controller.viewCustomers();
              },
              builder: (controller) {
                if (controller.customerList == null) {
                  return Center(
                    child: Text(
                      LocaleKey.loading.tr,
                      style: CustomHintStyle.hintStyle,
                    ),
                  );
                } else if (controller.customerList!.isEmpty) {
                  return Center(
                    child: Text(
                      LocaleKey.noCustomerFound.tr,
                      style: CustomHintStyle.hintStyle,
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(Constants.spaceWith15x),
                  itemCount: controller.customerList!.length,
                  itemBuilder: (context, index) {
                    CustomerModel customer = controller.customerList![index];
                    return CustomerItem(
                      customer: customer,
                      onTap: () => Get.toNamed(
                        AppRoutes.customerProfilePage,
                        arguments: customer,
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.addCustomerPage)!.then(
          (value) async {
            await controller.viewCustomers();
          },
        ),
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
    );
  }
}
