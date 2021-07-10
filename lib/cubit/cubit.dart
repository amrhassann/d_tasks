import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';
import 'package:task_manger/cubit/states.dart';
import 'package:task_manger/screens/archived_tasks.dart';
import 'package:task_manger/screens/done_tasks.dart';
import 'package:task_manger/screens/newtasks.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

// about changing bottom nav Bar________________________________________________________________________________
  int currentIndex = 1;
  List<Widget> listScreen = [
    DoneTasksScreen(),
    NewTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'Done Tasks',
    'New Tasks',
    'Archived Tasks',
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeButtonNavBarState());
  }

//about database_________________________________________________________________________________________________
  late Database dataBase;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  void createDataBase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      database
          .execute(
              'create table tasks (id integer PRIMARY KEY , title TEXT , date TEXT , time TEXT , status TEXT)')
          .then((value) => () {
                print('table creating succeed');
              })
          .catchError((theError) {
        print(
            'there is error when u creating the table =>>> ${theError.toString()}');
      });
    }, onOpen: (dataBase) {
      getDataFromDb(dataBase);
      print(
          '>>>>>>>>>>>>>>>>>>>>>>>>> data base opened <<<<<<<<<<<<<<<<<<<<<<<<<<<<< ');
    }).then((value) {
      dataBase = value;
      // انت هنا هاتعمل emit  علشان الداتا خلاص جبناها والدنيا يقت تمام
      emit(CreateDateBaseState());
    });
  }

// insert data method
  insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    await dataBase.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks (title , date , time , status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print(" $value Tasks Inserted successfully ^_^.");
        emit(InsertDateBaseState());
        getDataFromDb(dataBase);
      }).catchError((error) {
        print(
            '!!!!!!!!!!!! there is error when u insertToDatabase the table =>>> ${error.toString()}');
      });
      return null;
    });
  }

// get data method
  getDataFromDb(dataBase) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(GetDateBaseState());
    dataBase.rawQuery('SELECT * FROM tasks').then((value) {
      print('getting data done successfully');

      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else {
          archivedTasks.add(element);
        }
      });
      emit(GetDateBaseState());
    });
  }

// update data method
  void updateDate({required String status, required int id}) {
    dataBase.rawUpdate('UPDATE tasks SET status = ? WHERE id = ? ',
        ['$status', id]).then((value) {
      getDataFromDb(dataBase);
      emit(UpdateDateBaseState());
    });
  }

// delete data method
  void deleteTask({required int id}) {
    dataBase.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDb(dataBase);
      print(newTasks);
      emit(DeleteDateBaseState());
    });

  }

// about floating action button ____________________________________________________________________________________
  bool isBottomSheetHere = false;
  IconData updatedIcon = Icons.edit;
  void changeFloatingActionButton(
      {required bool isShow, required IconData icon}) {
    updatedIcon = icon;
    isBottomSheetHere = isShow;
    emit(ChangeFloatingActionState());
  }

}
