import 'package:client/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'explore_controller.dart';
import 'widgets/best_seller_mini.dart';
import 'widgets/category_mini.dart';
import 'widgets/hot_sales_mini.dart';

class ExploreView extends GetView<ExploreController> {
  const ExploreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ExploreController());
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      children: [
        const CategoryMiniWidget(),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: TextField(
            readOnly: true,
            onTap: () async {
              await Get.toNamed(Routes.SEARCH);
            },
            decoration: const InputDecoration(
              label: Text('Search'),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        // const HotSalesMiniWidget(),
        const BestSellerMiniWidget(),
      ],
    );
  }
}
