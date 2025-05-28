import 'package:flutter/material.dart';

@immutable
class ColorExtension extends ThemeExtension<ColorExtension> {
  final Color primaryAccent;
  final Color foregroundGray;
  final Color backgroundGray;

  const ColorExtension({
    required this.primaryAccent,
    required this.foregroundGray,
    required this.backgroundGray,
  });

  @override
  ColorExtension copyWith({
    Color? primaryAccent,
  }) {
    return ColorExtension(
      primaryAccent: primaryAccent ?? this.primaryAccent,
      foregroundGray: foregroundGray,
      backgroundGray: backgroundGray,
    );
  }

  @override
  ColorExtension lerp(ThemeExtension<ColorExtension>? other, double t) {
    if (other is! ColorExtension) return this;
    return ColorExtension(
      primaryAccent: Color.lerp(primaryAccent, other.primaryAccent, t)!,
      foregroundGray: Color.lerp(foregroundGray, other.foregroundGray, t)!,
      backgroundGray: Color.lerp(backgroundGray, other.backgroundGray, t)!,
    );
  }
}
