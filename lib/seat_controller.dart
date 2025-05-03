import 'dart:developer';

import 'package:get/get.dart';

class SeatController extends GetxController {
  final int totalSeats;
  final int columns;

  // List of booked seats
  final List<String> getBookedSeats = ['C2', 'C3', 'D1', 'E1'];

  // Converts the booked seats list to a Set for efficient lookups
  final bookedSeats = <String>{}.obs;

  // Initialize bookedSeats with the list of booked seats
  SeatController(this.totalSeats, this.columns) {
    bookedSeats.addAll(getBookedSeats); // Populate the Set with the initial booked seats
  }

  // Selected seats (reactive)
  final selectedSeats = <String>{}.obs;

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

    while (seatNumber < totalSeats) {
      String rowLetter = String.fromCharCode(65 + rowIndex);
      List<String> rowSeats = [];

      for (int i = 1; i <= columns && seatNumber < totalSeats; i++) {
        rowSeats.add('$rowLetter$i');
        seatNumber++;
      }

      if (seatNumber == totalSeats - 1) {
        rowSeats.add('$rowLetter${rowSeats.length + 1}');
        seatNumber++;
      }

      rows.add(rowSeats);
      rowIndex++;
    }

    return rows;
  }
}
