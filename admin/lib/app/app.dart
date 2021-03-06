import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Shopio Admin Panel",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData.light().copyWith(
        visualDensity: VisualDensity.standard,
        colorScheme: ColorScheme.light(
          primary: Colors.deepPurple,
          primaryVariant: Colors.deepPurple.shade700,
          secondary: Colors.deepPurpleAccent,
          secondaryVariant: Colors.deepPurpleAccent.shade700,
          onSecondary: Colors.white,
        ),
        primaryColorLight: Colors.deepPurple.shade300,
        primaryColor: Colors.deepPurple,
        primaryColorDark: Colors.deepPurple.shade700,
        scaffoldBackgroundColor: Colors.grey.shade200,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black87,
          shadowColor: Colors.transparent,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.deepPurple,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
            // contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            // border: OutlineInputBorder(
            //   borderSide: BorderSide.none,
            // ),
            // filled: true,
            // fillColor: Colors.white,
            // floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              // padding: MaterialStateProperty.all(
              //   const EdgeInsets.all(24.0),
              // ),
              ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              // padding: MaterialStateProperty.all(
              //   const EdgeInsets.all(16.0),
              // ),
              ),
        ),
        cardTheme: CardTheme(
          margin: EdgeInsets.zero,
        ),
        dividerTheme: const DividerThemeData(space: 0.0),
      ),
    );
  }
}
