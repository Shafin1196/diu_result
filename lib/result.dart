import 'dart:convert';

import 'package:diu_result/models/studentInfo.dart';
import 'package:diu_result/models/studentResult.dart';
import 'package:diu_result/resultView.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'const.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ResultState();
  }
}

class _ResultState extends State<Result> {
  final _studentIdControl = TextEditingController();
  String? _selectedSemester;
  String? _selectedYear;
  bool _isLoading = false;
  Future<void> getResult() async {
    String studentId = _studentIdControl.text.trim();
    late Student studentInfo;
    if (studentId.isEmpty ||
        _selectedSemester == null ||
        _selectedYear == null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter All the fields"),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      // Call the API to get the result
      SemesterID object = SemesterID();
      String semesterId =
          object.makeSemesterId(_selectedSemester!, _selectedYear!);
      setState(() {
        _isLoading = true;
      });
      try {
        final response = await http.get(
          Uri.parse(
              "https://diurecords.vercel.app/api/result?grecaptcha=&semesterId=$semesterId&studentId=$studentId"),
          headers: {"Content-Type": "application/json"},
        );
        if (response.statusCode == 200) {
          // Parse the response and show the result
          final result = parseResults(response.body);
          if (result.isNotEmpty && result.length > 0) {
            try {
              final response1 = await http.get(
                Uri.parse(
                    "https://diurecords.vercel.app/api/result/studentInfo?studentId=$studentId"),
                headers: {"Content-Type": "application/json"},
              );
              if (response1.statusCode == 200) {
                studentInfo = Student.fromJson(jsonDecode(response1.body));
              } else {
                throw Exception("Failed to load student info");
              }
            } catch (e) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.error,
                          color: const Color.fromARGB(255, 244, 243, 243)),
                      SizedBox(width: 10),
                      Expanded(child: Text("Error: $e")),
                    ],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultView(result: result,studentInfo: studentInfo,),
              ),
            );
          } else {
            throw Exception("No result found for this semester");
          }
        } else {
          throw Exception("Failed to load result");
        }
      } catch (e) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error,
                    color: const Color.fromARGB(255, 244, 243, 243)),
                SizedBox(width: 10),
                Expanded(child: Text("Error: $e")),
              ],
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _studentIdControl,
            decoration: InputDecoration(
              labelText: "Student ID",
              labelStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              hintText: "Enter Your ID",
              hintStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              floatingLabelStyle: TextStyle(
                fontSize: 25, // Label text size when focused
                fontWeight: FontWeight.bold,
                color: Colors.black, // Color of the label when focused
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black87,
                  width: 4,
                ), // Border color when not focused
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 3,
                ),
                // Border color when focused
              ),
              prefixIcon: Icon(Icons.person, color: Colors.black), // Icon color
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 25,
          ),
          DropdownButtonFormField<String>(
            value: _selectedSemester,
            items: semester.map((sem) {
              return DropdownMenuItem(
                value: sem,
                child: Text(sem),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedSemester = value;
              });
            },
            decoration: InputDecoration(
              labelText: "Select Semester",
              labelStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              floatingLabelStyle: TextStyle(
                fontSize: 25, // Label text size when focused
                fontWeight: FontWeight.bold,
                color: Colors.black, // Color of the label when focused
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black87,
                  width: 4,
                ), // Border color when not focused
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 3,
                ),
                // Border color when focused
              ),

              prefixIcon: Icon(Icons.event_note_rounded,
                  color: Colors.black), // Icon color
            ),
            icon: Icon(
              Icons.archive_rounded,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          DropdownButtonFormField<String>(
            value: _selectedYear,
            items: years.map((year) {
              return DropdownMenuItem(
                value: year,
                child: Text(year),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedYear = value;
              });
            },
            decoration: InputDecoration(
              labelText: "Select Year",
              labelStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              floatingLabelStyle: TextStyle(
                fontSize: 25, // Label text size when focused
                fontWeight: FontWeight.bold,
                color: Colors.black, // Color of the label when focused
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black87,
                  width: 4,
                ), // Border color when not focused
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 3,
                ),
                // Border color when focused
              ),
              prefixIcon:
                  Icon(Icons.calendar_today, color: Colors.black), // Icon color
            ),
            icon: Icon(
              Icons.archive_rounded,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: _isLoading
                ? null
                : () {
                    getResult();
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadowColor: Colors.amber,
              elevation: 10,
            ),
            child: _isLoading
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      "assets/2.25.gif",
                      height: 80,
                      width: 70,
                    ))
                : Text(
                    "Get Result",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
          ),
        ],
      ),
    ));
  }
}
