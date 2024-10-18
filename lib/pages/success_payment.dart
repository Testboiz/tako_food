import 'package:flutter/material.dart';
import 'package:tako_food/components/scaffold_components.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: ScaffoldComponents.generateAppBar(context),
        bottomNavigationBar: ScaffoldComponents.generateNavigationBar(context),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const Text("Payment Successful"),
                Image.asset("assets/img/check.png"),
                const Text("Terima Kasih sudah memesan"),
                const Text(
                    "Harap menunggu panggilan untuk mengambil makanan Anda"),
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName("/dashboard"));
                  },
                  child: const Text("Kembali ke Menu"),
                )
              ],
            ),
          ),
        ),
      ),
      onPopInvokedWithResult: (didpop, result) =>
          Navigator.popUntil(context, ModalRoute.withName("/dashboard")),
    );
  }
}
