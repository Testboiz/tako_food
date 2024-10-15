import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:tako_food/pages/dashboard.dart';
import 'package:tako_food/pages/forgot_pass.dart';
import 'package:tako_food/pages/login_page.dart';
import 'package:tako_food/pages/payment_page.dart';
import 'package:tako_food/pages/profile_page.dart';
import 'package:tako_food/pages/purchase_history.dart';
import 'package:tako_food/pages/register.dart';
import 'package:tako_food/pages/success_payment.dart';
import 'package:tako_food/provider/user_provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: (create) => UserProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/register': (context) => const RegisterPage(),
        '/forgot-pass': (context) => const ForgotPasswordPage(),
        '/payment': (context) => const PaymentPage(),
        '/payment/success': (context) => const PaymentSuccessPage(),
        '/history': (context) => const PurchaseHistory(),
        '/profile': (context) => const ProfilePage(),
        '/empty': (context) => const Placeholder(),
      },
    );
  }
}
