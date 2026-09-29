import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meet_my_app_buyer/providers/rfq_provider.dart';
import 'package:meet_my_app_buyer/screens/post_rfq_screen.dart'; // tomar path onujayi adjust koro
import 'package:meet_my_app_buyer/widgets/RFQ/rfq_card.dart';
import 'package:meet_my_app_buyer/widgets/RFQ/rfq_chips.dart';
import 'package:meet_my_app_buyer/widgets/RFQ/rfq_header.dart';

class RfqTab extends StatefulWidget {
  const RfqTab({super.key});

  @override
  State<RfqTab> createState() => _RfqTabState();
}

class _RfqTabState extends State<RfqTab> {
  int selectedFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    // ekhon dummyRfqs shorashori na niye Provider theke live list nichhi
    final rfqs = context.watch<RFQProvider>().rfqs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RfqHeader(
          onNewRfqTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PostRfqScreen()),
            );
          },
        ),
        const SizedBox(height: 16),
        RfqFilterChips(
          selectedIndex: selectedFilterIndex,
          onFilterSelected: (index) {
            setState(() {
              selectedFilterIndex = index;
            });
          },
        ),
        const SizedBox(height: 16),
        ...rfqs.map((rfq) => RfqCard(rfq: rfq)),
      ],
    );
  }
}
