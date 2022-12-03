import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/model/shop_model.dart';
import 'package:shopping_app/screens/cart.dart';
import 'package:shopping_app/screens/home.dart';
import 'package:shopping_app/screens/splash.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ShopModel(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: "/splash",
      theme: ThemeData(
        textTheme: GoogleFonts.outfitTextTheme(),
      ),
      routes: {
        "/splash": (context) => const Splash(),
        "/cart": (context) => const Cart(),
      },
      home: const Home(),
    ),
  ));
}
