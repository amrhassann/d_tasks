import 'package:flutter/material.dart';
import 'package:task_manger/cubit/bloc_opserver.dart';
import 'package:task_manger/screens/homeScreen.dart';
import 'package:bloc/bloc.dart';
// ignore: invalid_language_version_override
// @dart=2.9
main(){
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
