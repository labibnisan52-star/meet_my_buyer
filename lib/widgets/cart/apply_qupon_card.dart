import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CouponRow extends StatelessWidget {
  const CouponRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(left: BorderSide(color: Color(0xFFF59E0B), width: 4)),
      ),
      child: Row(
        children: [
          FaIcon(FontAwesomeIcons.ticket, color: Color(0xFFF59E0B), size: 26),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Apply Coupon or Promo Code',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          Icon(Icons.chevron_right, color: Color(0xFF0F172A), size: 22),
        ],
      ),
    );
  }
}
