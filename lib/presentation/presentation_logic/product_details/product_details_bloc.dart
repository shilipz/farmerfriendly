import 'package:bloc/bloc.dart';
import 'package:cucumber_app/domain/models/vegetable_details.dart';
import 'package:equatable/equatable.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc()
      : super(ProductDetailsUpdatedState(VegetableDetails(
            name: '', quantity: 0, collectionDate: DateTime.now())));

  Stream<ProductDetailsState> mapEventToState(
      ProductDetailsEvent event) async* {
    if (event is UpdateQuantityEvent) {
      final currentState = state as ProductDetailsUpdatedState;
      yield ProductDetailsUpdatedState(VegetableDetails(
        name: currentState.vegetableDetails.name,
        quantity: event.quantity,
        collectionDate: currentState.vegetableDetails.collectionDate,
      ));
    } else if (event is UpdateCollectionDateEvent) {
      final currentState = state as ProductDetailsUpdatedState;
      yield ProductDetailsUpdatedState(VegetableDetails(
        name: currentState.vegetableDetails.name,
        quantity: currentState.vegetableDetails.quantity,
        collectionDate: event.collectionDate,
      ));
    }
  }
}
