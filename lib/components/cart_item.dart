import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/model/shop_model.dart';

class CartItemView extends StatelessWidget {
  const CartItemView({super.key, required this.cart});
  final CartItem cart;
  @override
  Widget build(BuildContext context) {
    final item = cart.item;
    final model = Provider.of<ShopModel>(context, listen: false);
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
      trailing: Wrap(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  model.decrementProductCount(item);
                },
                icon: const Icon(
                  CupertinoIcons.minus_square_fill,
                  color: Colors.black87,
                ),
              ),
              SizedBox(
                child: Text(
                  cart.count.toString().padLeft(2, "0"),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  model.addProductToCart(item);
                },
                icon: const Icon(
                  CupertinoIcons.plus_square_fill,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
      title: Text(item.name),
      subtitle: Text("Rs. ${item.price}"),
    );
  }
}
