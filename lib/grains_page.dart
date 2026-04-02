// lib/grains_page.dart

import 'package:flutter/material.dart';

import 'basmati_rice_page.dart';
import 'green_gram_page.dart';
import 'jowar_page.dart';
import 'raagi_page.dart';
import 'red_gram_page.dart';
import 'toor_dal_page.dart';
import 'cart_page.dart'; // Import cart_page.dart
import 'favourite_page.dart'; // Import favourite_page.dart

class GrainsPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<String, int> cartQuantities;
  final List<Map<String, dynamic>> favoriteItems;

  const GrainsPage({
    super.key,
    required this.cartItems,
    required this.cartQuantities,
    required this.favoriteItems,
  });

  @override
  State<GrainsPage> createState() => _GrainsPageState();
}

class _GrainsPageState extends State<GrainsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Grains"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(10.0),
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: [
          _buildGridItem(
            "Basmati Rice",
            "assets/images/grains/basmati_rice.jpg",
            BasmatiRicePage(
              // Pass the required parameters
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
            Colors.orangeAccent, // Color for the box
          ),
          _buildGridItem(
            "Toor Dal",
            "assets/images/grains/toor_dal.jpg",
            ToorDalPage(
              // Pass the required parameters
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
            Colors.yellow, // Color for the box
          ),
          _buildGridItem(
            "Raagi",
            "assets/images/grains/raagi.jpg",
            RaagiPage(
              // Pass the required parameters
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
            Colors.brown, // Color for the box
          ),
          _buildGridItem(
            "Jowar",
            "assets/images/grains/jowar.jpg",
            JowarPage(
              // Pass the required parameters
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
            Colors.grey, // Color for the box
          ),
          _buildGridItem(
            "Green Gram",
            "assets/images/grains/green_gram.jpg",
            GreenGramPage(
              // Pass the required parameters
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
            Colors.lightGreen, // Color for the box
          ),
          _buildGridItem(
            "Red Gram",
            "assets/images/grains/red_gram.jpg",
            RedGramPage(
              // Pass the required parameters
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
            Colors.red, // Color for the box
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(
      String name, String imagePath, Widget page, Color boxColor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: boxColor,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                textAlign: TextAlign.center,
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