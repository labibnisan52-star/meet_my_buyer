import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meet_my_app_buyer/providers/rfq_provider.dart';

class PostRfqScreen extends StatefulWidget {
  const PostRfqScreen({super.key});

  @override
  State<PostRfqScreen> createState() => _PostRfqScreenState();
}

class _PostRfqScreenState extends State<PostRfqScreen> {
  final _formKey = GlobalKey<FormState>();

  final _productNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _targetPriceController = TextEditingController();

  // Expires in - dropdown diye simple rakhlam
  String _selectedExpiry = "3 days";
  final List<String> _expiryOptions = [
    "1 day",
    "3 days",
    "5 days",
    "7 days",
    "15 days",
  ];

  @override
  void dispose() {
    _productNameController.dispose();
    _quantityController.dispose();
    _targetPriceController.dispose();
    super.dispose();
  }

  void _submitRfq() {
    if (!_formKey.currentState!.validate()) return;

    context.read<RFQProvider>().addRfq(
      productName: _productNameController.text.trim(),
      quantity: int.parse(_quantityController.text.trim()),
      targetPrice: double.parse(_targetPriceController.text.trim()),
      expiresIn: "Expires in $_selectedExpiry",
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('RFQ successfully posted!')),
    );

    Navigator.pop(context); // form close, RFQ tab e ferot
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text(
          'Post New RFQ',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Product / Item Name",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _productNameController,
                decoration: _inputDecoration("e.g. Dell Inspiron 15 x100"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Product name dite hobe";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              const Text(
                "Quantity Needed",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration("e.g. 100"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Quantity dite hobe";
                  }
                  if (int.tryParse(value.trim()) == null) {
                    return "Sothik number din";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              const Text(
                "Target Price (৳ per unit)",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _targetPriceController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: _inputDecoration("e.g. 50000"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Target price dite hobe";
                  }
                  if (double.tryParse(value.trim()) == null) {
                    return "Sothik price din";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              const Text(
                "RFQ Expires In",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                initialValue: _selectedExpiry,
                decoration: _inputDecoration(""),
                items: _expiryOptions
                    .map(
                      (e) => DropdownMenuItem(value: e, child: Text(e)),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedExpiry = value);
                  }
                },
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitRfq,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Post RFQ",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
      filled: true,
      fillColor: const Color(0xFFF5F5F5),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }
}
