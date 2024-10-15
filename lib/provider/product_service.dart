import 'dart:developer';
// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:tako_food/model/product.dart';
import 'package:tako_food/pages/detail_product.dart';

class ProductService {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('products');
  // final _storage = FirebaseStorage.instance;

  void addProduct(Product product) async {
    await _products
        .add(product.toMap())
        .then((value) => log("Success"))
        .catchError((err) => log("Something Went Wrong : $err"));
  }

  Future<List<Product>> getProducts() async {
    try {
      QuerySnapshot snapshot = await _products.get();
      return snapshot.docs
          .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (err) {
      log("Something Went Wrong : $err");
      return [];
    }
  }

  FutureBuilder<List<Product>> generateProductCards() {
    return FutureBuilder(
      future: getProducts(),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductDetailPage()),
                    );
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
