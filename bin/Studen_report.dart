import 'dart:io';

List<Map<String,dynamic>>Students = [];
final Set<String>availableSubjects={"Math","English","Science","History"};

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
      case 6:
      case 7:
      case 8:
        exit = false;
    }
  }while(exit);
  }