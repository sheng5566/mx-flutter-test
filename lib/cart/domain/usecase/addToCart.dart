import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../repository/cartRepository.dart';

class AddToCart extends UseCase<bool, AddToCartParams> {
  final CartRepository repository;

  AddToCart(this.repository);

  @override
  Future<Either<Failure, bool>> call(AddToCartParams params) async {
    return await repository.addToCart(params.productId);
  }
}

class AddToCartParams extends Equatable {
  final int productId;
  const AddToCartParams({
    required this.productId,
  });

  @override
  List<Object> get props => [productId];
}
