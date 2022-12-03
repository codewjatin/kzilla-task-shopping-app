import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/components/product_card.dart';
import 'package:shopping_app/model/shop_model.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopModel>(
      builder: (context, shop, child) {
        final products = shop.products;
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 300,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCard(
              product: products[index],
            );
          },
        );
      },
    );
  }
}
