import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tako_food/components/scaffold_components.dart';
import 'package:tako_food/model/cart_item.dart';
import 'package:tako_food/provider/cart_service.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final User? _user = FirebaseAuth.instance.currentUser;
  final CartService _cartService = CartService();
  List<CartItem> cart = [];
  @override
  void initState() {
    // TODO: implement initState and maybe use FutureBuilder
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScaffoldComponents.generateAppBar(context),
      bottomNavigationBar: ScaffoldComponents.generateNavigationBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text("Keranjang Saya"),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      height: 700,
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Placeholder(),
                                  ),
                                  const Expanded(
                                      child: Padding(
                                    // maybe try sizedbox?
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Mie Suit"),
                                        Text("Rp 10.500"),
                                        Text("Note :"),
                                        Text(
                                          "notes here \n ",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  )),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add),
                                  ),
                                  const Text("1"),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.remove),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Beli Sekarang"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
