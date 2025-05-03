import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seat_layout/home/view.dart';

import 'seat/view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, home: HomeView());
  }
}
