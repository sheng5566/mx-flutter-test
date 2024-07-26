import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../domain/entities/products.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Product product;
  @override
  void initState() {
    product = widget.product;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double productImgHeight = screenHeight * 0.4;
    void handleNavigatePop() {
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: handleNavigatePop,
        ),
      ),
      body: Column(
        children: [
          ZoomableImageWidget(
            height: productImgHeight,
            imageUrl: product.image,
          ),
          ProductTitle(
            title: product.title,
          ),
          ProductDetails(
            price: product.price,
            rating: product.rating.rate,
          ),
          GFAccordion(
              showAccordion: true,
              title: 'Descriptions',
              content: product.description,
              collapsedIcon: const Icon(Icons.keyboard_arrow_down_outlined),
              expandedIcon: const Icon(Icons.keyboard_arrow_up_outlined)),
        ],
      ),
    );
  }
}

class ZoomableImageWidget extends StatelessWidget {
  final String imageUrl;
  final double height;
  const ZoomableImageWidget(
      {super.key, required this.height, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xFF000000).withOpacity(0.88),
          offset: Offset(0, -2),
          blurRadius: 5,
          spreadRadius: 1,
        ),
      ]),
      child: PhotoViewGallery.builder(
        backgroundDecoration:
            BoxDecoration(color: Colors.grey.withOpacity(0.5)),
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            maxScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained,
            imageProvider: NetworkImage(imageUrl),
            initialScale: PhotoViewComputedScale.contained,
          );
        },
        itemCount: 1,
      ),
    );
  }
}

class ProductTitle extends StatelessWidget {
  final String title;
  const ProductTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class ProductDetails extends StatelessWidget {
  final double rating;
  final double price;
  const ProductDetails({super.key, required this.rating, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.star, color: Colors.orange),
              Text(
                rating.toString(),
                style: const TextStyle(color: Colors.orange),
              )
            ],
          ),
          Text(
            'RM ${price.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
