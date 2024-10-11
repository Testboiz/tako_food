// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tako_food/model/user.dart';
import 'package:tako_food/pages/forgot_pass.dart';
import 'package:tako_food/provider/auth_service.dart';
import 'package:tako_food/provider/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _auth = AuthService();

  bool _obscureText = true;

  void _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    try {
      final user = await _auth.signInWithEmailAndPassword(email, password);

      if (user != null) {
        await fetchUserData(context);
        Navigator.pushReplacementNamed(context, '/dashboard');
        log('Logged in as ${user.email}');
      } else {
        log('Login failed');
      }
    } catch (e) {
      log("$e");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: ${e.toString()}")));
    }
  }

  Future<void> fetchUserData(BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    if (currentUser != null) {
      String uid = currentUser.uid;
      Map<String, dynamic>? userData = await getData(uid);

      if (userData != null) {
        UserModel userModel = UserModel.fromMap(userData);
        userProvider.setUser(userModel);
      }
    }
  }

  Future<Map<String, dynamic>?> getData(String uid) async {
    final data =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (data.exists) {
      return data.data();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 100,
                  backgroundImage: AssetImage('assets/img/logo.png'),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage()),
                      );
                    },
                    child: const Text(
                      'Lupa Password?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(240, 42)),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 50, 63, 71)),
                    elevation: MaterialStateProperty.all(2),
                  ),
                  onPressed: () {
                    _login();
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 15,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
