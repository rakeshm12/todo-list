import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/views/todo_list.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class TodoDB {
  CollectionReference todo = firestore.collection('todos');

  Future<void> addTodo(String title, String content) async {
    Map<String, dynamic> notes = {
      'title': title,
      'content': content,
    };

    todo.doc().set(notes);

    todo.doc().collection('todos').orderBy("timestamp").get();
    FirebaseFirestore.instance.settings =
        const Settings(persistenceEnabled: true);
  }

  void deleteTodo(BuildContext context, String id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("Delete Todo?", style: TextStyle(color: Colors.redAccent),),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close)),
              TextButton(
                  onPressed: () {
                    todo.doc(id).delete();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const TodoList()),
                        (route) => false);
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ],
          );
        });
  }

  updateTodo(String title, String content, BuildContext context, String id) {
    Map<String, dynamic> notes = {
      'title': title,
      'content': content,
    };

    todo.doc(id).update(notes);
  }
}
