import 'package:flutter/material.dart';
import 'package:todo/views/todo_list.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
  Future.delayed(const Duration(seconds: 2)).then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const TodoList())));
    super.initState();
  }

  @override
  void dispose() {
    Future.delayed(const Duration(seconds: 3));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Hero(
              tag: 'logo',
              child: CircleAvatar(
                child: Icon(Icons.notes, color: Colors.lightBlue, size: 70),
                radius: 35,
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Todos",
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
