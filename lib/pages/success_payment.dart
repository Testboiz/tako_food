import 'package:flutter/material.dart';
import 'package:tako_food/components/design_components.dart';
import 'package:tako_food/components/scaffold_components.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScaffoldComponents.generateAppBar(context),
      bottomNavigationBar: ScaffoldComponents.generateNavigationBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Payment Successful",
                style: TextStyle(fontFamily: 'gotham', fontSize: 20),
              ),
              const SizedBox(height: 20),
              SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset("assets/img/check.png")),
              const SizedBox(height: 20),
              const Text(
                "Terima Kasih sudah memesan",
                style: TextStyle(fontFamily: 'gotham medium'),
              ),
              const Text(
                "Harap menunggu panggilan untuk mengambil makanan Anda",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'gotham medium'),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context)
                      .popUntil((route) => route.settings.name == '/dashboard');
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    width: 3.0,
                    color: DesignComponents.gacoanPink,
                  ),
                ),
                child: Text(
                  "Kembali ke Menu",
                  style: TextStyle(
                    fontFamily: 'gotham medium',
                    color: DesignComponents.gacoanPink,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
