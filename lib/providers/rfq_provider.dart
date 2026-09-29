import 'package:flutter/material.dart';
import 'package:meet_my_app_buyer/data/dummy_data.dart';
import 'package:meet_my_app_buyer/models/rfq_model.dart';

class RFQProvider extends ChangeNotifier {
  // shuru te dummy data diye list load kore rakhlam,
  // pore user notun RFQ post korle eikhane add hobe
  final List<RfqModel> _rfqs = List.from(dummyRfqs);

  List<RfqModel> get rfqs => _rfqs;

  // ── Notun RFQ add kora (Post RFQ form theke call hobe) ──────────────
  void addRfq({
    required String productName,
    required int quantity,
    required double targetPrice,
    required String expiresIn,
  }) {
    final newRfq = RfqModel(
      rfqId: _generateRfqId(),
      productName: productName,
      quantity: quantity,
      targetPrice: targetPrice,
      expiresIn: expiresIn,
      quoteCount: 0,
      status: "Pending", // notun RFQ shurute always Pending thakbe
      bestQuotePrice: null,
      bestQuoteSupplier: null,
      isVerifiedSupplier: false,
    );

    _rfqs.insert(0, newRfq); // notun ta shobar upore dekhabe
    notifyListeners();
  }

  // ── Shimple auto id generator: RFQ-0052, RFQ-0053... ─────────────────
  String _generateRfqId() {
    final nextNumber = _rfqs.length + 52; // dummy data 51 porjonto ache tai 52 theke shuru
    return "RFQ-${nextNumber.toString().padLeft(4, '0')}";
  }
}
