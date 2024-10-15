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
                  items: const [Placeholder(), Placeholder(), Placeholder()],
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
                const Card(
                  child: Column(
                    children: [
                      Placeholder(
                        fallbackHeight: 200,
                        fallbackWidth: 200,
                      ),
                      Text(
                        "Mie Gacoan",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Rp. 12.000",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Mie Hompimpa",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text("Bagi kalian yang pengen pedasnya lebih berasa"),
                productService.generateProductCards(),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Mie Suit",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text("Untuk kalian yang tidak suka pedas"),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Dimsum",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text("Krenyes krenyes pendamping kalian saat makan mie"),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Minuman",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text("Cobain nih, minum yang seger seger"),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
