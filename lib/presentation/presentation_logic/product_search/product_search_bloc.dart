import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cucumber_app/domain/functions/function.dart';

part 'product_search_event.dart';
part 'product_search_state.dart';

class ProductSearchBloc extends Bloc<ProductSearchEvent, ProductSearchState> {
  VegetablesRepository vegetablesRepository = VegetablesRepository();
  ProductSearchBloc() : super(ProductSearchInitial([])) {
    on<ProductSearchEvent>((event, emit) async {
      final state = await vegetablesRepository.filterVegetables(event.query);
      emit(ProductSearchState(state));
    });
  }
}
