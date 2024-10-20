import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tako_food/components/design_components.dart';
import 'package:tako_food/model/cart_item.dart';
import 'package:tako_food/model/product.dart';
import 'package:tako_food/provider/cart_provider.dart';

class ProductService {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('products');
  final User? _user = FirebaseAuth.instance.currentUser;

  void addProduct(Product product) async {
    await _products
        .add(product.toMap())
        .then((value) => log("Success"))
        .catchError((err) => log("Something Went Wrong : $err"));
  }

  Future<List<Product>> getProducts(String type) async {
    try {
      final QuerySnapshot snapshot =
          await _products.where('type', isEqualTo: type).get();

      return snapshot.docs
          .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (err) {
      log("Something Went Wrong : $err");
      return [];
    }
  }

  FutureBuilder<List<Product>> generateProductCards(String type) {
    return FutureBuilder(
      future: getProducts(type),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
                  'Error: ${snapshot.error}')); // Show error if fetching failed
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text('Product Kosong')); // Show error if fetching failed
        } else {
          return SizedBox(
            width: 500,
            height: 280,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Product product = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          final cartProvider =
                              Provider.of<CartProvider>(context);
                          TextEditingController noteController =
                              TextEditingController();
                          int selectedSpice = product.spiceLevel[0];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                    fontFamily: 'gotham', fontSize: 19),
                              ),
                              Text(
                                product.formattedCurrency,
                                style: TextStyle(
                                    color: DesignComponents.gacoanPink,
                                    fontSize: 20),
                              ),
                              Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.star),
                                    Text(product.rating.toString())
                                  ],
                                ),
                              ),
                              Text(
                                product.description,
                                style: const TextStyle(
                                    fontFamily: 'gotham medium'),
                              ),
                              Visibility(
                                visible: product.spiceLevel.length > 1,
                                child: Column(
                                  children: [
                                    const Text("Level Pedas"),
                                    const SizedBox(height: 5),
                                    Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 5,
                                      children: product.spiceLevel
                                          .map(
                                            (e) => IconButton(
                                              onPressed: () {
                                                selectedSpice = e;
                                              },
                                              highlightColor: Colors.black26,
                                              style: IconButton.styleFrom(
                                                shape: const CircleBorder(),
                                                padding: EdgeInsets.zero,
                                                backgroundColor: Colors.black12,
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                              ),
                                              icon: Text(
                                                e.toString(),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: "Pesan",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                ),
                                controller: noteController,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: TextButton(
                                  onPressed: () {
                                    String spiceNotes = "";
                                    if (selectedSpice > 0) {
                                      // if theres spice option, add spice notes

                                      spiceNotes = "Level $selectedSpice";
                                      if (noteController.text.isNotEmpty) {
                                        spiceNotes = '$spiceNotes\n';
                                      }
                                      noteController.text =
                                          spiceNotes + noteController.text;
                                    }
                                    int cartQuantity = 1;
                                    for (CartItem item
                                        in cartProvider.cartItems) {
                                      if (item.product['name'] ==
                                          product.name) {
                                        cartQuantity = item.quantity;
                                      }
                                    }
                                    cartProvider.addToCart(
                                      CartItem(
                                        userId: _user!.uid,
                                        product: product.toMap(),
                                        quantity: cartQuantity,
                                        notes: noteController.text,
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("Ditambahkan ke Keranjang!"),
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Tambahkan ke keranjang",
                                    style: TextStyle(
                                        fontFamily: 'gotham medium',
                                        color: DesignComponents.gacoanPink),
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            product.picUrl[0],
                            width: 200,
                            height: 200,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            product.name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            product.formattedCurrency,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
