import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tako_food/components/design_components.dart';
import 'package:tako_food/components/scaffold_components.dart';
import 'package:tako_food/provider/cart_provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: ScaffoldComponents.generateAppBar(context),
      bottomNavigationBar: ScaffoldComponents.generateNavigationBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Stack(
            children: [
              Column(
                children: [
                  const Text(
                    "QR Payment",
                    style: TextStyle(fontFamily: 'gotham', fontSize: 20),
                  ),
                  const Text(
                    "Silahkan Scan kode QRIS berikut dengan aplikasi e-wallet kalian",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'gotham medium'),
                  ),
                  const SizedBox(height: 10),
                  QrImageView(
                    data: '1234567890',
                    version: 5,
                    size: 300.0,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Disclaimer : Ini hanyalah kode QRIS simulasi, tidak ada penarikan uang sama sekali",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'gotham medium',
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/payment/success');
                      cartProvider.buy();
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        width: 3.0,
                        color: DesignComponents.gacoanPink,
                      ),
                    ),
                    child: Text(
                      "Konfirmasi Pembayaran",
                      style: TextStyle(
                        fontFamily: 'gotham medium',
                        color: DesignComponents.gacoanPink,
                      ),
                    ),
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
