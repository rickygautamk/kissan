// ladys_finger_page.dart
import 'package:flutter/material.dart';

import 'cart_page.dart';
import 'favourite_page.dart';

class LadysFingerPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<String, int> cartQuantities;
  final List<Map<String, dynamic>> favoriteItems;
  const LadysFingerPage({
    super.key,
    required this.cartItems,
    required this.cartQuantities,
    required this.favoriteItems,
  });

  @override
  State<LadysFingerPage> createState() => _LadysFingerPageState();
}

class _LadysFingerPageState extends State<LadysFingerPage> {
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
        title: const Text("Lady's Finger"),
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
            Image.asset('assets/images/vegetables/ladyfinger.jpg'),
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
                            .any((item) => item['name'] == "Lady's Finger")) {
                          widget.favoriteItems.add({
                            'name': "Lady's Finger",
                            'imagePath':
                            'assets/images/vegetables/ladyfinger.jpg',
                            'description': 'Fresh, green Lady\'s Finger',
                            'price': 40.0,
                          });
                        }
                      } else {
                        widget.favoriteItems.removeWhere(
                                (item) => item['name'] == "Lady's Finger");
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
                      "₹40",
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
                  if (!widget.cartItems.any(
                          (item) => item['name'] == "Lady's Finger")) {
                    widget.cartItems.add({
                      'name': "Lady's Finger",
                      'imagePath': 'assets/images/vegetables/ladyfinger.jpg',
                      'description': 'Fresh, green Lady\'s Finger',
                      'price': 40.0,
                    });
                  }
                  widget.cartQuantities.update(
                    "Lady's Finger",
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
            const ExpansionTile(
              title: Text("Product Details"),
              trailing: Icon(Icons.arrow_forward),
              children: [
                ListTile(
                    title: Text(
                        "These are fresh, green Lady's Finger. They are perfect for a healthy and delicious meal.")),
              ],
            ),
            const ExpansionTile(
              title: Text("Nutrition"),
              trailing: Icon(Icons.arrow_forward),
              children: [
                ListTile(
                    title: Text(
                        "Lady's Finger are a good source of fiber and vitamins. They are also low in calories and fat.")),
              ],
            ),
            const ExpansionTile(
              title: Text("Review"),
              trailing: Icon(Icons.arrow_forward),
              children: [
                ListTile(
                    title: Text(
                        "These Lady's Finger are fantastic! They are fresh, tender, and have a wonderful flavor. I highly recommend them for any dish.")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}