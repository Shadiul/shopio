import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'new_category_form_controller.dart';

class NewCategoryFormView extends GetWidget<NewCategoryFormController> {
  const NewCategoryFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    // TextTheme _textTheme = _themeData.textTheme;

    return AlertDialog(
      scrollable: true,
      backgroundColor: _themeData.scaffoldBackgroundColor,
      content: Form(
        key: controller.formKey,
        child: Column(
          children: [
            TextFormField(
              controller: controller.nameController,
              decoration: InputDecoration(
                label: Text('Name'),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: controller.onTapCreate,
          child: Text('Create'),
        ),
      ],
    );
  }
}
