// account_page.dart
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final user = FirebaseAuth.instance.currentUser!;
  Uint8List? _profileImagePath;

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Logout"),
              onPressed: () {
                _logout();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
    );
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result!= null) {
      final imageBytes = result.files.single.bytes!;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_photos/${user.uid}.jpg');
      await storageRef.putData(imageBytes);
      final downloadURL = await storageRef.getDownloadURL();
      setState(() {
        _profileImagePath = imageBytes;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_photos/${user.uid}.jpg');
      final downloadURL = await storageRef.getDownloadURL();
      final response = await http.get(Uri.parse(downloadURL));
      setState(() {
        _profileImagePath = response.bodyBytes;
      });
    } catch (e) {
      print('Error loading profile image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _profileImagePath!= null
                        ? Image.memory(_profileImagePath!).image
                        : const AssetImage('assets/images/placeholder.jpg')
                    as ImageProvider,
                    child: _profileImagePath == null
                        ? const Icon(Icons.person)
                        : null,
                  ),
                  const Icon(Icons.edit, color: Colors.blue),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              user.displayName?? "Mahesh",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              user.email!,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text("Orders"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Order placed successfully!"),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text("Address"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () async {
                final newAddress = await _showAddressDialog(context);
                if (newAddress!= null) {
                  print("New address: $newAddress");
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                _showAboutDialog(context); // Call the function to show the about dialog
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    _showLogoutConfirmationDialog(context);
                  },
                  child: const Text("Logout"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _showAddressDialog(BuildContext context) async {
    String? houseNo;
    String? apartment;
    String? pinCode;
    String? state;
    String? country;

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enter your address"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    houseNo = value;
                  },
                  decoration: const InputDecoration(
                    hintText: "House/Flat/Block No.",
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) {
                    apartment = value;
                  },
                  decoration: const InputDecoration(
                    hintText: "Apartment/Road/Area (Optional)",
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) {
                    pinCode = value;
                  },
                  decoration: const InputDecoration(
                    hintText: "Pin Code",
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) {
                    state = value;
                  },
                  decoration: const InputDecoration(
                    hintText: "State",
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) {
                    country = value;
                  },
                  decoration: const InputDecoration(
                    hintText: "Country",
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                final address =
                    "$houseNo${apartment!= null && apartment!.isNotEmpty? ', $apartment': ''}, $pinCode, $state, $country";
                Navigator.of(context).pop(address);
              },
            ),
          ],
        );
      },
    );
  }

  // Function to show the about dialog
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("About Kisaan App"),
          content: const SingleChildScrollView(
            child: Text(
              "The Kisaan App is a revolutionary mobile application designed to bridge the gap between farmers and consumers by enabling direct transactions without intermediaries. Built using Flutter and Firebase, the app ensures a seamless and transparent marketplace where farmers can list their produce, negotiate prices, and sell directly to buyers.\n\nWith a secure authentication system, integrated digital payment options, and an AI-powered chatbot for price negotiation, Kisaan App enhances efficiency and profitability for farmers while offering consumers fresh produce at fair prices. The intuitive user interface and robust backend make the platform accessible, reliable, and scalable.\n\nBy leveraging modern technology, the Kisaan App aims to empower farmers, promote fair trade, and transform the agricultural marketplace.",
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}