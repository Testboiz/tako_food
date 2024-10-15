import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tako_food/components/scaffold_components.dart';
import 'package:tako_food/model/product.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final TextEditingController noteController = TextEditingController();
  int selectedSpice = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScaffoldComponents.generateAppBar(context),
      bottomNavigationBar: ScaffoldComponents.generateNavigationBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: widget.product.picUrl
                      .map(
                        (item) => Image.network(
                          item,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(viewportFraction: 1, autoPlay: true),
                ),
                const SizedBox(height: 20),
                Text(widget.product.name),
                Text(widget.product.description),
                const SizedBox(height: 20),
                Text("Rating : ${widget.product.rating}"),
                // TODO : actual stars
                const SizedBox(height: 20),
                Text(widget.product.formattedCurrency),
                Visibility(
                  visible: widget.product.picUrl.length > 1,
                  child: SizedBox(
                    height: 30,
                    width: double.infinity,
                    child: Column(
                      children: [
                        const Text("Tingkat Kepedasan"),
                        const SizedBox(height: 20),
                        ListView.builder(
                          itemCount: widget.product.spiceLevel.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ElevatedButton(
                              onPressed: () {
                                selectedSpice = index;
                              },
                              child: Text(
                                widget.product.spiceLevel[index].toString(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Pesan tambahan :"),
                TextField(
                  controller: noteController,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Tambahkan ke keranjang")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
