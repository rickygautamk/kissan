// toor_dal_page.dart

import 'package:flutter/material.dart';

class ToorDalPage extends StatelessWidget {
  const ToorDalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[200], // Light yellow color
        title: const Text("Toor Dal"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Handle favorite button press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Image of Toor Dal
            Image.asset(
              'assets/images/grains/toor_dal.jpg',
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            // Price and quantity
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    // Handle quantity decrease
                  },
                ),
                const Text(
                  '1',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // Handle quantity increase
                  },
                ),
                const SizedBox(width: 50),
                const Column(
                  children: [
                    Text(
                      '1Kg',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '₹200',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Add to cart button
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  // Handle add to cart action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: const Text('Add to Cart'),
              ),
            ),
            const SizedBox(height: 20),
            // Product Details, Nutrition, Review
            ExpansionTile(
              title: const Text('Product Details'),
              trailing: const Icon(Icons.arrow_forward),
              children: const [
                ListTile(
                  title: Text('Details about the product'),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('Nutrition'),
              trailing: const Icon(Icons.arrow_forward),
              children: const [
                ListTile(
                  title: Text('Nutritional information'),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('Review'),
              trailing: const Icon(Icons.arrow_forward), // Use arrow instead of stars
              children: const [
                ListTile(
                  title: Text('Good quality dal!'), // Simple text review
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}