import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manger/cubit/cubit.dart';
import 'package:task_manger/shared/add_new_task.dart';
import 'package:task_manger/shared/bottom-navigation.dart';
import 'package:task_manger/shared/style.dart';
import 'package:task_manger/cubit/states.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => AppCubit()..createDataBase(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is InsertDateBaseState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Task Added  ^_^',
                  textAlign: TextAlign.center,
                ),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.green,
              ));
            }
          },
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              key: scaffoldKey,
              backgroundColor: Colors.grey[200],
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.grey[200],
                title: Text(cubit.titles[cubit.currentIndex],
                    style: kAppBarTitleStyle),
                centerTitle: true,
              ),
              body: cubit.listScreen[cubit.currentIndex],
              floatingActionButton: FloatingButtonToAddNewTask(cubit: cubit, formKey: formKey, titleController: titleController, dateController: dateController, timeController: timeController, scaffoldKey: scaffoldKey),
              bottomNavigationBar: CustomBottomNaBar(cubit: cubit),
            );
          },
        ),
      ),
    );
  }
}






