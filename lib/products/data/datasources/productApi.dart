import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constant/constants.dart';
import '../../../core/error/exception.dart';
import '../../domain/entities/products.dart';

abstract class ProductsApiDataSource {
  Future<List<Product>> getProducts();
}

class ProductsApiDataSourceImpl implements ProductsApiDataSource {
  final http.Client client;

  ProductsApiDataSourceImpl({required this.client});

  @override
  Future<List<Product>> getProducts() async {
    final response = await client.get(Uri.parse(API.fakeStoreAPI));
    if (response.statusCode == 200) {
      List<dynamic> listOfMap = jsonDecode(response.body);

      List<Product> productList =
          listOfMap.map((e) => Product.fromJson(e)).toList();

      return productList;
    } else {
      throw ServerException();
    }
  }
}
