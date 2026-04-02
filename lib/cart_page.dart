// cart_page.dart
import 'package:flutter/material.dart';
import 'mainscreen_page.dart'; // Import the MainScreenPage

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<String, int> cartQuantities;
  const CartPage({
    super.key,
    required this.cartItems,
    required this.cartQuantities,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Function to show the order accepted screen
  void _showOrderAcceptedScreen(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 100.0,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Your Order Has Been Accepted",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      // Navigate back to the MainScreenPage
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainScreenPage()),
                              (route) => false);
                    },
                    child: const Text("Back to Home"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to show the checkout pop-up
  void _showCheckoutPopup(BuildContext context, double totalCost) {
    int _selectedDelivery = 0; // 0 for Farm Pickup, 1 for Online Delivery
    int _selectedPayment = 0; // 0 for UPI, 1 for Debit/Credit, 2 for Netbanking, 3 for COD

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView( // Wrap the Column with SingleChildScrollView
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16), // Increased spacing
                    RadioListTile(
                      title: const Text("Farm Pickup"),
                      value: 0,
                      groupValue: _selectedDelivery,
                      onChanged: (value) {
                        setState(() {
                          _selectedDelivery = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 8), // Added spacing
                    RadioListTile(
                      title: const Text("Online Delivery"),
                      value: 1,
                      groupValue: _selectedDelivery,
                      onChanged: (value) {
                        setState(() {
                          _selectedDelivery = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Payment",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16), // Increased spacing
                    RadioListTile(
                      title: const Text("UPI"),
                      value: 0,
                      groupValue: _selectedPayment,
                      onChanged: (value) {
                        setState(() {
                          _selectedPayment = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 8), // Added spacing
                    RadioListTile(
                      title: const Text("Debit/Credit Card"),
                      value: 1,
                      groupValue: _selectedPayment,
                      onChanged: (value) {
                        setState(() {
                          _selectedPayment = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 8), // Added spacing
                    RadioListTile(
                      title: const Text("Netbanking"),
                      value: 2,
                      groupValue: _selectedPayment,
                      onChanged: (value) {
                        setState(() {
                          _selectedPayment = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 8), // Added spacing
                    RadioListTile(
                      title: const Text("Cash on Delivery"),
                      value: 3,
                      groupValue: _selectedPayment,
                      onChanged: (value) {
                        setState(() {
                          _selectedPayment = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Total Cost: ₹${totalCost.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
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

                          // Show the order accepted screen
                          _showOrderAcceptedScreen(context);
                        },
                        child: const Text("Place Order"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    for (var item in widget.cartItems) {
      totalPrice +=
          item['price'] * (widget.cartQuantities[item['name']]?? 0);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = widget.cartItems[index];
                final itemName = cartItem['name'];
                return ListTile(
                  leading: Image.asset(cartItem['imagePath']),
                  title: Text(itemName),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("1 Kg"),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (widget.cartQuantities[itemName]! > 1) {
                                  widget.cartQuantities[itemName] =
                                      widget.cartQuantities[itemName]! - 1;
                                } else {
                                  widget.cartItems.remove(cartItem);
                                  widget.cartQuantities.remove(itemName);
                                }
                              });
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Text("${widget.cartQuantities[itemName]?? 0}"),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                widget.cartQuantities[itemName] =
                                    (widget.cartQuantities[itemName]?? 0) + 1;
                              });
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      Text("₹${cartItem['price']}"),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget.cartItems.remove(cartItem);
                            widget.cartQuantities.remove(itemName);
                          });
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              // Show the checkout pop-up instead of navigating
              _showCheckoutPopup(context, totalPrice);
            },
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Proceed to Check Out",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "₹$totalPrice",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}