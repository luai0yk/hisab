import 'package:flutter/material.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/color_extension.dart';

class ProgressCard extends StatelessWidget {
  final String? message;
  const ProgressCard({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    ColorExtension myColors = Theme.of(context).extension()!;
    return Center(
      child: Container(
        width: 120,
        height: 100,
        padding: const EdgeInsets.all(Constants.spaceWith10x),
        decoration: BoxDecoration(
          color: myColors.backgroundGray,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          spacing: Constants.spaceWith10x,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: Constants.borderWidth * 2,
              valueColor: AlwaysStoppedAnimation<Color>(Constants.primaryColor),
              strokeCap: StrokeCap.round,
            ),
            if (message != null)
              Text(message!, style: TextStyle(color: myColors.foregroundGray)),
          ],
        ),
      ),
    );
  }
}
