part of 'product_details_bloc.dart';

class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object> get props => [];
}

class UpdateQuantityEvent extends ProductDetailsEvent {
  final int quantity;

  UpdateQuantityEvent(this.quantity);
}

class UpdateCollectionDateEvent extends ProductDetailsEvent {
  final DateTime collectionDate;

  UpdateCollectionDateEvent(this.collectionDate);
}
