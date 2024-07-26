import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mxtest/cart/presentation/bloc/cart_bloc.dart';
import 'package:mxtest/products/presentation/bloc/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constant/constants.dart';
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
  final CartBloc _cartBloc = serviceLocator<CartBloc>();
  List<Product> products = [];
  List<String> splitQuery = [];
  List<String> filteredCategory = [];

  Timer? timer;

  Widget centerTextWidget(text) {
    return Center(
      child: Text(text),
    );
  }

  List<Widget> productList() {
    return products
        .where((product) {
          if (splitQuery.isEmpty && filteredCategory.isEmpty) {
            return true;
          }
          if (filteredCategory.isNotEmpty) {}

          List<String> splitName =
              product.title.toLowerCase().split(RegExp(r'[ ,]+'));
          bool isMetRequirements = splitQuery.every((q) {
            bool isMetRequirement =
                splitName.firstWhereOrNull((name) => name.contains(q)) != null;
            return isMetRequirement;
          });

          bool filterCategory = filteredCategory.isNotEmpty
              ? filteredCategory.contains(product.category)
              : true;
          return isMetRequirements && filterCategory;
        })
        .map((product) => ProductListTile(
              product: product,
            ))
        .toList();
  }

  void searchInputOnChange(query) {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
    if (query != "") {
      timer = Timer(Duration(milliseconds: 500), () {
        setState(() {
          splitQuery = query.toLowerCase().split(RegExp(r'[ ,]+'));
        });
      });
    } else {
      setState(() {
        splitQuery = [];
      });
    }
  }

  void filterCategoryFeat(bool checked, String category) {
    setState(() {
      if (checked) {
        filteredCategory.add(category);
      } else {
        filteredCategory.remove(category);
      }
    });
  }

  void showFilterDialog(
      BuildContext context, Function(bool, String) filterCategoryFeat) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Filter Options'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: products
                    .map((e) => e.category)
                    .toSet()
                    .map((e) => CheckboxListTile(
                          title: Text(e),
                          value: filteredCategory.contains(e),
                          onChanged: (bool? checked) {
                            if (checked != null) {
                              setState(() {
                                filterCategoryFeat(checked, e);
                              });
                            }
                          },
                        ))
                    .toList(),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    _productBloc.add(GetProductsRequest());

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _productBloc.close();
    _cartBloc.close();
    super.dispose();
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
              BlocProvider<CartBloc>(
                create: (context) => _cartBloc,
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
                        _cartBloc.add(GetCartListRequest());
                      }
                    },
                  ),
                  BlocListener<CartBloc, CartState>(
                    bloc: _cartBloc,
                    listener: (context, state) {
                      if (state is CartListLoaded) {
                        setState(() {
                          Constant.cartList = state.cartList;
                        });
                      }
                    },
                  ),
                ],
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                labelText: 'Search',
                              ),
                              keyboardType: TextInputType.text,
                              onChanged: searchInputOnChange),
                        ),
                        IconButton(
                            iconSize: 30,
                            onPressed: () {
                              showFilterDialog(context, filterCategoryFeat);
                            },
                            icon: Icon(Icons.filter_list))
                      ],
                    ),
                  ),
                  Expanded(
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
                        }),
                  ),
                ]))));
  }
}

class FilterListTile extends StatelessWidget {
  final Function(bool?) filterFunction;
  final List<String> filteredCategory;
  final String category;
  const FilterListTile(
      {super.key,
      required this.filterFunction,
      required this.category,
      required this.filteredCategory});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(category),
      value: filteredCategory.isEmpty
          ? false
          : filteredCategory.contains(category),
      onChanged: filterFunction,
    );
  }
}
