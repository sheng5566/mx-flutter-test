import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mxtest/core/constant/constants.dart';
import 'package:mxtest/products/presentation/widget/productPage.dart';

import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../injection_container.dart';
import '../../domain/entities/products.dart';
import '../../domain/entities/rating.dart';

class ProductListTile extends StatefulWidget {
  final Product product;
  final bool? isCartList;
  const ProductListTile({super.key, required this.product, this.isCartList});

  @override
  State<ProductListTile> createState() => _ProductListTileState();
}

class _ProductListTileState extends State<ProductListTile> {
  final CartBloc _cartBloc = serviceLocator<CartBloc>();

  bool isCartList = false;

  // final int count = rating.count;
  void handleNavigateProductPage(Product product) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductPage(product: product)));
  }

  @override
  void initState() {
    isCartList = widget.isCartList != null;

    super.initState();
  }

  @override
  void dispose() {
    _cartBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String imageUrl = widget.product.image;
    final String productName = widget.product.title;
    final double productPrice = widget.product.price;
    final Rating rating = widget.product.rating;
    final double rate = rating.rate;
    final isAddedInCart = Constant.cartList.contains(widget.product.id);

    void handleUpdateCart() {
      if (isCartList) {
        _cartBloc.add(RemoveFromCartRequest(productId: widget.product.id));
      } else {
        if (isAddedInCart) {
          _cartBloc.add(RemoveFromCartRequest(productId: widget.product.id));
        } else {
          _cartBloc.add(AddToCartRequest(productId: widget.product.id));
        }
      }
    }

    Widget ratingRow = Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: isCartList
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        children: [
          isCartList
              ? Container()
              : Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange),
                    Text(
                      rate.toString(),
                      style: const TextStyle(color: Colors.orange),
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
    return BlocProvider(
      create: (context) => _cartBloc,
      child: BlocListener<CartBloc, CartState>(
        bloc: _cartBloc,
        listener: (context, state) {
          if (state is AddToCartSuccess) {
            if (state.isSuccess) {
              setState(() {
                Constant.cartList.add(widget.product.id);
              });
            }
          }
          if (state is RemoveFromCartSuccess) {
            setState(() {
              Constant.cartList.removeWhere((id) => id == state.productId);
            });
          }
          // TODO: implement listener
        },
        child: GFListTile(
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
          onTap: () => handleNavigateProductPage(widget.product),
          icon: IconButton(
            icon: isCartList
                ? Icon(
                    Icons.delete,
                    color: Colors.red,
                  )
                : Icon(
                    isAddedInCart
                        ? Icons.shopping_cart_rounded
                        : Icons.shopping_cart_outlined,
                    color: isAddedInCart ? Colors.orange : Colors.grey,
                  ),
            onPressed: handleUpdateCart,
          ),
        ),
      ),
    );
  }
}
