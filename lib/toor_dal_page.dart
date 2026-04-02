// toor_dal_page.dart
import 'package:flutter/material.dart';

import 'cart_page.dart';
import 'favourite_page.dart';

class ToorDalPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<String, int> cartQuantities;
  final List<Map<String, dynamic>> favoriteItems;
  const ToorDalPage({
    super.key,
    required this.cartItems,
    required this.cartQuantities,
    required this.favoriteItems,
  });

  @override
  State<ToorDalPage> createState() => _ToorDalPageState();
}

class _ToorDalPageState extends State<ToorDalPage> {
  int _quantity = 1;
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow, // Match UI color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Toor Dal"),
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
            Image.asset('assets/images/grains/toor_dal.jpg'),
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
                            .any((item) => item['name'] == "Toor Dal")) {
                          widget.favoriteItems.add({
                            'name': "Toor Dal",
                            'imagePath': 'assets/images/grains/toor_dal.jpg',
                            'description': 'Toor Dal',
                            'price': 200.0,
                          });
                        }
                      } else {
                        widget.favoriteItems
                            .removeWhere((item) => item['name'] == "Toor Dal");
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
                      "₹200",
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
                  if (!widget.cartItems.any((item) => item['name'] == "Toor Dal")) {
                    widget.cartItems.add({
                      'name': "Toor Dal",
                      'imagePath': 'assets/images/grains/toor_dal.jpg',
                      'description': 'Toor Dal',
                      'price': 200.0,
                    });
                  }
                  widget.cartQuantities.update(
                    "Toor Dal",
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
                        "This is a premium quality toor dal. It is perfect for making delicious and healthy Indian dishes.")),
              ],
            ),
            const ExpansionTile(
              title: Text("Nutrition"),
              trailing: Icon(Icons.arrow_forward),
              children: [
                ListTile(
                    title: Text(
                        "Toor dal is a good source of protein and fiber. It is also low in fat.")),
              ],
            ),
            const ExpansionTile(
              title: Text("Review"),
              trailing: Icon(Icons.arrow_forward),
              children: [
                ListTile(
                    title: Text(
                        "This toor dal is excellent! It cooks quickly and evenly, and has a great taste. I highly recommend it.")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}