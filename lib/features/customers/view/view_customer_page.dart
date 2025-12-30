import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/localization/locale_key.dart';
import 'package:hisab/core/route/app_routes.dart';
import 'package:hisab/core/utils/dialog_helper.dart';
import 'package:hisab/shared/widgets/appbar/custom_appbar.dart';
import 'package:hisab/shared/widgets/card/progress_card.dart';
import 'package:hisab/shared/widgets/dialog/app_dialog.dart';
import 'package:hisab/shared/widgets/icon/custom_huge_icon.dart';
import 'package:hisab/shared/widgets/input/custom_text_form_field.dart';
import 'package:hisab/shared/widgets/listtile/custom_list_tile.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../shared/model/customer_model.dart';
import '../../../shared/widgets/button/custom_icon_button.dart';
import '../controllers/customer_controller.dart';
import '../widget/customer_item.dart';

class ViewCustomerPage extends GetView<CustomerController> {
  const ViewCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.appBar(
        title: LocaleKey.customers.tr,
        actions: [
          CustomIconButton(
            onPressed: () {},
            icon: HugeIcons.strokeRoundedSettings01,
            toolTip: LocaleKey.settings.tr,
          ),
        ],
      ),
      body: Column(
        children: [
          CustomTextFormField(
            hint: LocaleKey.search.tr,
            withMargin: true,
            withBottomPadding: false,
            controller: controller.searchController,
            icon: const CustomHugeIcon(
              icon: HugeIcons.strokeRoundedSearch01,
            ).icon,
          ),
          Expanded(
            child: GetBuilder<CustomerController>(
              id: 'customer_list',
              builder: (controller) {
                var customers = controller.filteredList;

                if (customers == null) {
                  return const ProgressCard(message: LocaleKey.loading);
                }

                if (customers.isEmpty) {
                  return Center(
                    child: Text(LocaleKey.noCustomerFound.tr),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(Constants.spaceWith15x),
                  itemCount: customers.length,
                  itemBuilder: (context, index) {
                    CustomerModel customer = customers[index];
                    return CustomerItem(
                      customer: customer,
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        controller.searchController.clear();
                        Get.toNamed(
                          AppRoutes.transactionPage,
                          arguments: customer,
                        )!
                            .then(
                          (value) async {
                            await controller.viewCustomers();
                          },
                        );
                      },
                      onLongPress: () {
                        _showOptionsDialog(
                          context: context,
                          customer: customer,
                        );
                      },
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.addCustomerPage),
        label: Text(LocaleKey.add.tr),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.radius),
        ),
        backgroundColor: Constants.primaryColor,
        icon: const CustomHugeIcon(
          icon: HugeIcons.strokeRoundedAddTeam,
          color: CupertinoColors.white,
        ),
      ),
    );
  }

  void _showOptionsDialog({
    required BuildContext context,
    required CustomerModel customer,
  }) {
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
                Get.toNamed(AppRoutes.editCustomerPage, arguments: customer);
              },
            ),
            CustomListTile(
              title: LocaleKey.delete.tr,
              icon: HugeIcons.strokeRoundedDelete01,
              onTap: () {
                _showConfirmationDeleteDialog(
                  context: context,
                  customer: customer,
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
    required CustomerModel customer,
  }) {
    Get.back();
    DialogHelper.show(
      context: context,
      child: AppDialog(
        title: LocaleKey.delete.tr,
        content: LocaleKey.areYouSureToDeleteCustomer.tr,
        onCancel: () => null,
        onOkay: () async {
          await controller.deleteCustomer(customer.id!);
          Get.back();
        },
        okayColor: CupertinoColors.systemRed,
      ),
    );
  }
}
