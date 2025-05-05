import 'package:diu_result/cgpaCalculator.dart';
import 'package:diu_result/const.dart';
import 'package:diu_result/models/studentResult.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "DIU Result",
      home: const StudentResult(),
    );
  }
}

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
    if (studentId.isEmpty||_selectedSemester==null||_selectedYear==null)  {
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
      String semesterId = object.makeSemesterId(_selectedSemester!, _selectedYear!);
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
          print(result.length);
    
          if (result.isNotEmpty && result.length>0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultView(result: result),
              ),
            );
          }
          else{
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
                Icon(Icons.error, color: const Color.fromARGB(255, 244, 243, 243)),
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
              prefixIcon: Icon(Icons.person,
                  color: Colors.black), // Icon color
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
                prefixIcon: Icon(Icons.calendar_today,
                    color: Colors.black), // Icon color
                
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
                      "assets/duck.gif",
                      height: 40,
                      width: 30,
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

class ResultView extends StatelessWidget {
  final List<SemesterResult> result;
  const ResultView({super.key, required this.result});

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
        title: Text(
          "Result",
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
