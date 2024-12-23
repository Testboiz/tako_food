// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tako_food/provider/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final AuthService _authService = AuthService();

  Future<void> _register() async {
    final email = _emailController.text;
    final pass = _passwordController.text;
    final nama = _namaController.text;

    final user =
        await _authService.registerWithEmailUserAndPass(email, nama, pass);
    if (user != null) {
      user.updateDisplayName(nama);
      log('user registered with uid : ${user.uid}');
    } else if (user == null) {
      log('Registration Failed');
    } else {
      log("You caught an ultra rare error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _namaController,
              decoration: InputDecoration(
                labelText: 'Nama',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  try {
                    await _register();
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("[${e.code}] Email atau Password salah"),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Email atau Password salah"),
                      ),
                    );
                  }
                  Navigator.pushReplacementNamed(context, '/');
                },
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(const Size(240, 42)),
                  padding: WidgetStateProperty.all(
                      const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                  elevation: WidgetStateProperty.all(2),
                ),
                child: const Text('Register'),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
