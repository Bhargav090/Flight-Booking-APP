// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, sort_child_properties_last
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:jmrinfotech/screens/dashed_line.dart';

class SearchResultsScreen extends StatefulWidget {
  final String fromLocation;
  final String toLocation;
  final int travelers;
  final String cabinClass;
  final String departureDate;
  final String tripType;

  const SearchResultsScreen({super.key, 
    required this.fromLocation,
    required this.toLocation,
    required this.travelers,
    required this.cabinClass,
    required this.departureDate,
    required this.tripType,
  });

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  String selectedDateRange = '';
  late List<Map<String, dynamic>> flights;

  @override
  void initState() {
    super.initState();
    selectedDateRange = 'Mar 23 - Mar 24';
    flights = generateDummyData();
  }

  List<Map<String, dynamic>> generateDummyData() {
    final random = Random();
    final int resultCount = random.nextInt(3) + 3;
    return List.generate(resultCount, (index) {
      return {
        'flightName': 'Flight ${index + 1}',
        'cost': 200 + random.nextInt(800), // Random cost AED 200 to 1000---------
        'departureTime': '${random.nextInt(10) + 10}:00', // Random hour from 10:00 to 19:00----------
        'arrivalTime': '${random.nextInt(6) + 15}:00', // Random arrival from 15:00 to 21:00------------------
        'stops': '${random.nextInt(3)} Stops', // Random number of stops (0-2)--------------------
        'fromLocation': widget.fromLocation,
        'toLocation': widget.toLocation,
      };
    });
  }

  void onDateSelected(String dateRange) {
    setState(() {
      selectedDateRange = dateRange;
      flights = generateDummyData(); // Generate new random flights for the selected date-----------
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFC4E59E),
        title: const Text('Ezy Travels'),
      ),
      body: Column(
        children: [
          buildTopCard(context, screenWidth),
          const SizedBox(height: 10),
          buildDateSelection(),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: flights.length,
                itemBuilder: (context, index) {
                  final result = flights[index];
                  return Card(
                    color: Colors.white,
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/flilogo.png',
                                    width: screenWidth * 0.1,
                                    height: screenWidth * 0.1,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    result['flightName'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'AED ${result['cost']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                result['departureTime'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left:20,right:20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: DashedLine(color: Colors.grey),
                                      ),
                                      Icon(
                                        Icons.flight_takeoff,
                                        color: Colors.grey,
                                      ),
                                      Expanded(
                                        child: DashedLine(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                result['arrivalTime'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(result['fromLocation']),
                              Text(result['stops']),
                              Text(result['toLocation']),
                            ],
                          ),
                          const Divider(color: Colors.grey, thickness: 1),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTopCard(BuildContext context, double screenWidth) {
    return Card(
      color: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 10, left:15,right:15,top:10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Text(
                '${widget.fromLocation} to ${widget.toLocation}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Departure: ${widget.departureDate}', style: const TextStyle(fontSize: 14)),
                 const SizedBox(width: 10),
                Text('Travelers: ${widget.travelers}', style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(
                    widget.tripType,
                    style: const TextStyle(color: Colors.orange),
                  ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: const [
                      Text('Modify Search', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(color: Colors.grey[400], thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text('Sort'),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
                const Text('Non-stop'),
                Row(
                  children: const [
                    Text('Filter'),
                    Icon(Icons.filter_list_outlined),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDateSelection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          dateCard('Mar 22 - Mar 23', 540, selectedDateRange == 'Mar 22 - Mar 23'),
          dateCard('Mar 23 - Mar 24', 600, selectedDateRange == 'Mar 23 - Mar 24'),
          dateCard('Mar 24 - Mar 25', 520, selectedDateRange == 'Mar 24 - Mar 25'),
        ],
      ),
    );
  }

  Widget dateCard(String dateRange, int cost, bool isSelected) {
    return GestureDetector(
      onTap: () {
        onDateSelected(dateRange);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.green : Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(dateRange),
            const SizedBox(height: 5),
            Text('AED $cost'),
          ],
        ),
      ),
    );
  }
}