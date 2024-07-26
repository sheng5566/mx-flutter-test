import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mxtest/cart/data/datasources/cartLocal.dart';
import 'package:mxtest/cart/data/repositories/cartRepositoryImpl.dart';
import 'package:mxtest/cart/domain/repository/cartRepository.dart';
import 'package:mxtest/cart/domain/usecase/addToCart.dart';
import 'package:mxtest/cart/domain/usecase/getCartList.dart';
import 'package:mxtest/cart/domain/usecase/removeFromCart.dart';
import 'package:mxtest/cart/presentation/bloc/cart_bloc.dart';
import 'package:mxtest/products/data/datasources/productApi.dart';
import 'package:mxtest/products/data/respositories/productRepositoryImpl.dart';
import 'package:mxtest/products/domain/repository/productRepository.dart';
import 'package:mxtest/products/domain/usecase/getProducts.dart';
import 'package:mxtest/products/presentation/bloc/product_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator.registerLazySingleton(() => sharedPreferences);

//========== Features - Product ==========
  //======================================
  serviceLocator.registerLazySingleton<ProductsApiDataSource>(
    () => ProductsApiDataSourceImpl(
      client: serviceLocator(),
    ),
  );

  // Bloc
  serviceLocator.registerFactory(
    () => ProductBloc(
      getProducts: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      apiDataSource: serviceLocator(),
    ),
  );

  // Use cases
  serviceLocator.registerLazySingleton(() => GetProducts(serviceLocator()));

//========== Features - Product ==========
  //======================================

//========== Features - Cart ==========
  //======================================
  serviceLocator.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(
      sharedPreferences: serviceLocator(),
    ),
  );

  // Bloc
  serviceLocator.registerFactory(
    () => CartBloc(
      addToCart: serviceLocator(),
      removeFromCart: serviceLocator(),
      getCartList: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      localDataSource: serviceLocator(),
    ),
  );

  // Use cases
  serviceLocator.registerLazySingleton(() => AddToCart(serviceLocator()));
  serviceLocator.registerLazySingleton(() => RemoveFromCart(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetCartList(serviceLocator()));

//========== Features - Cart ==========
  //======================================
}
