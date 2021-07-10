import 'package:flutter/material.dart';
import 'package:task_manger/cubit/cubit.dart';

uiDelete(context, model) {
  AppCubit.get(context).deleteTask(id: model['id']);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      'Task deleted',
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 1),
    backgroundColor: Colors.red,
  ));
}

uiAddToArchive(context, model) {
  AppCubit.get(context).updateDate(status: 'archived', id: model['id']);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      'Added to archived list',
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 1),
    backgroundColor: Colors.grey,
  ));
}

uiDone(context, model) {
  AppCubit.get(context).updateDate(status: 'done', id: model['id']);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      'Task Done',
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 1),
    backgroundColor: Colors.green,
  ));
}
