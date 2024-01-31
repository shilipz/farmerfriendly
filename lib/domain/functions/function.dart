import 'package:cloud_firestore/cloud_firestore.dart';

class VegetablesRepository {
  Future<List<DocumentSnapshot>> filterVegetables(String query) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('vegetables').get();

    List<DocumentSnapshot> filteredVegetables =
        snapshot.docs.where((vegetable) {
      var vegetableName = vegetable['name'].toString().toLowerCase();
      return vegetableName.contains(query.toLowerCase());
    }).toList();

    return filteredVegetables;
  }
}
