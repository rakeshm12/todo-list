import 'package:flutter/material.dart';
import 'package:todo/data_base/todo_db.dart';
import 'package:todo/views/todo_list.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[700],
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text(
                  "Add Todo",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: titleController,
                autofocus: true,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Title"),
              ),
              const SizedBox(
                height: 3,
              ),
              TextField(
                controller: contentController,
                maxLines: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Type here.."),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if(titleController.text.isEmpty || contentController.text.isEmpty){
                        return;
                      }
                      TodoDB()
                          .addTodo(titleController.text, contentController.text)
                          .then(
                            (value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const TodoList()),
                                    (route) => false));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.black,
                                            content: Text("Todo added",style: TextStyle(color: Colors.white, fontSize: 15),)));
                    });
                  },
                  child: const Text("Add Todo"))
            ],
          ),
        ),
      ),
    );
  }
}
