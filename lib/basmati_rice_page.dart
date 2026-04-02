// basmati_rice_page.dart
import 'package:flutter/material.dart';

import 'cart_page.dart';
import 'favourite_page.dart';

class BasmatiRicePage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<String, int> cartQuantities;
  final List<Map<String, dynamic>> favoriteItems;
  const BasmatiRicePage({
    super.key,
    required this.cartItems,
    required this.cartQuantities,
    required this.favoriteItems,
  });

  @override
  State<BasmatiRicePage> createState() => _BasmatiRicePageState();
}

class _BasmatiRicePageState extends State<BasmatiRicePage> {
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
        title: const Text("Basmathi Rice"),
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
            Image.asset('assets/images/grains/basmati_rice.jpg'),
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
                            .any((item) => item['name'] == "Basmathi Rice")) {
                          widget.favoriteItems.add({
                            'name': "Basmathi Rice",
                            'imagePath':
                            'assets/images/grains/basmati_rice.jpg',
                            'description': 'Fresh, white basmati rice',
                            'price': 420.0,
                          });
                        }
                      } else {
                        widget.favoriteItems.removeWhere(
                                (item) => item['name'] == "Basmathi Rice");
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
                      "₹420",
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
                          (item) => item['name'] == "Basmathi Rice")) {
                    widget.cartItems.add({
                      'name': "Basmathi Rice",
                      'imagePath': 'assets/images/grains/basmati_rice.jpg',
                      'description': 'Fresh, white basmati rice',
                      'price': 420.0,
                    });
                  }
                  widget.cartQuantities.update(
                    "Basmathi Rice",
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
                        "This is a premium quality basmati rice. It is long-grained, aromatic, and perfect for a variety of dishes.")),
              ],
            ),
            ExpansionTile(
              title: const Text("Nutrition"),
              trailing: const Icon(Icons.arrow_forward),
              children: const [
                ListTile(
                    title: Text(
                        "Basmati rice is a good source of carbohydrates and fiber. It is also low in fat.")),
              ],
            ),
            ExpansionTile(
              title: const Text("Review"),
              trailing: const Icon(Icons.arrow_forward),
              children: const [
                ListTile(
                    title: Text(
                        "This basmati rice is excellent! It is fluffy, flavorful, and cooks perfectly every time. I highly recommend it.")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}