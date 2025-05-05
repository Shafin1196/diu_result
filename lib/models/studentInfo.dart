
class Student {
  final String studentId;
  final String fkCampus;
  final String campusName;
  final String studentName;
  final String batchId;
  final int batchNo;
  final int programCredit;
  final String programId;
  final String programName;
  final String progShortName;
  final String programType;
  final String deptShortName;
  final String departmentName;
  final String facultyName;
  final String facShortName;
  final String semesterId;
  final String semesterName;
  final String shift;

  Student({
    required this.studentId,
    required this.fkCampus,
    required this.campusName,
    required this.studentName,
    required this.batchId,
    required this.batchNo,
    required this.programCredit,
    required this.programId,
    required this.programName,
    required this.progShortName,
    required this.programType,
    required this.deptShortName,
    required this.departmentName,
    required this.facultyName,
    required this.facShortName,
    required this.semesterId,
    required this.semesterName,
    required this.shift,
  });

  // Factory method to create a Student object from JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json['studentId'],
      fkCampus: json['fkCampus'],
      campusName: json['campusName'],
      studentName: json['studentName'],
      batchId: json['batchId'],
      batchNo: json['batchNo'],
      programCredit: json['programCredit'],
      programId: json['programId'],
      programName: json['programName'],
      progShortName: json['progShortName'],
      programType: json['programType'],
      deptShortName: json['deptShortName'],
      departmentName: json['departmentName'],
      facultyName: json['facultyName'],
      facShortName: json['facShortName'],
      semesterId: json['semesterId'],
      semesterName: json['semesterName'],
      shift: json['shift'],
    );
  }

  // Method to convert a Student object to JSON
  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'fkCampus': fkCampus,
      'campusName': campusName,
      'studentName': studentName,
      'batchId': batchId,
      'batchNo': batchNo,
      'programCredit': programCredit,
      'programId': programId,
      'programName': programName,
      'progShortName': progShortName,
      'programType': programType,
      'deptShortName': deptShortName,
      'departmentName': departmentName,
      'facultyName': facultyName,
      'facShortName': facShortName,
      'semesterId': semesterId,
      'semesterName': semesterName,
      'shift': shift,
    };
  }
}