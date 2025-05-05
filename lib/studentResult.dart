
import 'package:diu_result/cgpaCalculator.dart';
import 'package:diu_result/result.dart';
import 'package:flutter/material.dart';

class StudentResult extends StatelessWidget {
  const StudentResult({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'DIU Result',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.black, // Underline color
            labelColor: Colors.black, // Selected tab text color
            unselectedLabelColor: Colors.grey, // Unselected tab text color
            labelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            indicatorWeight: 5, // Underline thickness
            tabs: [
              Tab(
                text: "Result",
              ),
              Tab(
                text: "CGPA Calculator",
              ),
            ],
          ),
          backgroundColor: Colors.white, // Background color of the AppBar
          elevation: 0, // Removes shadow
        ),
        body: TabBarView(
          children: [
            Result(), // Content for Login tab
            Cgpacalculator(), // Content for Semester Result tab
          ],
        ),
      ),
    );
  }
}