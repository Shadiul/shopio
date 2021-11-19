import 'dart:convert';

import 'package:client/app/data/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FirestoreService extends GetxService {
  final FirebaseFirestore firestore;
  FirestoreService(this.firestore);
  Future<FirestoreService> init() async {
    return this;
  }

  Future<CategoryModel?> getCategoryData(String id) async {
    final jsonStringData = await rootBundle.loadString(
      'assets/json/fake_categories.json',
    );
    Map<String, dynamic> data = jsonDecode(jsonStringData);
    List<CategoryModel> categories = List<CategoryModel>.from(
      (data as List).map((e) => CategoryModel.fromJson(e)),
    );
    Iterable<CategoryModel> foundCategories = categories.where(
      (element) => element.id == id,
    );

    if (foundCategories.isEmpty) {
      return null;
    } else {
      return foundCategories.first;
    }
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
