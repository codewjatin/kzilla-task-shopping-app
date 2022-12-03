import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/model/shop_model.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopModel>(
      builder: (context, shop, child) {
        final favourites = shop.favourites.values.toList();
        return ListView.builder(
          itemCount: favourites.length,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          itemBuilder: (context, index) {
            final item = favourites[index];
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              minLeadingWidth: 68,
              trailing: IconButton(
                onPressed: () {
                  Provider.of<ShopModel>(context, listen: false)
                      .toggleFavourites(item);
                },
                icon: Icon(
                  CupertinoIcons.delete,
                  color: Colors.red.shade900,
                ),
                tooltip: "Delete from favourites",
              ),
              title: Text(
                item.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "\$ ${item.price.toStringAsFixed(1)}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
