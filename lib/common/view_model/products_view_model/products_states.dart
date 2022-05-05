import '../../../core/network/failure.dart';
import '../../models/pagination_model.dart';

abstract class ProductsStates {}

class ProductsInitialState extends ProductsStates {}

class ProductsPickImagesState extends ProductsStates {}

class AddProductLoadingState extends ProductsStates {}

class AddProductSuccessState extends ProductsStates {}

class AddProductFailureState extends ProductsStates {
  final Failure failure;

  AddProductFailureState(this.failure);
}

class GetProductsLoadingState extends ProductsStates {}

class GetProductsSuccessState extends ProductsStates {
  final PaginationModel paginationModel;

  GetProductsSuccessState(this.paginationModel);
}

class GetProductsFailureState extends ProductsStates {
  final Failure failure;

  GetProductsFailureState(this.failure);
}

class DeleteProductLoadingState extends ProductsStates {}

class DeleteProductSuccessState extends ProductsStates {
  final String message;

  DeleteProductSuccessState(this.message);
}

class DeleteProductFailureState extends ProductsStates {
  final Failure failure;

  DeleteProductFailureState(this.failure);
}
