import 'package:diu_result/const.dart';
import 'package:flutter/material.dart';

class Cgpacalculator extends StatefulWidget {
  const Cgpacalculator({super.key});

  @override
  State<Cgpacalculator> createState() => _CgpacalculatorState();
}

class _CgpacalculatorState extends State<Cgpacalculator> {
  NewRow init = NewRow();
  List<Widget> courseData = [];
  List<NewRow> courseList = [];
  @override
  void initState() {
    super.initState();
    courseData.add(init.getRow());
    courseList.add(init);
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: courseData,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          courseData.add(SizedBox(
                            height: 20,
                          ));
                          NewRow course = NewRow();
                          courseList.add(course);
                          courseData.add(course.getRow());
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shadowColor: Colors.black,
                        elevation: 10,
                      ),
                      icon: Icon(
                        Icons.add,
                        color: Colors.green,
                      ),
                      label: Text("Add Course",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          if(courseData.length>1)
                          {
                          courseData.removeLast();
                          courseData.removeLast();
                          courseList.removeLast();
                          }
                          else{
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Alert!"),
                                content: Text("You must have at least one course."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          }
                        });
                      },
                      icon: Icon(Icons.delete,color: Colors.white,),
                      label: Text("Remove Course",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade300,
                        shadowColor: Colors.black,
                        elevation: 10,
                        
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: (){
                  double totalCredit = 0;
                  double totalGradePoint = 0;
                  for(int i=0;i<courseList.length;i++)
                  {
                    double currentCredit = courseList[i].creditControler.text.isEmpty?0:double.parse(courseList[i].creditControler.text);
                    double currentGradePoint = courseList[i].gradeControler.text.isEmpty?0:double.parse(courseList[i].gradeControler.text);
                    totalCredit += currentCredit;
                    totalGradePoint += currentCredit*currentGradePoint;
                  }
                  double cgpa = totalGradePoint/totalCredit;
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Your SGPA"),
                      content: Text("Your SGPA is ${cgpa.toStringAsFixed(2)}"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
          
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shadowColor: Colors.black,
                elevation: 10,
              ),
              child: Text("Calculate CGPA",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
