import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tako_food/components/design_components.dart';
import 'package:tako_food/components/scaffold_components.dart';
import 'package:tako_food/model/cart_item.dart';
import 'package:tako_food/model/product.dart';
import 'package:tako_food/provider/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartProvider>(context, listen: false).fetchCarts();
    });
  }

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
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        "Keranjang Saya",
                        style: TextStyle(fontFamily: 'gotham', fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      height: 700,
                      child: ListView.builder(
                        itemCount: cartProvider.cartItems.length,
                        itemBuilder: (context, index) {
                          CartItem cartItem = cartProvider.cartItems[index];
                          Product cartProduct =
                              Product.fromMap(cartItem.product);
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child:
                                        Image.network(cartProduct.picUrl.first),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cartProduct.name,
                                            style: const TextStyle(
                                                fontFamily: 'gotham medium'),
                                          ),
                                          Text(
                                            cartProduct.formattedCurrency,
                                            style: const TextStyle(
                                                fontFamily: 'gotham medium'),
                                          ),
                                          Visibility(
                                            visible: cartItem.notes.isNotEmpty,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Note : ${cartItem.notes}',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'gotham medium'),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      cartProvider.changeCartQuantity(
                                          cartItem, cartItem.quantity + 1);
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                  Text(cartItem.quantity.toString()),
                                  IconButton(
                                    onPressed: () {
                                      if (cartItem.quantity > 1) {
                                        cartItem.quantity;
                                        cartProvider.changeCartQuantity(
                                            cartItem, cartItem.quantity - 1);
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text("Konfirmasi"),
                                              content: const Text(
                                                  "Apakah anda yakin untuk menghapus pesanan ini?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    cartProvider.removeFromCart(
                                                        cartItem);
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
                                      }
                                    },
                                    icon: const Icon(Icons.remove),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      if (cartProvider.cartItems.isNotEmpty) {
                        Navigator.of(context).pushNamed('/payment');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Cart masih Kosong"),
                          ),
                        );
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        width: 3.0,
                        color: DesignComponents.gacoanPink,
                      ),
                    ),
                    child: Text(
                      "Beli Sekarang ${cartProvider.computeTotalAndReturnFormattedString()}",
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
