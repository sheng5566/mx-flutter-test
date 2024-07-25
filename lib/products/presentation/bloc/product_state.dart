part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductState {}

class LoadingProducts extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<Product> products;

  const ProductsLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class LoadProductsError extends ProductState {
  final String message;

  const LoadProductsError({required this.message});

  @override
  List<Object> get props => [message];
}
