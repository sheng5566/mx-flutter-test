import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';

abstract class CartRepository {
  Future<Either<Failure, List<int>>> getCartList();
  Future<Either<Failure, bool>> addToCart(int productId);
  Future<Either<Failure, bool>> removeFromCart(int productId);
}
