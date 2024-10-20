import 'package:flutter/material.dart';
import 'package:tako_food/components/design_components.dart';

class ScaffoldComponents {
  static int navigationIndex = 0;
  static AppBar generateAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      forceMaterialTransparency: true,
      leading: Opacity(
        opacity: 0.75,
        child: Icon(
          Icons.location_on,
          size: 40,
          color: DesignComponents.gacoanPink,
        ),
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dikirim dari : ",
            style: TextStyle(fontFamily: 'gotham', fontSize: 19),
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
          icon: Opacity(
            opacity: 0.75,
            child: Icon(
              Icons.shopping_cart,
              size: 30,
              color: DesignComponents.gacoanPink,
            ),
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
      currentIndex: navigationIndex,
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
          navigationIndex = indexOfItem;
        }
      },
    );
  }
}
