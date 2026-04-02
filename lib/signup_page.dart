// lib/signup_page.dart

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisaan/mainscreen_page.dart';
import 'package:kisaan/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}): super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _createUserWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Check if email already exists
        final list = await FirebaseAuth.instance
            .fetchSignInMethodsForEmail(_emailController.text);

        if (list.isNotEmpty) {
          // User already exists, show snackbar and redirect to login page after a delay
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The account already exists for that email."),
          ));

          Timer(const Duration(seconds: 2), () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ));
          });

          return;
        }

        // If email doesn't exist, proceed with creating the user
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Update the user's profile with the display name
        await credential.user?.updateDisplayName(_nameController.text);

        // Navigate to MainScreenPage after successful signup
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MainScreenPage(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The password provided is too weak."),
          ));
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The account already exists for that email."),
          ));
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "sign up",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Hello Welcome!",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  onPressed: _createUserWithEmailAndPassword,
                  child: const Text("Sign up"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}