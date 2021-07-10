import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manger/cubit/cubit.dart';

class FloatingButtonToAddNewTask extends StatelessWidget {
  const FloatingButtonToAddNewTask({

    required this.cubit,
    required this.formKey,
    required this.titleController,
    required this.dateController,
    required this.timeController,
    required this.scaffoldKey,
  }) ;

  final AppCubit cubit;
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController dateController;
  final TextEditingController timeController;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      elevation: 3,
      child: Icon(
        cubit.updatedIcon,
        color: Colors.deepOrange,
      ),
      onPressed: () {
        if (cubit.isBottomSheetHere) {
          if (formKey.currentState!.validate()) {
            cubit.insertToDatabase(
                title: titleController.text,
                date: dateController.text,
                time: timeController.text);
          }
        } else {
          scaffoldKey.currentState!
              .showBottomSheet(
                (context) => Container(
              width: double.infinity,
              color: Colors.grey[100],
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.deepOrange)),
                          hintText: 'Task Title',
                          prefixIcon: Icon(
                            Icons.title,
                            color: Colors.deepOrange,
                          ),
                        ),
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'task title must not be empty!';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.deepOrange)),
                            hintText: 'Task Time',
                            prefixIcon: Icon(
                              Icons.watch_later_outlined,
                              color: Colors.deepOrange,
                            ),
                            focusColor: Colors.deepOrange,
                            hoverColor: Colors.deepOrange),
                        controller: timeController,
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'time must not be empty!';
                          }
                          return null;
                        },
                        onTap: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            print(
                                ' time of task is ${value!.format(context)}');
                            timeController.text =
                                value.format(context);
                          });
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.deepOrange)),
                          hintText: 'Task date',
                          prefixIcon: Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.deepOrange,
                          ),
                        ),
                        controller: dateController,
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'date must not be empty!';
                          }
                          return null;
                        },
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                            DateTime.parse('2021-05-20'),
                          ).then((value) {
                            dateController.text =
                                DateFormat.yMMMd().format(value!);
                          });
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
              .closed
              .then((value) {
            cubit.changeFloatingActionButton(
              icon: Icons.edit,
              isShow: false,
            );
          });

          cubit.changeFloatingActionButton(
            icon: Icons.add,
            isShow: true,
          );
        }
      },
    );
  }
}