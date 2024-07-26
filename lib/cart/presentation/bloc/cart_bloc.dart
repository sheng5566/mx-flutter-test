import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mxtest/cart/domain/usecase/addToCart.dart';
import 'package:mxtest/cart/domain/usecase/getCartList.dart';
import 'package:mxtest/cart/domain/usecase/removeFromCart.dart';
import 'package:mxtest/core/usecase/usecase.dart';

import '../../../core/util/failure_message.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartList getCartList;
  final AddToCart addToCart;
  final RemoveFromCart removeFromCart;
  CartBloc({
    required GetCartList getCartList,
    required AddToCart addToCart,
    required RemoveFromCart removeFromCart,
  })  : getCartList = getCartList,
        addToCart = addToCart,
        removeFromCart = removeFromCart,
        super(CartInitial());

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is AddToCartRequest) {
      yield AddToCartLoading();
      final failureOrResults =
          await addToCart(AddToCartParams(productId: event.productId));
      yield failureOrResults.fold(
        (failure) => AddToCartError(message: Failure2Message.map(failure)),
        (isSuccess) => AddToCartSuccess(isSuccess: isSuccess),
      );
    }

    if (event is RemoveFromCartRequest) {
      yield RemoveFromCartLoading();
      final failureOrResults = await removeFromCart(
          RemoveFromCartParams(productId: event.productId));
      yield failureOrResults.fold(
        (failure) => RemoveFromCartError(message: Failure2Message.map(failure)),
        (productId) => RemoveFromCartSuccess(productId: event.productId),
      );
    }

    if (event is GetCartListRequest) {
      yield LoadingCartList();
      final failureOrResults = await getCartList(NoParams());
      yield failureOrResults.fold(
        (failure) => CartListError(message: Failure2Message.map(failure)),
        (cartList) => CartListLoaded(cartList: cartList),
      );
    }
  }
}
