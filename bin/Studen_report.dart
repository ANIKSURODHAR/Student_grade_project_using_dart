import 'dart:io';

List<Map<String,dynamic>>Students = [];
final Set<String>availableSubjects={"Math","English","Science","History"};
void Class_Summary() {
  if (Students.isEmpty) {
    print("No students yet! Add a student first (Option 1).\n");
    return;
  }

  var allAverages = <double>[];
  var topName     = '';
  var topAvg      = -1.0;

  for (var s in Students) {
    var scores = s['scores'] as List<int>;
    var bonus  = s['bonus']  as int?;
    var name   = s['name']   as String;

    if (scores.isEmpty) continue;

    var avg = _average(scores) + (bonus ?? 0);
    allAverages.add(avg);

    if (avg > topAvg) {
      topAvg  = avg;
      topName = name;
    }
  }

  if (allAverages.isEmpty) {
    print("No scores recorded yet.\n");
    return;
  }

  var classAvg = allAverages.reduce((a, b) => a + b) / allAverages.length;

  int cA = 0, cB = 0, cC = 0, cD = 0, cF = 0;
  for (var avg in allAverages) {
    if      (avg >= 90) cA++;
    else if (avg >= 80) cB++;
    else if (avg >= 70) cC++;
    else if (avg >= 60) cD++;
    else                cF++;
  }

  print('''
===== Class Summary =====
  Total students  : ${Students.length}
  Students graded : ${allAverages.length}
  Class average   : ${classAvg.toStringAsFixed(2)}
  Class grade     : ${letterGrade(classAvg)}  ${gradeDesc(classAvg)}
  Top student     : $topName (${topAvg.toStringAsFixed(1)})

  Grade Distribution:
    A (90–100) : $cA student(s)
    B (80–89)  : $cB student(s)
    C (70–79)  : $cC student(s)
    D (60–69)  : $cD student(s)
    F (0–59)   : $cF student(s)
''');
}

//  HELPERS

double _average(List<int> scores) {
  if (scores.isEmpty) return 0.0;
  var sum = 0;
  for (var s in scores) sum += s;
  return sum / scores.length;
}

String letterGrade(double avg) {
  if      (avg >= 90) return 'A';
  else if (avg >= 80) return 'B';
  else if (avg >= 70) return 'C';
  else if (avg >= 60) return 'D';
  else                return 'F';
}

String gradeDesc(double avg) {
  if      (avg >= 90) return '(Excellent)';
  else if (avg >= 80) return '(Good)';
  else if (avg >= 70) return '(Satisfactory)';
  else if (avg >= 60) return '(Needs Improvement)';
  else                return '(Failing)';
}

String _bar(int score) {
  var filled = (score / 10).round().clamp(0, 10);
  return '[' + ('█' * filled) + ('░' * (10 - filled)) + ']';
}

void View_Report() {
  if (Students.isEmpty) {
    print("No students yet! Add a student first (Option 1).\n");
    return;
  }

  for (int i = 0; i < Students.length; i++) {
    print("${i + 1}. ${Students[i]['name']}");
  }

  stdout.write("Choose a student: ");
  var chose = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

  if (chose < 1 || chose > Students.length) {
    print("Invalid student number.\n");
    return;
  }

  var s       = Students[chose - 1];
  var name    = s['name']    as String;
  var scores  = s['scores']  as List<int>;
  var bonus   = s['bonus']   as int?;
  var comment = s['comment'] as String?;

  print('''
╔══════════════════════════════════╗
║           REPORT CARD            ║
╠══════════════════════════════════╣
║  Student : ${name.padRight(23)}║
╚══════════════════════════════════╝''');

  if (scores.isEmpty) {
    print("  No scores recorded yet.\n");
    return;
  }

  print("\n  Scores:");
  for (var score in scores) {
    print("    • $score  ${_bar(score)}");
  }

  var rawAvg   = _average(scores);
  var bonusPts = bonus ?? 0;
  var finalAvg = rawAvg + bonusPts;

  print("\n  Raw Average  : ${rawAvg.toStringAsFixed(2)}");
  if (bonus != null) {
    print("  Bonus Points : +$bonus");
    print("  Final Average: ${finalAvg.toStringAsFixed(2)}");
  }
  print("  Letter Grade : ${letterGrade(finalAvg)}  ${gradeDesc(finalAvg)}");

  // Nullable comment — only shown if not null
  if (comment != null) {
    print("\n  Teacher's Note: \"$comment\"");
  }
  print('');
}


