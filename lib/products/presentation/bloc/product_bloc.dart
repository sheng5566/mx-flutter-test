import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/usecase/usecase.dart';
import '../../../core/util/failure_message.dart';
import '../../domain/entities/products.dart';
import '../../domain/usecase/getProducts.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;

  ProductBloc({
    required GetProducts getProducts,
  })  : getProducts = getProducts,
        super(ProductsInitial());

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is GetProductsRequest) {
      yield LoadingProducts();
      final failureOrResults = await getProducts(NoParams());
      yield failureOrResults.fold(
        (failure) => LoadProductsError(message: Failure2Message.map(failure)),
        (products) => ProductsLoaded(products: products),
      );
    }
  }
}
