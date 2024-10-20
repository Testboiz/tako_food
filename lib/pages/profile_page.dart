import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tako_food/components/scaffold_components.dart';
import 'package:tako_food/provider/sales_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    SalesService salesService = SalesService();
    TextEditingController referralController = TextEditingController();
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
              "Profil",
              style: TextStyle(fontFamily: 'gotham', fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 295,
                  height: 50,
                  child: TextField(
                    controller: referralController,
                    decoration: InputDecoration(
                      labelText: "Kode Referral",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    if (referralController.text == "myref") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Kode referal masuk \nTeman Anda akan mendapat diskon 100%"),
                        ),
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontFamily: 'gotham medium',
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Konfirmasi"),
                      content: const Text(
                          "Apakah anda yakin untuk menghapus riwayat pesanan anda?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            salesService.deleteSalesHistory(_user!.uid);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Riwayat Pesanan dihapus!"),
                              ),
                            );
                            Navigator.of(context).pop();
                          },
                          child: const Text("Iya"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Tidak"),
                        )
                      ],
                    );
                  },
                );
              },
              style: OutlinedButton.styleFrom(
                overlayColor: Colors.red,
                side: const BorderSide(color: Colors.red),
              ),
              child: const Text(
                "Hapus riwayat pembelian",
                style:
                    TextStyle(fontFamily: 'gotham medium', color: Colors.black),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                overlayColor: Colors.red,
                side: const BorderSide(color: Colors.red),
              ),
              child: const Text(
                "Logout",
                style:
                    TextStyle(fontFamily: 'gotham medium', color: Colors.black),
              ),
            )
          ],
        ),
      )),
    );
  }
}
