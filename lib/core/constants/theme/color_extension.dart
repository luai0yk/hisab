import 'package:flutter/material.dart';

@immutable
class ColorExtension extends ThemeExtension<ColorExtension> {
  final Color primaryAccent;

  const ColorExtension({
    required this.primaryAccent,
  });

  @override
  ColorExtension copyWith({
    Color? primaryAccent,
    Color? secondaryAccent,
  }) {
    return ColorExtension(
      primaryAccent: primaryAccent ?? this.primaryAccent,
    );
  }

  @override
  ColorExtension lerp(ThemeExtension<ColorExtension>? other, double t) {
    if (other is! ColorExtension) return this;
    return ColorExtension(
      primaryAccent: Color.lerp(primaryAccent, other.primaryAccent, t)!,
    );
  }
}
