import 'package:shared_preferences/shared_preferences.dart';

abstract class CartLocalDataSource {
  Future<bool> addToCart(int productId);
  Future<bool> removeFromCart(int productId);
  Future<List<int>> getCartList();
}

const CACHED_CARTS = 'CACHED_CARTS';

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final SharedPreferences sharedPreferences;
  CartLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> addToCart(int productId) async {
    List<int> productIdList = await getCartList();
    productIdList.add(productId);
    List<String> updatedProductList =
        productIdList.map((e) => e.toString()).toList();
    bool isSuccess = await sharedPreferences.setStringList(
      CACHED_CARTS,
      updatedProductList,
    );
    return isSuccess;
  }

  @override
  Future<List<int>> getCartList() async {
    List<String>? stringIdList = sharedPreferences.getStringList(CACHED_CARTS);
    List<int> productIdList = stringIdList != null
        ? stringIdList.map((e) => int.parse(e)).toList()
        : [];
    return Future.value(productIdList);
  }

  @override
  Future<bool> removeFromCart(int productId) async {
    List<int> productIdList = await getCartList();
    productIdList.removeWhere((id) => id == productId);
    List<String> updatedProductList =
        productIdList.map((e) => e.toString()).toList();
    bool isSuccess = await sharedPreferences.setStringList(
      CACHED_CARTS,
      updatedProductList,
    );
    return isSuccess;
  }
}
