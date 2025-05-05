
import 'package:diu_result/models/studentInfo.dart';
import 'package:diu_result/models/studentResult.dart';
import 'package:flutter/material.dart';

class ResultView extends StatelessWidget {
  final List<SemesterResult> result;
  const ResultView({super.key, required this.result,required this.studentInfo});
  final Student studentInfo;

  @override
  Widget build(BuildContext context) {
    String image;
    if (result[0].cgpa >= 3.5) {
      image = "assets/3.5.gif";
    } else if (result[0].cgpa >= 3.25) {
      image = "assets/3.25.gif";
    } else if (result[0].cgpa >= 3.0) {
      image = "assets/3.0.gif";
    } else if (result[0].cgpa >= 2.5) {
      image = "assets/2.50.gif";
    } else {
      image = "assets/2.25.gif";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(studentInfo.studentName,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 10,
                shadowColor: Colors.black,
                child: ListTile(
                  title: Text(
                    "Semester Name: ${result[0].semesterName}",
                  ),
                  subtitle: Text("Semester Year: ${result[0].semesterYear}"),
                  trailing: Text("SGPA: ${result[0].cgpa}"),
                  leading: Icon(
                    Icons.school,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                image,
                height: 200,
                width: 200,
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: result.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white70,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                      shadowColor: Colors.yellow,
                      child: ListTile(
                        title: Text("Course: ${result[index].courseTitle}"),
                        subtitle: Text(
                            "GPA: ${result[index].gradeLetter} (${result[index].pointEquivalent})"),
                        trailing: Text("Credit: ${result[index].totalCredit} "),
                        leading: Icon(
                          Icons.book,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
