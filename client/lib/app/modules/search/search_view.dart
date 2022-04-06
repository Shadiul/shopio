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
        ],
      ),
    );
  }
}
