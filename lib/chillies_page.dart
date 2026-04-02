// chillies_page.dart
import 'package:flutter/material.dart';

import 'cart_page.dart';
import 'favourite_page.dart';

class ChilliesPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<String, int> cartQuantities;
  final List<Map<String, dynamic>> favoriteItems;
  const ChilliesPage({
    super.key,
    required this.cartItems,
    required this.cartQuantities,
    required this.favoriteItems,
  });

  @override
  State<ChilliesPage> createState() => _ChilliesPageState();
}

class _ChilliesPageState extends State<ChilliesPage> {
  int _quantity = 1;
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green, // Match UI color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Chillies"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(
                      cartItems: widget.cartItems,
                      cartQuantities: widget.cartQuantities,
                    ),
                  ));
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/vegetables/chillies.jpg'),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_quantity > 1) {
                            _quantity--;
                          }
                        });
                      },
                      icon: const Icon(Icons.remove),
                    ),
                    Text(
                      "$_quantity",
                      style: const TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _quantity++;
                        });
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                      if (_isFavorite) {
                        // Add item to favorites
                        if (!widget.favoriteItems
                            .any((item) => item['name'] == "Chillies")) {
                          widget.favoriteItems.add({
                            'name': "Chillies",
                            'imagePath': 'assets/images/vegetables/chillies.jpg',
                            'description': 'Fresh, green chillies',
                            'price': 80.0,
                          });
                        }
                      } else {
                        widget.favoriteItems
                            .removeWhere((item) => item['name'] == "Chillies");
                      }
                    });
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: _isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
                const Column(
                  children: [
                    Text(
                      "1Kg",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "₹80",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                // Add item to cart
                setState(() {
                  if (!widget.cartItems.any((item) => item['name'] == "Chillies")) {
                    widget.cartItems.add({
                      'name': "Chillies",
                      'imagePath': 'assets/images/vegetables/chillies.jpg',
                      'description': 'Fresh, green chillies',
                      'price': 80.0,
                    });
                  }
                  widget.cartQuantities.update(
                    "Chillies",
                        (value) => value + _quantity,
                    ifAbsent: () => _quantity,
                  );
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Match UI color
                minimumSize: const Size(200, 50), // Match UI size
              ),
              child: const Text("Add to Cart"),
            ),
            const SizedBox(height: 25),
            ExpansionTile(
              title: const Text("Product Details"),
              trailing: const Icon(Icons.arrow_forward),
              children: const [
                ListTile(
                    title: Text(
                        "These are fresh, green chillies. They are perfect for adding a spicy kick to any dish.")
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("Nutrition"),
              trailing: const Icon(Icons.arrow_forward),
              children: const [
                ListTile(
                    title: Text(
                        "Chillies are a good source of fiber and vitamins A and C. They are also low in calories and fat.")
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("Review"),
              trailing: const Icon(Icons.arrow_forward),
              children: const [
                ListTile(
                    title: Text(
                        "These chillies are fantastic! They are fresh, crisp, and have a perfect level of heat. I highly recommend them for any dish.")
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}