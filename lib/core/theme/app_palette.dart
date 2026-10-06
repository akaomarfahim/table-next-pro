import 'package:flutter/material.dart';

import 'app_tokens.dart';

/// Semantic colours that Material's [ColorScheme] does not cover
/// (status colours, floor plan colours, subtle text, etc.).
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.success,
    required this.warning,
    required this.danger,
    required this.info,
    required this.violet,
    required this.textMuted,
    required this.border,
    required this.canvas,
    required this.canvasGrid,
    required this.tableFill,
    required this.chairFill,
    required this.tableAvailable,
    required this.tableReserved,
    required this.tableOccupied,
    required this.tableSelected,
    required this.tableUnavailable,
  });

  final Color success;
  final Color warning;
  final Color danger;
  final Color info;
  final Color violet;
  final Color textMuted;
  final Color border;
  final Color canvas;
  final Color canvasGrid;
  final Color tableFill;
  final Color chairFill;
  final Color tableAvailable;
  final Color tableReserved;
  final Color tableOccupied;
  final Color tableSelected;
  final Color tableUnavailable;

  static const AppPalette light = AppPalette(
    success: AppColors.success,
    warning: AppColors.warning,
    danger: AppColors.danger,
    info: AppColors.info,
    violet: AppColors.violet,
    textMuted: AppColors.lightTextMuted,
    border: AppColors.lightOutline,
    canvas: Color(0xFFFBFBFC),
    canvasGrid: Color(0xFFE9EBEF),
    tableFill: Color(0xFFFFFFFF),
    chairFill: Color(0xFFD0D5DD),
    tableAvailable: AppColors.success,
    tableReserved: AppColors.warning,
    tableOccupied: AppColors.brand,
    tableSelected: AppColors.info,
    tableUnavailable: Color(0xFF98A2B3),
  );

  static const AppPalette dark = AppPalette(
    success: Color(0xFF32D583),
    warning: Color(0xFFFDB022),
    danger: Color(0xFFF97066),
    info: Color(0xFF53B1FD),
    violet: Color(0xFF9B8AFB),
    textMuted: AppColors.darkTextMuted,
    border: AppColors.darkOutline,
    canvas: Color(0xFF10131A),
    canvasGrid: Color(0xFF1C2029),
    tableFill: Color(0xFF1D222C),
    chairFill: Color(0xFF3A4150),
    tableAvailable: Color(0xFF32D583),
    tableReserved: Color(0xFFFDB022),
    tableOccupied: AppColors.brandLight,
    tableSelected: Color(0xFF53B1FD),
    tableUnavailable: Color(0xFF475467),
  );

  @override
  AppPalette copyWith({
    Color? success,
    Color? warning,
    Color? danger,
    Color? info,
    Color? violet,
    Color? textMuted,
    Color? border,
    Color? canvas,
    Color? canvasGrid,
    Color? tableFill,
    Color? chairFill,
    Color? tableAvailable,
    Color? tableReserved,
    Color? tableOccupied,
    Color? tableSelected,
    Color? tableUnavailable,
  }) {
    return AppPalette(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      info: info ?? this.info,
      violet: violet ?? this.violet,
      textMuted: textMuted ?? this.textMuted,
      border: border ?? this.border,
      canvas: canvas ?? this.canvas,
      canvasGrid: canvasGrid ?? this.canvasGrid,
      tableFill: tableFill ?? this.tableFill,
      chairFill: chairFill ?? this.chairFill,
      tableAvailable: tableAvailable ?? this.tableAvailable,
      tableReserved: tableReserved ?? this.tableReserved,
      tableOccupied: tableOccupied ?? this.tableOccupied,
      tableSelected: tableSelected ?? this.tableSelected,
      tableUnavailable: tableUnavailable ?? this.tableUnavailable,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppPalette(
      success: l(success, other.success),
      warning: l(warning, other.warning),
      danger: l(danger, other.danger),
      info: l(info, other.info),
      violet: l(violet, other.violet),
      textMuted: l(textMuted, other.textMuted),
      border: l(border, other.border),
      canvas: l(canvas, other.canvas),
      canvasGrid: l(canvasGrid, other.canvasGrid),
      tableFill: l(tableFill, other.tableFill),
      chairFill: l(chairFill, other.chairFill),
      tableAvailable: l(tableAvailable, other.tableAvailable),
      tableReserved: l(tableReserved, other.tableReserved),
      tableOccupied: l(tableOccupied, other.tableOccupied),
      tableSelected: l(tableSelected, other.tableSelected),
      tableUnavailable: l(tableUnavailable, other.tableUnavailable),
    );
  }
}
