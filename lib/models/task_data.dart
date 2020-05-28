import 'package:flutter/foundation.dart';
import 'package:todo/models/task.dart';
//import 'package:todo/widgets/tasks_list.dart';
import 'dart:collection';
//import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference taskref =Firestore.instance.collection('tasks');
bool check =false;
class Taskdata extends ChangeNotifier {
 List<Task> _tasks=[

  ];
 
int get taskcount{
  return _tasks.length;
}

void addtask(String newtasktitle) async{
  try{
    print(' iam in add task');
final task=Task(name: newtasktitle);
  _tasks.add(task);
  notifyListeners();
     }catch(e){
     }   // we cant update the values without this function as it auto rebuild again the widgets who are listening
                   // to this property according to it's updated value.
}
showdata(QuerySnapshot brews){
 
  for(var doc in brews.documents){
    Taskdata().addtask(doc.data['title']);
  
  }
   
}

 UnmodifiableListView<Task> get tasks {
  //  if(check==false){
  //Provider.of<QuerySnapshot>(context);
  //  showdata(TaskList().returndata());
  //  check=true;
  //  }
   
  return UnmodifiableListView(_tasks);
}

Stream<QuerySnapshot> get brews{
return taskref.snapshots();
}


void updateTask(Task task){
  task.toggleDone();
  notifyListeners();
}

void deletetask(Task task){
  _tasks.remove(task);
  notifyListeners();
}

}

