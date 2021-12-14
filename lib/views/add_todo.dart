import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
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
            children: [
               const Text(
                "Add Todo List",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Title"),
              ),
              const SizedBox(
                height: 3,
              ),
              TextFormField(
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                    hintText: "Type here.."),
              ),
              ElevatedButton(onPressed: (){}, child: Text());

            ],
          ),
        ),
      ),
    );
  }
}
