import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/data/services/services.dart';

Future<void> main() async {
  await initServices();
  runApp(const App());
}
