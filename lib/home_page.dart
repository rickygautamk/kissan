// home_page.dart

import 'package:flutter/material.dart';
import 'fruit_page.dart';
import 'vegetable_page.dart';
import 'grains_page.dart';
import 'cart_page.dart'; // Import cart_page.dart
import 'favourite_page.dart';
// Import favourite_page.dart

class HomePage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<String, int> cartQuantities;
  final List<Map<String, dynamic>> favoriteItems;

  const HomePage({
    super.key,
    required this.cartItems,
    required this.cartQuantities,
    required this.favoriteItems,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Home Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImageCard(
              "Fruits",
              "assets/images/home/fruits.jpg",
              FruitPage(
                cartItems: widget.cartItems,
                cartQuantities: widget.cartQuantities,
                favoriteItems: widget.favoriteItems,
              ),
            ),
            _buildImageCard(
              "Vegetables",
              "assets/images/home/vegetables.jpg",
              VegetablePage(
                cartItems: widget.cartItems,
                cartQuantities: widget.cartQuantities,
                favoriteItems: widget.favoriteItems,
              ),
            ),
            _buildImageCard(
              "Grains",
              "assets/images/home/grains.jpg",
              GrainsPage(
                cartItems: widget.cartItems,
                cartQuantities: widget.cartQuantities,
                favoriteItems: widget.favoriteItems,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(String title, String imagePath, Widget page) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ink.image(
              image: AssetImage(imagePath),
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}