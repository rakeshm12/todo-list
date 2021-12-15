import 'package:flutter/material.dart';
import 'package:todo/data_base/todo_db.dart';
import 'package:todo/views/todo_list.dart';

Future updateWidget(BuildContext context, id) async {
  return showDialog(
      context: context,
      builder: (context) {
        TextEditingController _title = TextEditingController();
        TextEditingController _content = TextEditingController();
        return SingleChildScrollView(
          child: AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              backgroundColor: Colors.white,
              actionsPadding: const EdgeInsets.all(16),
              actions: [
                IconButton(
                    splashRadius: 5,
                    alignment: Alignment.topRight,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _title,
                      autofocus: true,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Title"),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    TextField(
                      controller: _content,
                      maxLines: 2,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Type here.."),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_title.text.isEmpty || _content.text.isEmpty)
                            return;
                          TodoDB().updateTodo(
                              _title.text, _content.text, context, id);
                          Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const TodoList()),
                                  (route) => false);
                          ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      backgroundColor: Colors.black,
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                        "Updated successfully",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      )));
                        },
                        child: const Text("Update"))
                  ],
                )
              ]),
        );
      });
}
