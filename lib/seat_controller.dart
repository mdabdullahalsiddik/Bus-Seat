import 'package:get/get.dart';

class SeatController extends GetxController {
  final int totalSeats;
  final int columns;

  SeatController(this.totalSeats, this.columns);

  final selectedSeats = <String>{}.obs;
  final bookedSeats = <String>{'C2', 'C3', 'D1', 'E4'}.obs;

  bool isBooked(String seat) => bookedSeats.contains(seat);
  bool isSelected(String seat) => selectedSeats.contains(seat);

  void toggleSeat(String seat) {
    if (isBooked(seat)) return;
    if (selectedSeats.contains(seat)) {
      selectedSeats.remove(seat);
    } else {
      selectedSeats.add(seat);
    }
  }

 List<List<String>> getSeatLabelsByRow() {
  List<List<String>> rows = [];
  int seatNumber = 0;
  int rowIndex = 0;

  while (seatNumber < totalSeats) {
    String rowLetter = String.fromCharCode(65 + rowIndex);
    List<String> rowSeats = [];

    // Add seats up to the number of columns or remaining seats
    for (int i = 1; i <= columns && seatNumber < totalSeats; i++) {
      rowSeats.add('$rowLetter$i');
      seatNumber++;
    }

    // If last row and there are still remaining seats, add them too
    if (seatNumber == totalSeats - 1) {
      // 1 seat left – put it in the same row
      rowSeats.add('$rowLetter${rowSeats.length + 1}');
      seatNumber++;
    }

    rows.add(rowSeats);
    rowIndex++;
  }

  return rows;
}



}
