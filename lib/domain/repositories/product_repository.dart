import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepository {
  Future<QuerySnapshot> getVegetables() {
    return FirebaseFirestore.instance.collection('vegetables').get();
  }
}
