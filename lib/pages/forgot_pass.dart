import 'package:flutter/material.dart';

import '../provider/auth_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final AuthService _auth = AuthService();

  Future<void> _resetPassword() async {
    _auth.sendEmailforResetPassword(_emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          title: const Text('Lupa Password'),
          surfaceTintColor: Colors.transparent),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 115,
                  backgroundImage: AssetImage('assets/img/logo.png'),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: screenWidth * 0.8,
                  child: Column(
                    children: [
                      const Text(
                        'Lupa Password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Masukkan email Anda dan ikuti langkah-langkahnya untuk reset password.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 36),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Masukkan Email',
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
                      const SizedBox(height: 24),
                      SizedBox(
                        width: screenWidth * 0.6,
                        child: ElevatedButton(
                          onPressed: _resetPassword,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Reset Password'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
