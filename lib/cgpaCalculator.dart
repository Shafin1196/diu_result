

import 'package:flutter/material.dart';

class Cgpacalculator extends StatefulWidget {
  const Cgpacalculator({super.key});

  

  @override
  State<Cgpacalculator> createState() => _CgpacalculatorState();
}


class _CgpacalculatorState extends State<Cgpacalculator> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      labelText: 'Course Title',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'Enter Course Title',
                      hintStyle: TextStyle(color: Colors.grey,
                      fontSize: 10,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      labelText: 'Credit',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'Enter Course Credit',
                      hintStyle: TextStyle(color: Colors.grey,
                      fontSize: 10,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      labelText: 'Grade point',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'Enter Course Grade point',
                      hintStyle: TextStyle(color: Colors.grey,
                      fontSize: 10,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            
          ],
          ),
        ),

    );
  }
  
}