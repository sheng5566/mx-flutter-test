import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../repository/cartRepository.dart';

class RemoveFromCart extends UseCase<bool, RemoveFromCartParams> {
  final CartRepository repository;

  RemoveFromCart(this.repository);

  @override
  Future<Either<Failure, bool>> call(RemoveFromCartParams params) async {
    return await repository.removeFromCart(params.productId);
  }
}

class RemoveFromCartParams extends Equatable {
  final int productId;
  const RemoveFromCartParams({
    required this.productId,
  });

  @override
  List<Object> get props => [productId];
}
