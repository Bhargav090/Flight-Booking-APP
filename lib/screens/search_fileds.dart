// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jmrinfotech/screens/search_results.dart';

class SearchFieldsScreen extends StatefulWidget {
  final String selectedButton;
  const SearchFieldsScreen({super.key, required this.selectedButton});

  @override
  State<SearchFieldsScreen> createState() => _SearchFieldsScreenState();
}

class _SearchFieldsScreenState extends State<SearchFieldsScreen> {
  TextEditingController departureController = TextEditingController();
  TextEditingController travelersController = TextEditingController();
  TextEditingController fromController = TextEditingController();  
  TextEditingController toController = TextEditingController();  
  String selectedCabinClass = 'Economy'; 
  int travelers = 0;
  bool isFromFocused = false;
  bool isToFocused = false;
  late String triptype;

  @override
  void initState() {
    super.initState();
    triptype = widget.selectedButton;
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('EEE d MMM yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.008),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.airplanemode_active, color: Colors.green),
              SizedBox(width: width * 0.02),
              Expanded(
                child: Focus(
                  onFocusChange: (hasFocus) {
                    setState(() {
                      isFromFocused = hasFocus;
                    });
                  },
                  child: TextField(
                    controller: fromController, 
                    decoration: const InputDecoration(
                      hintText: 'From',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isFromFocused)
            Container(
              height: 2,
              margin: EdgeInsets.only(bottom: height * 0.02),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.white],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),

          Row(
            children: [
              Icon(Icons.location_on, color: Colors.green),
              SizedBox(width: width * 0.02),
              Expanded(
                child: Focus(
                  onFocusChange: (hasFocus) {
                    setState(() {
                      isToFocused = hasFocus;
                    });
                  },
                  child: TextField(
                    controller: toController,
                    decoration: InputDecoration(
                      hintText: 'To',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isToFocused)
            Container(
              height: 2,
              margin: EdgeInsets.only(top: height * 0.01),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.white],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          SizedBox(height: height * 0.03),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: departureController,
                  readOnly: true,
                  onTap: () => _selectDate(context, departureController),
                  decoration: InputDecoration(
                    labelText: 'Departure',
                    suffixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(width: width * 0.05),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Return',
                    suffixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  enabled: false,
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.02),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: travelersController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Travelers',
                    suffixText: 'Passengers',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      travelers = int.tryParse(value) ?? 0;
                    });
                  },
                ),
              ),
              SizedBox(width: width * 0.05),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedCabinClass,
                  items: ['Economy', 'Business', 'First Class']
                      .map((classType) => DropdownMenuItem(
                            value: classType,
                            child: Text(classType),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCabinClass = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Cabin Class',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.04),

          SizedBox(
            width: width * 0.4,
            height: height * 0.065,
            child: ElevatedButton(
              onPressed: () {
                if (travelers <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid number of travelers.')),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchResultsScreen(
                      fromLocation: fromController.text,  
                      toLocation: toController.text,   
                      departureDate: departureController.text,
                      travelers: travelers,
                      cabinClass: selectedCabinClass, tripType: triptype,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF63AF23), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Search Flights',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
