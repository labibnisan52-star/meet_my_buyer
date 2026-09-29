import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Primary_AppBar extends StatelessWidget implements PreferredSizeWidget {
  const Primary_AppBar({super.key, required this.textColor});

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      primary:
          false, 
      backgroundColor: const Color(0xFFFFD700),
      elevation: 0,
      centerTitle: false,
      title: Text(
        "MeetMyProduct",
        style: GoogleFonts.inter(
          color: textColor,
          fontWeight: FontWeight.w800,
          fontSize: 24,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.settings, color: textColor),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
