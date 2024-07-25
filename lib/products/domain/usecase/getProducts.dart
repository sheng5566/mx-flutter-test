import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../entities/products.dart';
import '../repository/productRepository.dart';

class GetProducts extends UseCase<List<Product>, NoParams> {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await repository.getProducts();
  }
}
