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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Informasi"),
                              content: const Text(
                                  "Silahkan ke kasir dan tunjukkan kode pemesanan PXYZS"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .popAndPushNamed('/payment/success');
                                    cartProvider.buy();
                                  },
                                  child: const Text("Oke"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          width: 3.0,
                          color: DesignComponents.gacoanPink,
                        ),
                      ),
                      child: Text(
                        "Bayar dengan Cash",
                        style: TextStyle(
                          fontFamily: 'gotham medium',
                          color: DesignComponents.gacoanPink,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "Masukkan Info Kartu",
                                      style: TextStyle(
                                        fontFamily: 'gotham',
                                        fontSize: 19,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    TextField(
                                      decoration: InputDecoration(
                                        label: const Text("Card Number"),
                                        prefixIcon:
                                            const Icon(Icons.credit_card),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20),
                                        filled: true,
                                        fillColor:
                                            Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 265,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              label: const Text("Expiry Date"),
                                              prefixIcon: const Icon(
                                                  Icons.calendar_today),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              filled: true,
                                              fillColor:
                                                  Colors.white.withOpacity(0.8),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 130,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              label: const Text("CVC"),
                                              prefixIcon:
                                                  const Icon(Icons.numbers),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              filled: true,
                                              fillColor:
                                                  Colors.white.withOpacity(0.8),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed('/payment/success');
                                          cartProvider.buy();
                                        },
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                            width: 3.0,
                                            color: DesignComponents.gacoanPink,
                                          ),
                                        ),
                                        child: Text(
                                          "Bayar",
                                          style: TextStyle(
                                            fontFamily: 'gotham medium',
                                            color: DesignComponents.gacoanPink,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          width: 3.0,
                          color: DesignComponents.gacoanPink,
                        ),
                      ),
                      child: Text(
                        "Bayar dengan Kartu Kredit",
                        style: TextStyle(
                          fontFamily: 'gotham medium',
                          color: DesignComponents.gacoanPink,
                        ),
                      ),
                    ),
                    OutlinedButton(
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
                        "Konfirmasi Pembayaran dengan QRIS",
                        style: TextStyle(
                          fontFamily: 'gotham medium',
                          color: DesignComponents.gacoanPink,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
