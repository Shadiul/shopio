import 'package:client/app/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() => Row(
                  children: [
                    Expanded(
                      child: TextField(
                        readOnly: controller.isImageLoading,
                        controller: controller.searchController,
                        decoration: InputDecoration(
                            hintText: controller.isImageLoading
                                ? 'Please wait...'
                                : ''),
                      ),
                    ),
                    const SizedBox(width: 8),
                    controller.isImageLoading
                        ? const CircularProgressIndicator()
                        : IconButton(
                            onPressed: () async {
                              await controller.onTapCamera();
                            },
                            icon: const Icon(Icons.camera_alt),
                          ),
                  ],
                )),
          ),
          Expanded(
              child: Obx(
            () => controller.hasQuery
                ? controller.obx(
                    (state) {
                      if (state == null) {
                        return const Text('null');
                      }
                      return GridView.builder(
                        padding: const EdgeInsets.all(16.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          // childAspectRatio: 9 / 16,
                          mainAxisExtent: 220,
                        ),
                        itemCount: state.length,
                        itemBuilder: (context, index) {
                          final product = state[index];
                          return ProductCardWidget(
                            product: product,
                            onTap: () async => controller.onTapProduct(product),
                          );
                        },
                      );
                    },
                    onEmpty: const Center(child: Text('No Pruducts Found!')),
                    onError: (error) => const Center(child: Text('Error')),
                    onLoading: const Center(child: CircularProgressIndicator()),
                  )
                : const Center(
                    child: Text('Type your query'),
                  ),
          ))
        ],
      ),
    );
  }
}
