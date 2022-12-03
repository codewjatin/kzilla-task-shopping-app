import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/screens/favourites.dart';
import 'package:shopping_app/screens/products.dart';

Map<String, Widget> screens = {
  "Products": const Products(),
  "Favourites": const Favourites(),
};

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              screens.keys.elementAt(_selectedIndex),
              style: const TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: screens.values.elementAt(_selectedIndex),
          )
        ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: SizedBox(
        width: 350,
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: const Color.fromARGB(40, 255, 255, 255),
            labelTextStyle: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                );
              }
              return const TextStyle(
                color: Colors.white,
              );
            }),
            iconTheme: MaterialStateProperty.resolveWith((states) {
              return const IconThemeData(
                color: Colors.white,
                size: 28,
              );
            }),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          ),
          child: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            backgroundColor: Colors.black,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_sharp),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(CupertinoIcons.suit_heart),
                selectedIcon: Icon(CupertinoIcons.suit_heart_fill),
                label: 'Favourites',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

PreferredSizeWidget appBar(BuildContext context) {
  return AppBar(
    title: const Text("Shopping App"),
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    elevation: 0,
    leading: Padding(
      padding: const EdgeInsets.only(left: 12),
      child: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.person_outline,
          color: Colors.black,
          size: 28,
        ),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 12),
        child: IconButton(
          onPressed: () => Navigator.pushNamed(context, "/cart"),
          icon: const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.black,
            size: 28,
          ),
        ),
      )
    ],
  );
}
