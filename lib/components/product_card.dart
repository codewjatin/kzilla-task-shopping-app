import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/model/shop_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Item product;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ShopModel>(context, listen: false);
    final selected = model.favourites.containsKey(product.id);
    final itemInCart = model.cart.containsKey(product.id);
    return InkWell(
      onTap: () {},
      child: GridTile(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    product.imageUrl,
                    width: 180,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: InkWell(
                    onTap: () {
                      model.toggleFavourites(product);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Icon(
                          selected
                              ? CupertinoIcons.suit_heart_fill
                              : CupertinoIcons.suit_heart,
                          color: selected ? Colors.redAccent : Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Rs. ${product.price.toStringAsFixed(1)}",
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: itemInCart
                        ? Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  model.decrementProductCount(product);
                                },
                                icon: const Icon(
                                  CupertinoIcons.minus_square_fill,
                                  color: Colors.black,
                                  size: 28,
                                ),
                              ),
                              SizedBox(
                                child: Text(
                                  model.cart[product.id]!.count
                                      .toString()
                                      .padLeft(2, "0"),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  model.addProductToCart(product);
                                },
                                icon: const Icon(
                                  CupertinoIcons.plus_square_fill,
                                  color: Colors.black,
                                  size: 28,
                                ),
                              ),
                            ],
                          )
                        : ElevatedButton(
                            onPressed: () {
                              model.addProductToCart(product);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              fixedSize: MaterialStateProperty.all(
                                const Size(156, 48),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  // Change your radius here
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(
                                  CupertinoIcons.bag,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
