// jowar_page.dart
import 'package:flutter/material.dart';

import 'cart_page.dart';
import 'favourite_page.dart';

class JowarPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<String, int> cartQuantities;
  final List<Map<String, dynamic>> favoriteItems;
  const JowarPage({
    super.key,
    required this.cartItems,
    required this.cartQuantities,
    required this.favoriteItems,
  });

  @override
  State<JowarPage> createState() => _JowarPageState();
}

class _JowarPageState extends State<JowarPage> {
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
        title: const Text("Jowar"),
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
            Image.asset('assets/images/grains/jowar.jpg'),
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
                            .any((item) => item['name'] == "Jowar")) {
                          widget.favoriteItems.add({
                            'name': "Jowar",
                            'imagePath': 'assets/images/grains/jowar.jpg',
                            'description': 'Jowar',
                            'price': 200.0,
                          });
                        }
                      } else {
                        widget.favoriteItems
                            .removeWhere((item) => item['name'] == "Jowar");
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
                  if (!widget.cartItems.any((item) => item['name'] == "Jowar")) {
                    widget.cartItems.add({
                      'name': "Jowar",
                      'imagePath': 'assets/images/grains/jowar.jpg',
                      'description': 'Jowar',
                      'price': 200.0,
                    });
                  }
                  widget.cartQuantities.update(
                    "Jowar",
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
                        "This is a premium quality jowar. It is perfect for making delicious and healthy Indian dishes.")),
              ],
            ),
            ExpansionTile(
              title: const Text("Nutrition"),
              trailing: const Icon(Icons.arrow_forward),
              children: const [
                ListTile(
                    title: Text(
                        "Jowar is a good source of protein and fiber. It is also low in fat.")),
              ],
            ),
            ExpansionTile(
              title: const Text("Review"),
              trailing: const Icon(Icons.arrow_forward),
              children: const [
                ListTile(
                    title: Text(
                        "This jowar is excellent! It cooks quickly and evenly, and has a great taste. I highly recommend it.")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}