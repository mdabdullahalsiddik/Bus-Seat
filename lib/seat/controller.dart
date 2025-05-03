import 'dart:developer';

import 'package:get/get.dart';

class SeatController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt totalSeats = 0.obs;
  RxInt columns = 0.obs;

  final bookedSeats = <String>{}.obs;

  final selectedSeats = <String>{}.obs;
  final List<String> getBookedSeats = ['C2', 'C3', 'D1', 'E1'];

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    getArguments();
    bookedSeats.addAll(getBookedSeats);
    isLoading.value = false;
  }

  void getArguments() async {
    var a =  Get.arguments;
    log(a.toString());
    if (a != null) {
      totalSeats.value = a['totalSeats'];
      columns.value = a['columns'];
    }
  }

  bool isBooked(String seat) => bookedSeats.contains(seat);
  bool isSelected(String seat) => selectedSeats.contains(seat);

  void toggleSeat(String seat) {
    if (isBooked(seat)) return; // Prevent selecting booked seats
    if (selectedSeats.contains(seat)) {
      selectedSeats.remove(seat);
      log(selectedSeats.toList().toString());
    } else {
      selectedSeats.add(seat);
      log(selectedSeats.toList().toString());
    }
  }

  List<List<String>> getSeatLabelsByRow() {
    List<List<String>> rows = [];
    int seatNumber = 0;
    int rowIndex = 0;

    while (seatNumber < totalSeats.value) {
      String rowLetter = String.fromCharCode(65 + rowIndex);
      List<String> rowSeats = [];

      for (int i = 1; i <= columns.value && seatNumber < totalSeats.value; i++) {
        rowSeats.add('$rowLetter$i');
        seatNumber++;
      }

      if (seatNumber == totalSeats.value - 1) {
        rowSeats.add('$rowLetter${rowSeats.length + 1}');
        seatNumber++;
      }

      rows.add(rowSeats);
      rowIndex++;
    }

    return rows;
  }
}
