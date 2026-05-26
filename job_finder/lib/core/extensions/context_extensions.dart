import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  bool get isCompact => MediaQuery.sizeOf(this).width < 900;

  bool get isWide => MediaQuery.sizeOf(this).width >= 1100;

  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;
}
