import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manger/cubit/cubit.dart';
import 'package:task_manger/cubit/states.dart';
import 'package:task_manger/shared/custom_widgets.dart';
import 'package:task_manger/shared/style.dart';
class DoneTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
        listener: (context , AppStates state){},
        builder:(context , AppStates state){
          var tasks = AppCubit.get(context).doneTasks;
          return tasks.length <= 0? Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.speaker_notes , size: 100, color: Colors.grey[400],),
                Text('No tasks completed !' , style: kNoTasksYetStyle,)
              ],
            ),
          ):ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (BuildContext context ,index){
                return Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 20
                  ),
                  child: buildDoneTaskItem(tasks[index], context),
                ) ;
              }
          );
        }

    );
  }
}
