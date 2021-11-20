import 'package:flutter/material.dart';

import '../data/models/models.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const ProductCardWidget({
    Key? key,
    required this.product,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = _themeData.textTheme;
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 148.0,
                child: product.images.isEmpty
                    ? const Icon(
                        Icons.shopping_bag,
                        size: 128,
                      )
                    : Image.network(
                        product.images.first,
                        fit: BoxFit.cover,
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${product.priceAfterDiscount}\$',
                              style: _textTheme.headline6,
                            ),
                          ),
                          if (product.discount > 0)
                            Text(
                              '\$' + product.price.toString(),
                              style: _textTheme.subtitle2!.copyWith(
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                      Expanded(
                        child: Text(
                          product.name,
                          style: _textTheme.subtitle2,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
