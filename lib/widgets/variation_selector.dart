import 'package:flutter/material.dart';
import 'package:meet_my_app_buyer/models/variation_model.dart';

// ─── VARIATION SELECTOR ───────────────────────────────────────────────────
// Generic widget: color type hole circle swatch dekhabe,
// othocase (Storage/RAM/Size) chip/box dekhabe.

class VariationSelector extends StatelessWidget {
  final VariationGroup group;
  final String? selectedValue;
  final ValueChanged<String> onSelect;

  const VariationSelector({
    super.key,
    required this.group,
    required this.selectedValue,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              group.name,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 8),
            if (selectedValue != null)
              Text(
                'Selected $selectedValue',
                style: const TextStyle(fontSize: 12, color: Colors.black45),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: group.options.map((opt) {
            final isSelected = opt.label == selectedValue;
            final outOfStock = opt.stock == 0;

            // ── Color type (circle swatch) ──
            if (group.isColorType) {
              return GestureDetector(
                onTap: outOfStock ? null : () => onSelect(opt.label),
                child: Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: opt.colorValue ?? Colors.grey,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFFFFC107)
                          : Colors.grey.shade300,
                      width: isSelected ? 2.5 : 1,
                    ),
                  ),
                  child: outOfStock
                      ? const Icon(Icons.close, size: 14, color: Colors.white)
                      : null,
                ),
              );
            }

            // ── Chip type (Storage / RAM / Size) ──
            return GestureDetector(
              onTap: outOfStock ? null : () => onSelect(opt.label),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFFFD600)
                      : const Color(0xFFF3F3F3),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFFFFC107)
                        : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  opt.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: outOfStock ? Colors.grey : Colors.black87,
                    decoration: outOfStock ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
