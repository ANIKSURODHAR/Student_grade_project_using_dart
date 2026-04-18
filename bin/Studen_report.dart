import 'dart:io';

List<Map<String, dynamic>>Students = [];
final Set<String>availableSubjects={"Math","English","Science","History"};



void Add(){
 stdout.write("Enter Student name");
 String name=stdin.readLineSync()??'Unknown';
 var newStudent=<String,dynamic>{
   'name': name,
   'scores':<int>[],
   'subject':{...availableSubjects},
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
      case 8:
        exit = false;
    }
  }while(exit);
  }