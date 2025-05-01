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
      home: const Result(),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 44, 5, 140),
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
  bool _isLoading = false;
  Future<void> getResult()async {
    String studentId = _studentIdControl.text.trim();
    if(studentId.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter your student ID"),
          backgroundColor: Colors.red,
        ),
      );
    }else{
      // Call the API to get the result
      setState(() {
        _isLoading = true;
      });
      try{
        final response = await http.get(
          Uri.parse(
              "http://software.diu.edu.bd:8189/result?grecaptcha=&semesterId=251&studentId=$studentId"),
          headers: {"Content-Type": "application/json"},
        );
        if(response.statusCode == 200){
          // Parse the response and show the result
          final result = parseResults(response.body);
          if(result.isNotEmpty){
            print(result[0].semesterName);
            print(result[0].courseTitle);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultView(result: result),
              ),
            );
          }
        }
        else{
          throw Exception("Failed to load result");

        }
        

      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $e"),
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        title: Text("DIU Result",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        elevation: 10,
        shadowColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _studentIdControl,
                decoration: InputDecoration(
                  labelText: "Student ID",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.numbers),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: _isLoading? null:(){
                getResult();
              }, 
              
              child: _isLoading ?
                Padding
                (
                  padding: const EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(color: Colors.black,)):
                Text("Get Result",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
              
            ],
          
          ),
        )
      ),
    );
  }
}

class ResultView extends StatelessWidget {
  final List<SemesterResult> result;
  const ResultView({super.key, required this.result});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DIU Result",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        elevation: 10,
        shadowColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 10,
                shadowColor: Theme.of(context).colorScheme.primaryContainer,
                child: ListTile(
                  title: Text("Semester Name: ${result[0].semesterName}",),
                  subtitle: Text("Semester Year: ${result[0].semesterYear}"),
                  trailing: Text("CGPA: ${result[0].cgpa}"),
                  leading: Icon(Icons.school,),
                  ),
                  
                ),
              SizedBox(height: 20,),
              Expanded(
                child: ListView.builder(
                  itemCount: result.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.black12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                      shadowColor: Theme.of(context).colorScheme.primaryContainer,
                      child: ListTile(
                        title: Text("Course Title: ${result[index].courseTitle}"),
                        subtitle: Text("Grade Letter: ${result[index].gradeLetter} (${result[index].pointEquivalent})"),
                        
                        trailing: Text("Credit: ${result[index].totalCredit} "),
                        
                        leading: Icon(Icons.book,),
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