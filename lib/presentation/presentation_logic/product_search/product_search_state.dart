// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_search_bloc.dart';

class ProductSearchState {
  List<DocumentSnapshot> filteredVegetables = [];

  ProductSearchState(
    this.filteredVegetables,
  );
}

final class ProductSearchInitial extends ProductSearchState {
  ProductSearchInitial(super.filteredVegetables);
}
