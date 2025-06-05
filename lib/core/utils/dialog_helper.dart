import 'dart:math';

import 'package:flutter/material.dart';

class DialogHelper {
  static show({
    required BuildContext context,
    required Widget child,
    bool isDismissible = true,
  }) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      barrierLabel: '${Random().nextInt(100)}',
      barrierDismissible: isDismissible,
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          ),
          child: child,
        );
      },
      useRootNavigator: false,
    );
  }
}
