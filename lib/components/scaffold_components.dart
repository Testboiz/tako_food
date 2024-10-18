import 'package:flutter/material.dart';

class ScaffoldComponents {
  static AppBar generateAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      surfaceTintColor: Colors.transparent,
      leading: const Icon(
        Icons.location_on,
        size: 40,
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dikirim dari : ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "Mie Gacoan Indonesia : Daan Mogot ",
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            final route = ModalRoute.of(context) as MaterialPageRoute?;
            final routeName = route?.settings.name;
            if (routeName != "/cart-page") {
              Navigator.pushNamed(context, "/cart-page");
            }
          },
          icon: const Icon(
            Icons.shopping_cart,
            size: 30,
          ),
        )
      ],
    );
  }

  static BottomNavigationBar generateNavigationBar(BuildContext context) {
    final route = ModalRoute.of(context) as MaterialPageRoute?;
    final routeName = route?.settings.name;

    return BottomNavigationBar(
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
          label: "Profile",
          icon: Icon(Icons.account_circle),
        ),
      ],
      onTap: (int indexOfItem) {
        String page = routeName ?? "/";
        switch (indexOfItem) {
          case 0:
            page = '/dashboard';
            break;
          case 1:
            page = '/history';
            break;
          case 2:
            page = '/profile';
            break;
          default:
        }
        if (routeName != page) {
          Navigator.pushNamed(context, page);
        }
      },
    );
  }
}
