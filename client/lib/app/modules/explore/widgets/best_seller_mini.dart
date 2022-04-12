import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/models.dart';
import '../../../widgets/product_card_widget.dart';
import '../explore_controller.dart';

class BestSellerMiniWidget extends GetWidget<ExploreController> {
  const BestSellerMiniWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = _themeData.textTheme;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 0.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Best Seller',
                  style: _textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('see more'),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: FutureBuilder<List<ProductModel>>(
              future: controller.getBestSellerProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final products = snapshot.data;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      // childAspectRatio: 9 / 16,
                      mainAxisExtent: 220,
                    ),
                    itemCount: products?.length,
                    itemBuilder: (context, index) => ProductCardWidget(
                      product: products![index],
                      onTap: () async =>
                          controller.onTapProduct(products[index]),
                    ),
                  );
                }
                return const CircularProgressIndicator();
              }),
        )
      ],
    );
  }
}
