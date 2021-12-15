import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/data_base/todo_db.dart';
import 'package:todo/views/add_list.dart';
import 'package:todo/widgets/update_widget.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance.collection('todos');
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                      child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: const AddTodo())));
            },
            child: const Icon(
              Icons.add_task,
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: const [
                          Hero(
                            tag: 'logo',
                            child: CircleAvatar(
                              child: Icon(Icons.notes,
                                  color: Colors.lightBlue, size: 30),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Todos",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: FutureBuilder<QuerySnapshot>(
                        future: firestore.get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text("Something went wrong"),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            final List<DocumentSnapshot> todoData =
                                snapshot.data!.docs;
                            return ListView(
                              shrinkWrap: true,
                              children: todoData.map((data) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      updateWidget(context, data.id);
                                    });

                                  },
                                  onLongPress: () {
                                    setState(() {
                                      TodoDB().deleteTodo(context, data.id);
                                    });


                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                        elevation: 6,
                                        shadowColor: Colors.grey,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.0),
                                          ),
                                        ),
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data['title'],
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                data['content'],
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              )
                                            ],
                                          ),
                                        )),
                                  ),
                                );
                              }).toList(),
                            );
                          }
                          return Container();
                        })),
              )
            ],
          )),
    );
  }
}
