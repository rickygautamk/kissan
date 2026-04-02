import 'package:flutter/material.dart';
import 'account_page.dart'; // Import the AccountPage
import 'home_page.dart';
import 'fruit_page.dart';
import 'vegetable_page.dart';
import 'grains_page.dart';
import 'cart_page.dart';
import 'favourite_page.dart';
import 'search_page.dart'; // Import your search page

class MainScreenPage extends StatefulWidget {
  const MainScreenPage({Key? key}) : super(key: key);

  @override
  State<MainScreenPage> createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  int _selectedIndex = 0;
  // Store cart items and quantities
  final List<Map<String, dynamic>> cartItems = [];
  // Store the quantity of each item in the cart
  final Map<String, int> cartQuantities = {};
  // Store favorite items
  final List<Map<String, dynamic>> favoriteItems = [];

  // Make _widgetOptions a getter to access cartItems, etc.
  List<Widget> get _widgetOptions => <Widget>[
    HomePage(
        cartItems: cartItems,
        cartQuantities: cartQuantities,
        favoriteItems: favoriteItems),
    FruitPage(
        cartItems: cartItems,
        cartQuantities: cartQuantities,
        favoriteItems: favoriteItems),
    VegetablePage(
        cartItems: cartItems,
        cartQuantities: cartQuantities,
        favoriteItems: favoriteItems),
    GrainsPage(
        cartItems: cartItems,
        cartQuantities: cartQuantities,
        favoriteItems: favoriteItems),
    const SearchPage(), // Include the SearchPage
    CartPage(cartItems: cartItems, cartQuantities: cartQuantities),
    FavouritePage(favoriteItems: favoriteItems),
    const AccountPage(), // Include the AccountPage
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag), // Changed to shopping_bag
            label: 'Fruits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist), // Changed to local_florist
            label: 'Vegetables',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rice_bowl), // Changed to rice_bowl
            label: 'Grains',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}