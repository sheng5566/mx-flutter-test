import 'package:dartz/dartz.dart';
import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../domain/entities/products.dart';
import '../../domain/repository/productRepository.dart';
import '../datasources/productApi.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductsApiDataSource apiDataSource;

  ProductRepositoryImpl({
    required this.apiDataSource,
  });

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final products = await apiDataSource.getProducts();

      return Right(products);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
