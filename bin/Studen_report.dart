import 'dart:io';
void main(){
  print("===== Student Grader v1.0 =====");
  List<Map<String,dynamic>>Students=[];
  bool exit=true;

  do{
    print("1. Add Student");
    print("2. Record Score");
    print("3. Add Bonus Points");
    print("4. Add Comment");
    print("5. View All Students");
    print("6. View Report Card");
    print("7. Class Summary");
    print("8. Exit");
    stdout.write("\nChoose an option:");
    int decision=int.parse(stdin.readLineSync()!);

    if(decision==8){
      exit=false;
    }else{
      operations(decision)
    }

  }while();

}