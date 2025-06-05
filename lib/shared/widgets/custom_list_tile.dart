import 'package:flutter/material.dart';

import '../../core/constants/theme/custom_theme/custom_text_theme.dart';
import 'icon/custom_huge_icon.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final IconData? icon;
  const CustomListTile({
    super.key,
    required this.title,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: CustomTextTheme.textStyle.copyWith(
          fontSize: 16,
        ),
      ),
      leading: CustomHugeIcon(
        icon: icon!,
      ),
      onTap: onTap,
    );
  }
}
