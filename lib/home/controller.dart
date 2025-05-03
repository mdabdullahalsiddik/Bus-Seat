import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:seat_layout/seat/view.dart';

class HomeController extends GetxController {
  final TextEditingController totalSeatController = TextEditingController();
  final TextEditingController columnController = TextEditingController();

  void generateLayout() {
    final totalSeatText = totalSeatController.text.trim();
    final columnText = columnController.text.trim();

    if (totalSeatText.isEmpty || columnText.isEmpty) {
      Get.snackbar("Input Error", "Please fill in all fields");
      return;
    }

    final int? totalSeats = int.tryParse(totalSeatText);
    final int? columns = int.tryParse(columnText);

    if (totalSeats == null || columns == null || totalSeats <= 0 || columns <= 0) {
      Get.snackbar("Invalid Input", "Please enter valid positive numbers");
      return;
    }

    if (columns > totalSeats) {
      Get.snackbar("Logic Error", "Columns cannot be more than total seats");
      return;
    }

    Get.to(
      () =>
      //  SeatLayout(totalSeats: 40, columns: 3),
      SeatLayout(),
      arguments: {
        "totalSeats": totalSeats,
        "columns": columns,
      },
    );
  }
}
