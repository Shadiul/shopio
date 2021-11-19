import 'package:flutter/material.dart';

import '../data/models/models.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel product;

  const ProductCardWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = _themeData.textTheme;
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16.0),
            ),
            child: Container(
              height: 148.0,
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
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
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${product.price}\$',
                    style: _textTheme.headline6,
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
    );
  }
}
