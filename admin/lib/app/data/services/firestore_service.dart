import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../enums.dart';
import '../models/models.dart';

class FirestoreService extends GetxService {
  Future<FirestoreService> init() async {
    return this;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamCategoriesList() {
    return _firestore.collection('categories').snapshots();
  }

  Future<ResponseModel> createCategory(Map<String, dynamic> data) async {
    try {
      final DocumentReference<Map<String, dynamic>> doc =
          await _firestore.collection('categories').add(data);
      await doc.update({'id': doc.id});

      final categoryData = await doc.get();

      CategoryModel category = CategoryModel.fromJson(categoryData.data()!);

      return ResponseModel(
        status: ResponseStatus.success,
        message: 'Success creating category',
        data: category,
      );
    } catch (e) {
      return ResponseModel(status: ResponseStatus.error, message: e.toString());
    }
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
