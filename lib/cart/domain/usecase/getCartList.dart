import 'package:dartz/dartz.dart';
import 'package:mxtest/cart/domain/repository/cartRepository.dart';
import '../../../core/error/failure.dart';
import '../../../core/usecase/usecase.dart';

class GetCartList extends UseCase<List<int>, NoParams> {
  final CartRepository repository;

  GetCartList(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(NoParams params) async {
    return await repository.getCartList();
  }
}
