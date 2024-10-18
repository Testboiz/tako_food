import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
    final cartProvider = Provider.of<CartProvider>(context);
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
                  const Text("QR Payment"),
                  const Text(
                      "Silahkan Scan kode QRIS berikut dengan aplikasi e-wallet kalian"),
                  const Text("MIE GACOAN INDONESIA"),
                  QrImageView(
                    data: '1234567890',
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  const Text("Disclaimer :"),
                  const Text(
                      "Ini hanyalah kode QRIS simulasi, tidak ada penarikan uang sama sekali"),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    cartProvider.buy();
                    Navigator.of(context).pushNamed('/payment/success');
                  },
                  child: const Text("Konfirmasi Pembayaran"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
