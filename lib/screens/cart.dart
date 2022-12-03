import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/components/cart_item.dart';
import 'package:shopping_app/model/shop_model.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ShopModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Cart",
              style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Total: Rs. ${model.cartTotal}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Consumer<ShopModel>(
              builder: (context, shop, child) {
                final cart = shop.cart.values.toList();
                return ListView.builder(
                  itemCount: cart.length,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemBuilder: (context, index) {
                    return CartItemView(
                      cart: cart[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
