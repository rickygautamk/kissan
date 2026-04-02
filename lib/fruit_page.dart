// lib/fruit_page.dart

import 'package:flutter/material.dart';
import 'apple_page.dart';
import 'banana_page.dart';
import 'custard_apple_page.dart';
import 'guava_page.dart';
import 'mangoes_page.dart';
import 'orange_page.dart';
import 'papaya_page.dart';
import 'pine_apple_page.dart';


class FruitPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<String, int> cartQuantities;
  final List<Map<String, dynamic>> favoriteItems;

  const FruitPage({
    super.key,
    required this.cartItems,
    required this.cartQuantities,
    required this.favoriteItems,
  });

  @override
  State<FruitPage> createState() => _FruitPageState();
}

class _FruitPageState extends State<FruitPage> {
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
        title: const Text("Fruits"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(10.0),
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: [
          _buildGridItem(
            "Apple",
            "assets/images/fruits/apple.jpg",
            ApplePage(
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
          ),
          _buildGridItem(
            "Banana",
            "assets/images/fruits/banana.jpg",
            BananaPage(
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
          ),
          _buildGridItem(
            "Custard Apple",
            "assets/images/fruits/custard.jpg",
            CustardApplePage(
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
          ),
          _buildGridItem(
            "Guava",
            "assets/images/fruits/guava.jpg",
            GuavaPage(
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
          ),
          _buildGridItem(
            "Mangoes",
            "assets/images/fruits/mangoes.jpg",
            MangoesPage(
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
          ),
          _buildGridItem(
            "Orange",
            "assets/images/fruits/orange.jpg",
            OrangePage(
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
          ),
          _buildGridItem(
            "Papaya",
            "assets/images/fruits/papaya.jpg",
            PapayaPage(
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
          ),
          _buildGridItem(
            "Pine Apple",
            "assets/images/fruits/pineapple.jpg",
            PineApplePage(
              cartItems: widget.cartItems,
              cartQuantities: widget.cartQuantities,
              favoriteItems: widget.favoriteItems,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(String name, String imagePath, Widget page) {
    return GestureDetector(
      onTap: () {
        // Use push to push the item details page on top of the FruitPage
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
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