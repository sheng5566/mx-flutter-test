part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

class AddToCartLoading extends CartState {}

class AddToCartSuccess extends CartState {
  final bool isSuccess;

  const AddToCartSuccess({required this.isSuccess});

  @override
  List<Object> get props => [isSuccess];
}

class AddToCartError extends CartState {
  final String message;

  const AddToCartError({required this.message});

  @override
  List<Object> get props => [message];
}

class RemoveFromCartLoading extends CartState {}

class RemoveFromCartSuccess extends CartState {
  final int productId;

  const RemoveFromCartSuccess({required this.productId});

  @override
  List<Object> get props => [productId];
}

class RemoveFromCartError extends CartState {
  final String message;

  const RemoveFromCartError({required this.message});

  @override
  List<Object> get props => [message];
}

class LoadingCartList extends CartState {}

class CartListLoaded extends CartState {
  final List<int> cartList;

  const CartListLoaded({required this.cartList});

  @override
  List<Object> get props => [cartList];
}

class CartListError extends CartState {
  final String message;

  const CartListError({required this.message});

  @override
  List<Object> get props => [message];
}
