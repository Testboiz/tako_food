import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:intl/intl.dart';
import 'package:tako_food/components/design_components.dart';
import 'package:tako_food/components/scaffold_components.dart';
import 'package:tako_food/model/sales.dart';
import 'package:tako_food/provider/product_service.dart';
import 'package:tako_food/provider/sales_service.dart';

class PurchaseHistory extends StatefulWidget {
  const PurchaseHistory({super.key});

  @override
  State<PurchaseHistory> createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  ProductService productService = ProductService();
  SalesService salesService = SalesService();
  final User? _user = FirebaseAuth.instance.currentUser;
  double value = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScaffoldComponents.generateAppBar(context),
      bottomNavigationBar: ScaffoldComponents.generateNavigationBar(context),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Riwayat Pembelian",
                  style: TextStyle(fontFamily: 'gotham', fontSize: 20),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 400,
                  height: 650,
                  child: FutureBuilder(
                      future: salesService.getSales(_user!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text(
                                  'Error: ${snapshot.error}')); // Show error if fetching failed
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text(
                                  'Product Kosong')); // Show error if fetching failed
                        } else {
                          List<Sales> sales = snapshot.data!;
                          sales.sort(
                              (a, b) => (b.saleDate.compareTo(a.saleDate)));
                          List<Map<String, dynamic>> salesDataFlattened = [];

                          for (Sales sale in sales) {
                            salesDataFlattened.addAll(sale.toPurchasesMap());
                          }
                          return ListView.builder(
                            itemCount: salesDataFlattened.length,
                            itemBuilder: (context, index) {
                              String datestr =
                                  salesDataFlattened[index]["date"];
                              DateTime dateTime = DateTime.parse(datestr);
                              String formattedDate =
                                  DateFormat('d MMMM y HH:mm').format(dateTime);
                              return GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                          builder: (context, modalSetState) {
                                        return SizedBox(
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text(
                                                "Berikan Rating",
                                                style: TextStyle(
                                                    fontFamily: 'gotham',
                                                    fontSize: 19),
                                              ),
                                              const SizedBox(width: 10),
                                              StarRating(
                                                  rating: value,
                                                  allowHalfRating: false,
                                                  onRatingChanged: (rating) {
                                                    modalSetState(
                                                        () => value = rating);
                                                  }),
                                              const SizedBox(width: 20),
                                              OutlinedButton(
                                                onPressed: () {
                                                  productService.giveRating(
                                                      salesDataFlattened[index]
                                                              ["item"]
                                                          ['product']['name'],
                                                      value);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          "Terima kasih atas rating anda"),
                                                    ),
                                                  );
                                                  Navigator.of(context).pop();
                                                },
                                                style: OutlinedButton.styleFrom(
                                                  side: BorderSide(
                                                    width: 2.0,
                                                    color: DesignComponents
                                                        .gacoanPink,
                                                  ),
                                                ),
                                                child: Text(
                                                  "Submit Rating",
                                                  style: TextStyle(
                                                    fontFamily: 'gotham medium',
                                                    color: DesignComponents
                                                        .gacoanPink,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                    },
                                  );
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Image.network(
                                              salesDataFlattened[index]["item"]
                                                      ['product']['pic_url']
                                                  .first),
                                        ),
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                salesDataFlattened[index]
                                                    ["item"]['product']['name'],
                                                style: const TextStyle(
                                                  fontFamily: 'gotham medium',
                                                ),
                                              ),
                                              Text(
                                                formattedDate,
                                                style: const TextStyle(
                                                  fontFamily: 'gotham medium',
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }),
                )
              ],
            )),
      ),
    );
  }
}
