import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<String, int> cartQuantities;
  final double totalCost;

  const CheckoutPage({
    super.key,
    required this.cartItems,
    required this.cartQuantities,
    required this.totalCost,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Use MainAxisSize.min for the modal
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Checkout",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Delivery",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          // Add your delivery method selection UI here
          const Text("Select Method"),
          const SizedBox(height: 20),
          const Text(
            "Payment",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          // Add your payment method selection UI here
          const Text("Select Method"),
          const SizedBox(height: 20),
          Text(
            "Total Cost: \$${totalCost.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                // Add your order placement logic here
              },
              child: const Text("Place Order"),
            ),
          ),
        ],
      ),
    );
  }
}