// lib/favourite_page.dart

import 'package:flutter/material.dart';

class FavouritePage extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteItems;

  const FavouritePage({super.key, required this.favoriteItems});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Favourites"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: widget.favoriteItems.length,
        itemBuilder: (context, index) {
          final item = widget.favoriteItems[index];
          return Card(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      // Check if 'image' key exists in item
                      Image.asset(
                        item['imagePath'] ?? 'assets/images/placeholder.jpg', // Placeholder image
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              widget.favoriteItems.removeAt(index);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item['name']),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}