import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirestoreService extends GetxService {
  Future<FirestoreService> init() async {
    return this;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamCategoriesList() {
    return _firestore.collection('categories').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamProducts(
      {String? categoryId}) {
    if (categoryId != null) {
      return _firestore
          .collection('products')
          .where('category_id', isEqualTo: categoryId)
          .snapshots();
    }
    return _firestore.collection('products').snapshots();
  }
}
