part of 'product_details_bloc.dart';

class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

final class ProductDetailsUpdatedState extends ProductDetailsState {
  final VegetableDetails vegetableDetails;

  ProductDetailsUpdatedState(this.vegetableDetails);
}
