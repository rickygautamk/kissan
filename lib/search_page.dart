// lib/search_page.dart

import 'package:flutter/material.dart';

// Import all item pages
import 'apple_page.dart';
import 'banana_page.dart';
import 'basmati_rice_page.dart';
import 'beans_page.dart';
import 'brinjal_page.dart';
import 'carrot_page.dart';
import 'cauliflower_page.dart';
import 'chillies_page.dart';
import 'custard_apple_page.dart';
import 'green_gram_page.dart';
import 'guava_page.dart';
import 'jowar_page.dart';
import 'ladys_finger_page.dart';
import 'mangoes_page.dart';
import 'onions_page.dart';
import 'orange_page.dart';
import 'papaya_page.dart';
import 'pine_apple_page.dart';
import 'raagi_page.dart';
import 'red_gram_page.dart';
import 'tomato_page.dart';
import 'toor_dal_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchTerm = '';

  // Define all items here
  final List<Map<String, dynamic>> _items = [
    // Fruits
    {'name': 'Apple', 'category': 'Fruits', 'image': 'assets/images/fruits/apple.jpg', 'price': 2.99},
    {'name': 'Banana', 'category': 'Fruits', 'image': 'assets/images/fruits/banana.jpg', 'price': 0.99},
    {'name': 'Custard Apple', 'category': 'Fruits', 'image': 'assets/images/fruits/custard.jpg', 'price': 4.99},
    {'name': 'Guava', 'category': 'Fruits', 'image': 'assets/images/fruits/guava.jpg', 'price': 1.99},
    {'name': 'Mangoes', 'category': 'Fruits', 'image': 'assets/images/fruits/mangoes.jpg', 'price': 3.99},
    {'name': 'Orange', 'category': 'Fruits', 'image': 'assets/images/fruits/orange.jpg', 'price': 2.49},
    {'name': 'Papaya', 'category': 'Fruits', 'image': 'assets/images/fruits/papaya.jpg', 'price': 2.99},
    {'name': 'Pine Apple', 'category': 'Fruits', 'image': 'assets/images/fruits/pineapple.jpg', 'price': 3.49},

    // Vegetables
    {'name': 'Beans', 'category': 'Vegetables', 'image': 'assets/images/vegetables/beans.jpg', 'price': 1.49},
    {'name': 'Brinjal', 'category': 'Vegetables', 'image': 'assets/images/vegetables/brinjal.jpg', 'price': 1.99},
    {'name': 'Carrot', 'category': 'Vegetables', 'image': 'assets/images/vegetables/carrot.jpg', 'price': 0.99},
    {'name': 'Cauliflower', 'category': 'Vegetables', 'image': 'assets/images/vegetables/cauliflower.jpg', 'price': 1.79},
    {'name': 'Chillies', 'category': 'Vegetables', 'image': 'assets/images/vegetables/chillies.jpg', 'price': 0.79},
    {'name': 'Lady\'s Finger', 'category': 'Vegetables', 'image': 'assets/images/vegetables/ladyfinger.jpg', 'price': 1.59},
    {'name': 'Onions', 'category': 'Vegetables', 'image': 'assets/images/vegetables/onions.jpg', 'price': 0.69},
    {'name': 'Tomato', 'category': 'Vegetables', 'image': 'assets/images/vegetables/tomato.jpg', 'price': 1.99},

    // Grains
    {'name': 'Basmati Rice', 'category': 'Grains', 'image': 'assets/images/grains/basmati_rice.jpg', 'price': 5.99},
    {'name': 'Green Gram', 'category': 'Grains', 'image': 'assets/images/grains/green_gram.jpg', 'price': 3.49},
    {'name': 'Jowar', 'category': 'Grains', 'image': 'assets/images/grains/jowar.jpg', 'price': 2.99},
    {'name': 'Raagi', 'category': 'Grains', 'image': 'assets/images/grains/raagi.jpg', 'price': 2.49},
    {'name': 'Red Gram', 'category': 'Grains', 'image': 'assets/images/grains/red_gram.jpg', 'price': 4.49},
    {'name': 'Toor Dal', 'category': 'Grains', 'image': 'assets/images/grains/toor_dal.jpg', 'price': 3.99},
  ];

  List<Map<String, dynamic>> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _items; // Initially show all items
  }

  void _filterItems(String searchTerm) {
    setState(() {
      _searchTerm = searchTerm;
      _filteredItems = _items.where((item) =>
          item['name'].toLowerCase().contains(searchTerm.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'I am Looking for.....',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(),
                ),
              ),
              onChanged: _filterItems,
            ),
          ),
          Expanded(
            child: _filteredItems.isNotEmpty
                ? ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                return ListTile(
                  leading: Image.asset(item['image']),
                  title: Text(item['name']),
                  subtitle: Text(item['category']),
                  trailing: Text('\$${item['price'].toStringAsFixed(2)}'),
                  onTap: () {
                    // Navigate to the item page
                    _navigateToItemPage(item['name']);
                  },
                );
              },
            )
                : const Center( // Show "Item not found" message
              child: Text(
                "Item not found",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Navigate to the item page based on the item name
  void _navigateToItemPage(String itemName) {
    Widget page; // Declare a non-nullable Widget variable

    switch (itemName) {
    // Fruits
      case 'Apple':
        page = ApplePage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;
      case 'Banana':
        page = BananaPage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;
      case 'Custard Apple':
        page = CustardApplePage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;
      case 'Guava':
        page = GuavaPage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;
      case 'Mangoes':
        page = MangoesPage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;
      case 'Orange':
        page = OrangePage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;
      case 'Papaya':
        page = PapayaPage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;
      case 'Pine Apple':
        page = PineApplePage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;

    // Vegetables
      case 'Beans':
        page = BeansPage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;
      case 'Brinjal':
        page = BrinjalPage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;
      case 'Carrot':
        page = CarrotPage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;
      case 'Cauliflower':
        page = CauliflowerPage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;
      case 'Chillies':
        page = ChilliesPage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;
      case 'Lady\'s Finger':
        page = LadysFingerPage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;
      case 'Onions':
        page = OnionsPage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;
      case 'Tomato':
        page = TomatoPage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;

    // Grains
      case 'Basmati Rice':
        page = BasmatiRicePage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;
      case 'Green Gram':
        page = GreenGramPage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;
      case 'Jowar':
        page = JowarPage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;
      case 'Raagi':
        page = RaagiPage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;
      case 'Red Gram':
        page = RedGramPage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;
      case 'Toor Dal':
        page = ToorDalPage(cartItems: [], cartQuantities: {}, favoriteItems: []);
        break;
      default:
      // If the item is not found, show a snackbar and return an empty Container
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Item not found"),
        ));
        page = Container(); // Assign an empty Container to page
    }

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }
}