import 'package:flutter/material.dart';

import 'seat_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SeatLayout(totalSeats: 40, columns: 3), // change 3 or 4 as needed
    );
  }
}
