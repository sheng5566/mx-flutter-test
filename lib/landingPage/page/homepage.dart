import 'package:flutter/material.dart';
import 'package:mxtest/products/presentation/bloc/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injection_container.dart';
import 'package:getwidget/getwidget.dart';

import '../../products/domain/entities/products.dart';
import '../../products/presentation/widget/productListTile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ProductBloc _productBloc = serviceLocator<ProductBloc>();
  List<Product> products = [];

  Widget centerTextWidget(text) {
    return Center(
      child: Text(text),
    );
  }

  List<Widget> productList() {
    return products
        .map((product) => ProductListTile(
              product: product,
            ))
        .toList();
  }

  @override
  void initState() {
    _productBloc.add(GetProductsRequest());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          title: const Text(
            'Mx Test',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: MultiBlocProvider(
            providers: [
              BlocProvider<ProductBloc>(
                create: (context) => _productBloc,
              ),
            ],
            child: MultiBlocListener(
                listeners: [
                  BlocListener<ProductBloc, ProductState>(
                    bloc: _productBloc,
                    listener: (context, state) {
                      if (state is ProductsLoaded) {
                        setState(() {
                          products = state.products;
                        });
                      }
                    },
                  ),
                ],
                child: BlocBuilder<ProductBloc, ProductState>(
                    bloc: _productBloc,
                    builder: (context, state) {
                      if (state is LoadProductsError) {
                        return centerTextWidget('Server exception');
                      }
                      if (state is ProductsLoaded) {
                        if (products.isNotEmpty) {
                          return ListView(children: productList());
                        }

                        return centerTextWidget("No Products Available");
                      }
                      return const GFLoader(type: GFLoaderType.ios);
                    }))));
  }
}