void View_All() {
  if (Students.isEmpty) {
    print("No students yet! Add a student first (Option 1).\n");
    return;
  }

  print("\n===== All Students =====");
  for (int i = 0; i < Students.length; i++) {
    var s       = Students[i];
    var name    = s['name']    as String;
    var scores  = s['scores']  as List<int>;
    var bonus   = s['bonus']   as int?;

    var avg      = scores.isEmpty ? 0.0 : _average(scores);
    var finalAvg = avg + (bonus ?? 0);
    var grade    = scores.isEmpty ? '—' : letterGrade(finalAvg);

    print(
      "${i + 1}. ${name.padRight(15)} "
          "Scores: ${scores.length}  "
          "Avg: ${avg.toStringAsFixed(1)}  "
          "Grade: $grade"
          "${bonus != null ? '  (+$bonus bonus)' : ''}",
    );
  }
  print('');
}
void Add_Comment() {

  for (int i = 0; i < Students.length; i++) {
    print("${i + 1}. ${Students[i]['name']}");
  }

  stdout.write("Choose a student: ");
  var chose = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

  if (chose < 1 || chose > Students.length) {
    print("Invalid student number.\n");
    return;
  }

  // Show existing nullable comment
  String? existing = Students[chose - 1]['comment'] as String?;
  if (existing != null) {
    print("Current comment: \"$existing\"");
  }

  stdout.write("Enter comment: ");
  var comment = stdin.readLineSync() ?? '';

  if (comment.trim().isEmpty) {
    print("Comment cannot be empty.\n");
    return;
  }

  Students[chose - 1]['comment'] = comment;
  print("Comment saved for ${Students[chose - 1]['name']}!\n");
}

void Add_Bonus_Points(){

  for(int i=0;i<Students.length;i++)  print("${i+1}. ${Students[i]['name']}");
  stdout.write("Choose a students");
  var std=int.parse(stdin.readLineSync()!);
  int bonus=-1;
  while(bonus<1 || bonus>10) {
    stdout.write("Give bonus between 1 to 10");
    bonus = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
    if(bonus<1 || bonus>10) print("Wrong marks submmited");

  }
  // ??= assigns ONLY if bonus is currently null
  Students[std-1]['bonus'] ??= bonus;

  // if-else: check whether ??= actually assigned or skipped
  if(Students[std-1]['bonus'] == bonus)  print("Number successfully set");
  else  print("already set");

}
void Record_Score(){

  for(int i=0;i<Students.length;i++){
    print("${i+1}. ${Students[i]['name']}");
  }
  stdout.write("choose a  student");
  var chose=int.parse(stdin.readLineSync()!);
  if(chose<1 && chose>Students.length) print("you enter wrong student");
  else{
    int score=-1;
    while(score<0 || score>100) {
      print("Available Subject ${Students[chose-1]['subjects'].join(', ')}");
      stdout.write("Enter number between 1-100");
      score=int.parse(stdin.readLineSync() ?? "")??-1;
      if(score<0 || score>100){
        stdout.write("Invalid input. Score must be exactly between 0 and 100:");
      }
    }

    Students[chose-1]['scores'].add(score);
    print("The $score is added for in  ${Students[chose-1]['name'] }");

  }
}
void Add(){
 stdout.write("Enter Student name");
 String name=stdin.readLineSync()??'Unknown';
 var newStudent=<String,dynamic>{
   'name': name,
   'scores':<int>[],
   'subjects':{...availableSubjects},
   'bonus':null,
   'comment':null
 };
 Students.add(newStudent);

 print("\nSuccessfully $name added in the Student lists");

}

void main() {
  print("===== Student Grader v1.0 =====");
  bool exit = true;


  do {
    print("1. Add Student");
    print("2. Record Score");
    print("3. Add Bonus Points");
    print("4. Add Comment");
    print("5. View All Students");
    print("6. View Report Card");
    print("7. Class Summary");
    print("8. Exit");
    stdout.write("\nChoose an option:");
    int decision = int.parse(stdin.readLineSync()!);

    switch (decision) {
      case 1:
        Add();
        break;
      case 2:
        Record_Score();
        break;
      case 3:
        Add_Bonus_Points();
        break;
      case 4:
        Add_Comment();
        break;
      case 5:
        View_All();
        break;
      case 6:
        View_Report();
        break;
      case 7:
      case 7:
        Class_Summary();
        break;
      case 8:
        exit = false;
      default:
        print("\nInvalid option. Please enter 1–8.\n");
    }
  }while(exit);
  }