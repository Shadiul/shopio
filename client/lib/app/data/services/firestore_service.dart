import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirestoreService extends GetxService {
  final FirebaseFirestore firestore;
  FirestoreService(this.firestore);
  Future<FirestoreService> init() async {
    return this;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamCategoriesList() {
    return firestore.collection('categories').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamProducts(
      {String? categoryId}) {
    if (categoryId != null) {
      return firestore
          .collection('products')
          .where('category_id', isEqualTo: categoryId)
          .snapshots();
    }
    return firestore.collection('products').snapshots();
  }
}
