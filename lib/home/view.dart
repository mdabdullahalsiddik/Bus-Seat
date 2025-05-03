import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seat_layout/home/controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seat Layout Designer"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter Layout Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Total Seats
            TextField(
              controller: controller.totalSeatController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Total Seats",
                hintText: "e.g. 40",
                prefixIcon: const Icon(Icons.event_seat),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Columns
            TextField(
              controller: controller.columnController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Number of Columns",
                hintText: "e.g. 4",
                prefixIcon: const Icon(Icons.grid_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  controller.generateLayout();
                },
                icon: const Icon(Icons.check),
                label: const Text("Generate Layout" , style: TextStyle(color:Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
