import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tako_food/components/scaffold_components.dart';
import 'package:tako_food/provider/product_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  ProductService productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScaffoldComponents.generateAppBar(context),
      bottomNavigationBar: ScaffoldComponents.generateNavigationBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: [
                    Image.asset('assets/img/gacoan slider 1.jpg'),
                    Image.asset('assets/img/gacoan slider 2.jpg'),
                    Image.asset('assets/img/gacoan promo 1.jpg')
                  ],
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Mie Gacoan",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text("Menu signature kami, gaskan"),
                productService.generateProductCards("noodle gacoan"),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Mie Hompimpa",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text("Bagi kalian yang pengen pedasnya lebih berasa"),
                productService.generateProductCards("noodle hompimpa"),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Mie Suit",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text("Untuk kalian yang tidak suka pedas"),
                productService.generateProductCards("noodle"),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Dimsum",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text("Krenyes krenyes pendamping kalian saat makan mie"),
                productService.generateProductCards("dimsum"),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Minuman",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text("Cobain nih, minum yang seger seger"),
                productService.generateProductCards("fruit drink"),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
