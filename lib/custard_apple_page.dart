// custard_apple_page.dart
import 'package:flutter/material.dart';

import 'cart_page.dart';
import 'favourite_page.dart';

class CustardApplePage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<String, int> cartQuantities;
  final List<Map<String, dynamic>> favoriteItems;
  const CustardApplePage({
    super.key,
    required this.cartItems,
    required this.cartQuantities,
    required this.favoriteItems,
  });

  @override
  State<CustardApplePage> createState() => _CustardApplePageState();
}

class _CustardApplePageState extends State<CustardApplePage> {
  int _quantity = 1;
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen, // Match UI color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Custard Apple"),
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
            Image.asset('assets/images/fruits/custard.jpg'),
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
                            .any((item) => item['name'] == "Custard Apple")) {
                          widget.favoriteItems.add({
                            'name': "Custard Apple",
                            'imagePath':
                            'assets/images/fruits/custard.jpg',
                            'description': 'Fresh, sweet custard apples',
                            'price': 150.0,
                          });
                        }
                      } else {
                        widget.favoriteItems.removeWhere(
                                (item) => item['name'] == "Custard Apple");
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
                      "₹150",
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
                          (item) => item['name'] == "Custard Apple")) {
                    widget.cartItems.add({
                      'name': "Custard Apple",
                      'imagePath': 'assets/images/fruits/custard.jpg',
                      'description': 'Fresh, sweet custard apples',
                      'price': 150.0,
                    });
                  }
                  widget.cartQuantities.update(
                    "Custard Apple",
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
                        "These are fresh, sweet custard apples. They are perfect for a healthy snack or dessert.")),
              ],
            ),
            const ExpansionTile(
              title: Text("Nutrition"),
              trailing: Icon(Icons.arrow_forward),
              children: [
                ListTile(
                    title: Text(
                        "Custard apples are a good source of fiber and vitamins A and C. They are also low in calories and fat.")),
              ],
            ),
            const ExpansionTile(
              title: Text("Review"),
              trailing: Icon(Icons.arrow_forward),
              children: [
                ListTile(
                    title: Text(
                        "These custard apples are absolutely delicious! They are sweet, creamy, and have a unique flavor. I highly recommend them.")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}