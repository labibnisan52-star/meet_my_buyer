import 'package:flutter/material.dart';

class VariationOption {
  final String label;
  final Color? colorValue;
  final double? priceDelta;
  final int stock;

  const VariationOption({
    required this.label,
    this.colorValue,
    this.priceDelta,
    this.stock = 0,
  });
}

class VariationGroup {
  final String name;
  final List<VariationOption> options;
  final bool isColorType;

  const VariationGroup({
    required this.name,
    required this.options,
    this.isColorType = false,
  });
}