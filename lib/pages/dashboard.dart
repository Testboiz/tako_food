import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          leading: const Icon(
            Icons.location_on,
            size: 40,
          ),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Antar ke",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "Rumah Saya",
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Placeholder()),
                );
              },
              icon: const Icon(
                Icons.shopping_cart,
                size: 30,
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: 0,
            fixedColor: Colors.black,
            items: const [
              BottomNavigationBarItem(
                label: "Pesan",
                icon: Icon(Icons.restaurant),
              ),
              BottomNavigationBarItem(
                label: "History",
                icon: Icon(Icons.text_snippet),
              ),
              BottomNavigationBarItem(
                label: "Payment",
                icon: Icon(Icons.credit_card),
              ),
              BottomNavigationBarItem(
                label: "Profile",
                icon: Icon(Icons.account_circle),
              ),
            ],
            onTap: (int indexOfItem) {
              Widget page = widget;
              switch (indexOfItem) {
                case 1:
                  page = const DashboardPage();
                  break;
                case 2:
                  page = const Placeholder();
                  break;
                case 3:
                  page = const Placeholder();
                  break;
                case 4:
                  page = const Placeholder();
                  break;
                default:
              }
              if (page != widget) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              }
            }),
        body: const Placeholder());
  }
}
