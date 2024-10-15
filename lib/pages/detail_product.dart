import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tako_food/components/scaffold_components.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final TextEditingController noteController = TextEditingController();
  final List<int> spiceLevel = [1, 2, 3];
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
                  items: const [Placeholder(), Placeholder(), Placeholder()],
                  options: CarouselOptions(viewportFraction: 1, autoPlay: true),
                ),
                const SizedBox(height: 20),
                const Text("Mie Suit"),
                const Text("""
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."""),
                const SizedBox(height: 20),
                const Text("Rp 10.000"),
                const SizedBox(height: 20),
                const Text("Tingkat Kepedasan"),
                const SizedBox(height: 20),
                SizedBox(
                    height: 30,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: spiceLevel.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          log(index.toString());
                          return ElevatedButton(
                              onPressed: () {},
                              child: Text(spiceLevel[index].toString()));
                        })),
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
