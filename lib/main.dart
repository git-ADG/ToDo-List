import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list/screens/home.dart';

void main(){
  runApp(const MyyApp());
}

class MyyApp extends StatelessWidget {
  const MyyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo-List',
      home: Home(),
    );
  }
}
