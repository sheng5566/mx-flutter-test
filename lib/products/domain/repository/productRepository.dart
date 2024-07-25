import 'package:dartz/dartz.dart';
import 'package:mxtest/products/domain/entities/products.dart';
import '../../../core/error/failure.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
}
