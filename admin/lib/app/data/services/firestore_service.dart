import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../enums.dart';
import '../models/models.dart';

const _collectionCategories = 'categories';
const _collectionProducts = 'products';

class FirestoreService extends GetxService {
  Future<FirestoreService> init() async {
    return this;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamProductsList() {
    return _firestore
        .collection(_collectionProducts)
        // .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamCategoriesList() {
    return _firestore
        .collection(_collectionCategories)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<ResponseModel> createCategory({
    required String name,
    int productsCount = 0,
  }) async {
    try {
      final doc = await _firestore.collection(_collectionCategories).add(
            CategoryModel(
              id: '',
              timestamp: Timestamp.now(),
              name: name,
              icon:
                  'https://firebasestorage.googleapis.com/v0/b/shopio-031.appspot.com/o/icons%2Fcategory_icons%2Fcategory_default.png?alt=media&token=11f15310-58df-4ccb-a6d5-a447ce92acf9',
              productsCount: productsCount,
            ).toJson(),
          );
      await doc.update({'id': doc.id});

      return ResponseModel(
        status: ResponseStatus.success,
        message: 'Success creating category',
      );
    } catch (e) {
      return ResponseModel(
        status: ResponseStatus.error,
        message: e.toString(),
      );
    }
  }

  Future<ResponseModel> updateCategoryIcon(String id, String value) async {
    try {
      await _firestore.collection(_collectionCategories).doc(id).update(
        {'icon': value},
      );

      return ResponseModel(
        status: ResponseStatus.success,
        message: 'Success updating icon',
      );
    } catch (e) {
      return ResponseModel(status: ResponseStatus.error, message: e.toString());
    }
  }

  Future<ResponseModel> updateCategory({
    required String id,
    required String name,
    int productsCount = 0,
  }) async {
    try {
      await _firestore.collection(_collectionCategories).doc(id).update(
        {
          'name': name,
          'products_count': productsCount,
        },
      );

      return ResponseModel(
        status: ResponseStatus.success,
        message: 'Success updating category',
      );
    } catch (e) {
      return ResponseModel(status: ResponseStatus.error, message: e.toString());
    }
  }

  Future<ResponseModel> deleteCategory(String id) async {
    try {
      await _firestore.collection(_collectionCategories).doc(id).delete();
      return ResponseModel(
        status: ResponseStatus.success,
        message: 'Delete category success',
      );
    } catch (e) {
      return ResponseModel(
        status: ResponseStatus.error,
        message: e.toString(),
      );
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamCategoryIcons() {
    return _firestore.collection('icons').doc('category_icons').snapshots();
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
