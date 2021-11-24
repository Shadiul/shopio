import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'category_manager_controller.dart';

class CategoryManagerView extends GetView<CategoryManagerController> {
  @override
  Widget build(BuildContext context) {
    Get.put(CategoryManagerController());

    Size _size = MediaQuery.of(context).size;

    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = _themeData.textTheme;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Wrap(
            spacing: 16.0,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Categories',
                        style: _textTheme.headline6,
                      ),
                      Text(
                        '100',
                        style: _textTheme.headline5,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Categories',
                        style: _textTheme.headline6,
                      ),
                      Text(
                        '100',
                        style: _textTheme.headline5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 36.0,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Filter',
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {},
                child: Text('Apply Filter'),
              )
            ],
          ),
          SizedBox(height: 16.0),
          Material(
            color: Colors.transparent,
            child: ListTile(
              tileColor: _themeData.highlightColor,
              leading: Text('Index'),
              minLeadingWidth: 64.0,
              title: Row(
                children: [
                  Expanded(child: Text('ID')),
                  Expanded(child: Text('Name')),
                  Expanded(child: Text('Total Products')),
                ],
              ),
              trailing: SizedBox(
                width: 38.0,
              ),
            ),
          ),
          SizedBox(height: 16.0),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) => Material(
              color: Colors.transparent,
              child: ListTile(
                tileColor: index % 2 == 0 ? _themeData.highlightColor : null,
                leading: SelectableText('${index + 1}'),
                minLeadingWidth: 64.0,
                title: Row(
                  children: [
                    Expanded(
                      child: SelectableText('asjd90asjdasj8'),
                    ),
                    Expanded(
                      child: SelectableText('Clothings'),
                    ),
                    Expanded(
                      child: SelectableText(Random().nextInt(1000).toString()),
                    ),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert),
                ),
              ),
            ),
          ),
          Divider(),
          ButtonBar(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.chevron_left),
              ),
              Text('1', style: _textTheme.bodyText1),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.chevron_right),
              ),
            ],
          )
        ],
      ),
    );
  }
}
