import 'package:client/app/data/enums.dart';
import 'package:client/app/data/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class FirestoreService extends GetxService {
  final FirebaseFirestore firestore;
  FirestoreService(this.firestore);
  Future<FirestoreService> init() async {
    return this;
  }

  Logger logger = Logger();

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

  Future<ResponseModel<List<ProductModel>>> getBestSellerProducts() async {
    try {
      final bestSellerSnapshot =
          await firestore.collection('explore').doc('best_sellers').get();

      if (bestSellerSnapshot.data() != null) {
        final productIds = bestSellerSnapshot.data()!['products'];
        var productsSnapshot = <DocumentSnapshot<Map<String, dynamic>>>[];
        for (var productId in productIds) {
          final productSnapshot =
              await firestore.collection('products').doc(productId).get();
          productsSnapshot.add(productSnapshot);
        }

        final products = List<ProductModel>.from(productsSnapshot
            .map((e) => ProductModel.fromJson(e.data()!))
            .toList());

        return ResponseModel(
          status: ResponseStatus.success,
          message: '⏬ Products data fetch success',
          data: products,
        );
      }
      return ResponseModel(
        status: ResponseStatus.empty,
        message: 'no best sellers',
      );
    } catch (e) {
      return ResponseModel(
        status: ResponseStatus.error,
        message: e.toString(),
      );
    }
  }

  Future<ResponseModel<List<ProductModel>>> searchProducts(String query) async {
    ResponseModel<List<ProductModel>> response;
    try {
      final productsSnapshot = await firestore
          .collection('products')
          .where('tags', arrayContains: query)
          .get();

      response = ResponseModel(
        status: ResponseStatus.success,
        message: '⏬ Products data fetch success',
        data: List<ProductModel>.from(productsSnapshot.docs
            .map((e) => ProductModel.fromJson(e.data()))).toList(),
      );
    } catch (e) {
      logger.e(e);
      response = ResponseModel(
        status: ResponseStatus.error,
        message: e.toString(),
      );
    }

    return response;
  }
}
