part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCartRequest extends CartEvent {
  final int productId;

  const AddToCartRequest({required this.productId});

  @override
  List<Object> get props => [productId];
}

class RemoveFromCartRequest extends CartEvent {
  final int productId;

  const RemoveFromCartRequest({required this.productId});

  @override
  List<Object> get props => [productId];
}

class GetCartListRequest extends CartEvent {}
