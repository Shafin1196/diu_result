
import 'package:flutter/material.dart';

final semester=[
  "spring",
  "summer",
  "fall",
];
final years = List.generate(
  DateTime.now().year - 2022 + 1, // Calculate the number of years
  (index) => (2022 + index).toString(), // Generate years starting from 2022
);

class NewRow {
    final courseControler=TextEditingController();  
    final creditControler=TextEditingController();
    final gradeControler=TextEditingController();
  Row getRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              controller: courseControler,
              decoration: InputDecoration(
                labelText: 'Course Title',
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'Enter Course Title',
                hintStyle: TextStyle(color: Colors.grey,
                fontSize: 10,
                ),
                floatingLabelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 3.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 3.0),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: TextField(
              controller: creditControler,
              decoration: InputDecoration(
                labelText: 'Credit',
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'Enter Course Credit',
                hintStyle: TextStyle(color: Colors.grey,
                fontSize: 10,
                ),
                floatingLabelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 3.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 3.0),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: TextField(
              controller: gradeControler,
              decoration: InputDecoration(
                labelText: 'Grade point',
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'Enter Course Grade point',
                hintStyle: TextStyle(color: Colors.grey,
                fontSize: 10,
                ),
                floatingLabelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 3.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 3.0),
                ),
              ),
            ),
          ),
        ],
      );
  }
}
  

// Row init=Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     flex: 3,
//                     child: TextField(
                      
//                       decoration: InputDecoration(
//                         labelText: 'Course Title',
//                         labelStyle: TextStyle(color: Colors.black),
//                         hintText: 'Enter Course Title',
//                         hintStyle: TextStyle(color: Colors.grey,
//                         fontSize: 10,
//                         ),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     flex: 2,
//                     child: TextField(
//                       controller: TextEditingController(),
//                       decoration: InputDecoration(
//                         labelText: 'Credit',
//                         labelStyle: TextStyle(color: Colors.black),
//                         hintText: 'Enter Course Credit',
//                         hintStyle: TextStyle(color: Colors.grey,
//                         fontSize: 10,
//                         ),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     flex: 2,
//                     child: TextField(
//                       controller: TextEditingController(),
//                       decoration: InputDecoration(
//                         labelText: 'Grade point',
//                         labelStyle: TextStyle(color: Colors.black),
//                         hintText: 'Enter Course Grade point',
//                         hintStyle: TextStyle(color: Colors.grey,
//                         fontSize: 10,
//                         ),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                 ],
//               );

