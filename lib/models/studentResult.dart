import 'dart:convert';

class SemesterResult {
  final String semesterId;
  final String semesterName;
  final int semesterYear;
  final String studentId;
  final String courseId;
  final String customCourseId;
  final String courseTitle;
  final double totalCredit;
  final double? grandTotal;
  final double pointEquivalent;
  final String gradeLetter;
  final double cgpa;
  final String blocked;
  final String? blockCause;
  final String tevalSubmitted;
  final String teval;
  final String? semesterAccountsClearance;

  SemesterResult({
    required this.semesterId,
    required this.semesterName,
    required this.semesterYear,
    required this.studentId,
    required this.courseId,
    required this.customCourseId,
    required this.courseTitle,
    required this.totalCredit,
    this.grandTotal,
    required this.pointEquivalent,
    required this.gradeLetter,
    required this.cgpa,
    required this.blocked,
    this.blockCause,
    required this.tevalSubmitted,
    required this.teval,
    this.semesterAccountsClearance,
  });

  factory SemesterResult.fromJson(Map<String, dynamic> json) {
    return SemesterResult(
      semesterId: json['semesterId'] as String,
      semesterName: json['semesterName'] as String,
      semesterYear: json['semesterYear'] as int,
      studentId: json['studentId'] as String,
      courseId: json['courseId'] as String,
      customCourseId: json['customCourseId'] as String,
      courseTitle: json['courseTitle'] as String,
      totalCredit: (json['totalCredit'] as num).toDouble(),
      grandTotal: json['grandTotal'] != null ? (json['grandTotal'] as num).toDouble() : null,
      pointEquivalent: (json['pointEquivalent'] as num).toDouble(),
      gradeLetter: json['gradeLetter'] as String,
      cgpa: (json['cgpa'] as num).toDouble(),
      blocked: json['blocked'] as String,
      blockCause: json['blockCause'] as String?,
      tevalSubmitted: json['tevalSubmitted'] as String,
      teval: json['teval'] as String,
      semesterAccountsClearance: json['semesterAccountsClearance'] as String?,
    );
  }
}
List<SemesterResult> parseResults(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<SemesterResult>((json) => SemesterResult.fromJson(json)).toList();
}