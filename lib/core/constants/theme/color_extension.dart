import 'package:flutter/material.dart';

@immutable
class ColorExtension extends ThemeExtension<ColorExtension> {
  final Color primaryAccent;
  final Color foregroundGray;
  final Color backgroundGray;
  final Color surfaceColor;

  const ColorExtension({
    required this.primaryAccent,
    required this.foregroundGray,
    required this.backgroundGray,
    required this.surfaceColor,
  });

  @override
  ColorExtension copyWith({
    Color? primaryAccent,
  }) {
    return ColorExtension(
      primaryAccent: primaryAccent ?? this.primaryAccent,
      foregroundGray: foregroundGray,
      backgroundGray: backgroundGray,
      surfaceColor: surfaceColor,
    );
  }

  @override
  ColorExtension lerp(ThemeExtension<ColorExtension>? other, double t) {
    if (other is! ColorExtension) return this;
    return ColorExtension(
      primaryAccent: Color.lerp(primaryAccent, other.primaryAccent, t)!,
      foregroundGray: Color.lerp(foregroundGray, other.foregroundGray, t)!,
      backgroundGray: Color.lerp(backgroundGray, other.backgroundGray, t)!,
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t)!,
    );
  }
}
