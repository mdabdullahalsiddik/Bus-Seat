import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'seat_controller.dart';

class SeatLayout extends StatelessWidget {
  final int totalSeats;
  final int columns;

  const SeatLayout({super.key, required this.totalSeats, required this.columns});

  @override
  Widget build(BuildContext context) {
    final SeatController controller = Get.put(SeatController(totalSeats, columns));
    final rows = controller.getSeatLabelsByRow();

    return Scaffold(
      appBar: AppBar(title: const Text("Seat Layout")),
      body: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context, rowIndex) {
          final rowSeats = rows[rowIndex];
          final isFullRow = rowSeats.length == columns;

          if (isFullRow) {
            final leftCount = columns ~/ 2;
            final leftSeats = rowSeats.take(leftCount).toList();
            final rightSeats = rowSeats.skip(leftCount).toList();
            return _rowWithAisle(controller, leftSeats, rightSeats);
          } else {
            return _customRow(controller, rowSeats);
          }
        },
      ),
    );
  }

  Widget _rowWithAisle(SeatController controller, List<String> left, List<String> right) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: left.map((label) => _buildSeat(controller, label)).toList()),
          const SizedBox(width: 32), // Aisle gap
          Row(children: right.map((label) => _buildSeat(controller, label)).toList()),
        ],
      ),
    );
  }

  Widget _customRow(SeatController controller, List<String> seats) {
    final total = seats.length;

    if (total == 4) {
      final left = seats.take(2).toList();
      final right = seats.skip(2).toList();
      return _rowWithAisle(controller, left, right);
    } else if (total == 5) {
      final left = seats.take(2).toList();
      final center = seats[2];
      final right = seats.skip(3).toList();

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: left.map((label) => _buildSeat(controller, label)).toList()),
            _buildSeat(controller, center),
            Row(children: right.map((label) => _buildSeat(controller, label)).toList()),
          ],
        ),
      );
    } else {
      // Default fallback: center all seats
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: seats.map((label) => _buildSeat(controller, label)).toList()),
      );
    }
  }

  Widget _buildSeat(SeatController controller, String label) {
    return Obx(() {
      final isBooked = controller.isBooked(label);
      final isSelected = controller.isSelected(label);

      Color color = Colors.grey[400]!;
      if (isBooked)
        color = Colors.black;
      else if (isSelected)
        color = Colors.orange;

      return GestureDetector(
        onTap: () => controller.toggleSeat(label),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          child: Column(children: [Text(label, style: const TextStyle(fontSize: 12)), Icon(Icons.event_seat, color: color, size: 38)]),
        ),
      );
    });
  }
}
