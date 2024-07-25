import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mxtest/products/data/datasources/productApi.dart';
import 'package:mxtest/products/data/respositories/productRepositoryImpl.dart';
import 'package:mxtest/products/domain/repository/productRepository.dart';
import 'package:mxtest/products/domain/usecase/getProducts.dart';
import 'package:mxtest/products/presentation/bloc/product_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator.registerLazySingleton(() => http.Client());

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
}
