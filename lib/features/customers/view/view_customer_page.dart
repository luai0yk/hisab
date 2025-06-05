import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/storage_key.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_hint_style.dart';
import 'package:hisab/core/localization/locale_key.dart';
import 'package:hisab/core/route/app_routes.dart';
import 'package:hisab/core/utils/dialog_helper.dart';
import 'package:hisab/shared/controller/customer_data_controller.dart';
import 'package:hisab/shared/widgets/custom_appbar.dart';
import 'package:hisab/shared/widgets/custom_list_tile.dart';
import 'package:hisab/shared/widgets/dialog/app_dialog.dart';
import 'package:hisab/shared/widgets/icon/custom_huge_icon.dart';
import 'package:hisab/shared/widgets/input/custom_text_form_field.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../shared/widgets/button/custom_icon_button.dart';
import '../../../core/db/customer/delete_customer_db.dart';
import '../../../core/services/storage_service.dart';
import '../../../shared/model/customer_model.dart';
import '../controllers/view_customer_controller.dart';
import '../widget/customer_item.dart';

class ViewCustomerPage extends GetView<ViewCustomerController> {
  ViewCustomerPage({
    super.key,
  });

  final storage = Get.find<StorageService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.appBar(
        title: LocaleKey.customers.tr,
        actions: [
          CustomIconButton(
            onPressed: () async {
              storage.setBool(StorageKey.isUserLogged, false);
              Get.offAllNamed(AppRoutes.loginPage);
            },
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
                      onTap: () {
                        Get.find<CustomerDataController>().customer = customer;
                        Get.toNamed(AppRoutes.transactionPage)!.then(
                          (value) async {
                            await controller.viewCustomers();
                          },
                        );
                      },
                      onLongPress: () {
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
                                    Get.find<CustomerDataController>()
                                        .customer = customer;
                                    Get.back();
                                    Get.toNamed(AppRoutes.editCustomerPage)!
                                        .then(
                                      (value) async {
                                        await controller.viewCustomers();
                                      },
                                    );
                                  },
                                ),
                                CustomListTile(
                                  title: LocaleKey.delete.tr,
                                  icon: HugeIcons.strokeRoundedDelete01,
                                  onTap: () {
                                    Get.back();
                                    DialogHelper.show(
                                      context: context,
                                      child: AppDialog(
                                        title: LocaleKey.delete.tr,
                                        content: LocaleKey
                                            .areYouSureToDeleteCustomer.tr,
                                        onCancel: () => null,
                                        onOkay: () async {
                                          await DeleteCustomerDB()
                                              .deleteCustomer(
                                            customerID: customer.id,
                                          );
                                          await controller.viewCustomers();
                                          Get.back();
                                        },
                                        okayColor: CupertinoColors.systemRed,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            cancelText: LocaleKey.cancel.tr,
                            onCancel: () => null,
                          ),
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
