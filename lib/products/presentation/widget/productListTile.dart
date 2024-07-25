import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../../domain/entities/products.dart';
import '../../domain/entities/rating.dart';

class ProductListTile extends StatelessWidget {
  final Product product;
  const ProductListTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = product.image;
    final String productName = product.title;
    final double productPrice = product.price;
    final Rating rating = product.rating;
    final double rate = rating.rate;
    final int count = rating.count;

    Widget ratingRow = Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.star, color: Colors.orange),
              Text(
                rate.toString(),
                style: TextStyle(color: Colors.orange),
              )
            ],
          ),

          Text('RM ${productPrice.toStringAsFixed(2)}')
          // Text(
          //   "Rate Count ${count}",
          //   style: TextStyle(color: Colors.orange),
          // )
        ],
      ),
    );
    return GFListTile(
      avatar: GFAvatar(
        child: GFImageOverlay(
            height: 200, width: 300, image: NetworkImage(imageUrl)),
      ),
      title: Text(
        productName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subTitle: ratingRow,
      // icon:
      // icon: const Icon(Icons.shopping_cart)
    );
  }
}
