// lib/vegetable_page.dart

import 'package:flutter/material.dart';
import 'beans_page.dart';
import 'brinjal_page.dart';
import 'carrot_page.dart';
import 'cauliflower_page.dart';
import 'chillies_page.dart';
import 'ladys_finger_page.dart';
import 'onions_page.dart';
import 'tomato_page.dart';
import 'cart_page.dart'; // Import cart_page.dart
import 'favourite_page.dart'; // Import favourite_page.dart

class VegetablePage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<String, int> cartQuantities;
  final List<Map<String, dynamic>> favoriteItems;

  const VegetablePage({
    super.key,
    required this.cartItems,
    required this.cartQuantities,
    required this.favoriteItems,
  });

  @override
  State<VegetablePage> createState() => _VegetablePageState();
}

class _VegetablePageState extends State<VegetablePage> {
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
        title: const Text("Vegetables"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(10.0),
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: [
          _buildGridItem(
            "Tomato",
            "assets/images/vegetables/tomato.jpg",
            TomatoPage(
              // Pass the required parameters
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
            Colors.red, // Color for the box
          ),
          _buildGridItem(
            "Beans",
            "assets/images/vegetables/beans.jpg",
            BeansPage(
              // Pass the required parameters
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
            Colors.green, // Color for the box
          ),
          _buildGridItem(
            "Chillies",
            "assets/images/vegetables/chillies.jpg",
            ChilliesPage(
              // Pass the required parameters
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
            Colors.lightGreen, // Color for the box
          ),
          _buildGridItem(
            "Carrot",
            "assets/images/vegetables/carrot.jpg",
            CarrotPage(
              // Pass the required parameters
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
            Colors.orange, // Color for the box
          ),
          _buildGridItem(
            "Cauliflower",
            "assets/images/vegetables/cauliflower.jpg",
            CauliflowerPage(
              // Pass the required parameters
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
            Colors.grey, // Color for the box
          ),
          _buildGridItem(
            "Lady's Finger",
            "assets/images/vegetables/ladyfinger.jpg",
            LadysFingerPage(
              // Pass the required parameters
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
            Colors.lightGreenAccent, // Color for the box
          ),
          _buildGridItem(
            "Brinjal",
            "assets/images/vegetables/brinjal.jpg",
            BrinjalPage(
              // Pass the required parameters
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
            Colors.deepPurple, // Color for the box
          ),
          _buildGridItem(
            "Onions",
            "assets/images/vegetables/onions.jpg",
            OnionsPage(
              // Pass the required parameters
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
            Colors.purpleAccent, // Color for the box
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