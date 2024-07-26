import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../domain/repository/cartRepository.dart';
import '../datasources/cartLocal.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, bool>> addToCart(int productId) async {
    try {
      final isSuccess = await localDataSource.addToCart(productId);

      return Right(isSuccess);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<int>>> getCartList() async {
    try {
      final cartList = await localDataSource.getCartList();

      return Right(cartList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> removeFromCart(int productId) async {
    try {
      final isSuccess = await localDataSource.removeFromCart(productId);

      return Right(isSuccess);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}


// class CartRepositoryImpl implements CartRepository {
//   final CartLocalDataSource localDataSource;

//   CartRepositoryImpl({
//     required this.localDataSource,
//   });

//   @override
//   Future<Either<Failure, bool>> addToCart(int productId) async {
//     try {
//       final isSuccess = await localDataSource.addToCart(productId);

//       return Right(isSuccess);
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, List<int>>> getCartList() async {
//     try {
//       final cartList = await localDataSource.getCartList();

//       return Right(cartList);
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, bool>> removeFromCart(int productId) async {
//     try {
//       final isSuccess = await localDataSource.removeFromCart(productId);

//       return Right(isSuccess);
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
// }
