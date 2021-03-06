import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../enums.dart';
import '../models/models.dart';
import '../models/product_model.dart';

const _collectionCategories = 'categories';
const _collectionProducts = 'products';
const _collectionIcons = 'icons';

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
    required String icon,
    int productsCount = 0,
  }) async {
    try {
      final doc = await _firestore.collection(_collectionCategories).add(
            CategoryModel(
              id: '',
              timestamp: Timestamp.now(),
              name: name,
              icon: icon,
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

  Future<ResponseModel> updateCategory({
    required String id,
    required String name,
    required String icon,
    int productsCount = 0,
  }) async {
    try {
      await _firestore.collection(_collectionCategories).doc(id).update(
        {
          'name': name,
          'products_count': productsCount,
          'icon': icon,
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

  Stream<QuerySnapshot<Map<String, dynamic>>> streamIconsList() {
    return _firestore
        .collection(_collectionIcons)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<ResponseModel> getCategoryIcons() async {
    try {
      final doc = await _firestore
          .collection(_collectionIcons)
          .doc('category_icons')
          .get();

      List<String> icons = List<String>.from(doc.data()!['icons']).toList();

      return ResponseModel(
        status: ResponseStatus.success,
        message: 'Success fetching category icons',
        data: icons,
      );
    } catch (e) {
      return ResponseModel(
        status: ResponseStatus.error,
        message: e.toString(),
      );
    }
  }

  Future<ResponseModel> deleteProduct(String id) async {
    try {
      await _firestore.collection(_collectionProducts).doc(id).delete();
      return ResponseModel(
        status: ResponseStatus.success,
        message: 'Delete product success',
      );
    } catch (e) {
      return ResponseModel(
        status: ResponseStatus.error,
        message: e.toString(),
      );
    }
  }

  Future<ResponseModel> createProduct({
    required String name,
    required String description,
    required double price,
    required int discount,
    int stockQuantity = 0,
    required String unit,
    required String categoryId,
    List<String> images = const [],
  }) async {
    try {
      final doc = await _firestore.collection(_collectionProducts).add(
            ProductModel(
              id: '',
              name: name,
              description: description,
              price: price,
              discount: discount,
              stockQuantity: stockQuantity,
              unit: unit,
              categoryId: categoryId,
              images: images,
            ).toJson(),
          );
      await doc.update({'id': doc.id});

      return ResponseModel(
        status: ResponseStatus.success,
        message: 'Success creating product',
      );
    } catch (e) {
      return ResponseModel(
        status: ResponseStatus.error,
        message: e.toString(),
      );
    }
  }

  Future<ResponseModel> updateProduct({
    required String id,
    required String name,
    required String description,
    required double price,
    required int discount,
    int stockQuantity = 0,
    required String unit,
    required String categoryId,
    List<String> images = const [],
  }) async {
    try {
      await _firestore.collection(_collectionProducts).doc(id).update(
        {
          'name': name,
          'description': description,
          'price': price,
          'discount': discount,
          'stock_quantity': stockQuantity,
          'unit': unit,
          'category_id': categoryId,
          'images': images,
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
}
