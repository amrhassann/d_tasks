import 'package:flutter/material.dart';
import 'package:task_manger/shared/style.dart';
import 'package:task_manger/shared/task_actions.dart';

Widget buildNewTaskItem(Map model, context) => Dismissible(
      onDismissed: (direction) {
        switch (direction) {
          case DismissDirection.startToEnd:
            uiDelete(context , model);
            break;
          case DismissDirection.endToStart:
            uiAddToArchive(context , model);
            break;
          case DismissDirection.vertical:
            // TODO: Handle this case.
            break;
          case DismissDirection.horizontal:
            // TODO: Handle this case.
            break;
          case DismissDirection.up:
            // TODO: Handle this case.
            break;
          case DismissDirection.down:
            // TODO: Handle this case.
            break;
          case DismissDirection.none:
            // TODO: Handle this case.
            break;
        }
      },
      background: BackgroundDeleteArchive(),
  secondaryBackground: SecondaryBackgroundDeleteAndArchive(),
      key: Key(model['id'].toString()),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 15, 15, 15),
        padding: EdgeInsets.only(top: 15, bottom: 15, right: 10, left: 5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model['title'],
                    style: kTitleTaskStyle,
                  ),
                  Text(
                    model['date'],
                    style: kDateTaskStyle,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model['time'],
                  style: kTimeTaskStyle,
                ),
                IconButton(
                  onPressed: () {
                   uiDone(context, model);

                  },
                  icon: Icon(
                    Icons.check_box_outline_blank_outlined,
                    color: Colors.grey,
                    size: 25,
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
Widget buildArchivedTaskItem(Map model, context) {
  return Dismissible(
    direction: DismissDirection.startToEnd,
    onDismissed: (direction) {
      uiDelete(context, model);
    },
    background: Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.fromLTRB(0, 15, 15, 15),
      padding: EdgeInsets.only(top: 15, bottom: 15, right: 10, left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.delete,
            color: Colors.red,
            size: 30,
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.red,
            size: 30,
          ),
        ],
      ),
    ),
    key: Key(model['id'].toString()),
    child: Container(
      margin: EdgeInsets.fromLTRB(0, 15, 15, 15),
      padding: EdgeInsets.only(top: 15, bottom: 15, right: 10, left: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model['title'],
                  style: kTitleTaskStyle,
                ),
                Text(
                  model['date'],
                  style: kDateTaskStyle,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model['time'],
                style: kTimeTaskStyle,
              ),
              IconButton(
                onPressed: () {
                  uiDone(context , model);
                },
                icon: Icon(
                  Icons.check_box_outlined,
                  color: Colors.grey,
                  size: 25,
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    ),
  );
}
Widget buildDoneTaskItem(Map model, context) => Dismissible(
      onDismissed: (direction) {
        switch (direction) {
          case DismissDirection.startToEnd:
           uiDelete(context , model);
            break;
          case DismissDirection.endToStart:
           uiAddToArchive(context, model);
            break;
          case DismissDirection.vertical:
            // TODO: Handle this case.
            break;
          case DismissDirection.horizontal:
            // TODO: Handle this case.
            break;
          case DismissDirection.up:
            // TODO: Handle this case.
            break;
          case DismissDirection.down:
            // TODO: Handle this case.
            break;
          case DismissDirection.none:
            // TODO: Handle this case.
            break;
        }
        // AppCubit.get(context).deleteTask(id: model['id']);
      },
      background: BackgroundDeleteArchive(),
      secondaryBackground: SecondaryBackgroundDeleteAndArchive(),
      key: Key(model['id'].toString()),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 15, 15, 15),
        padding: EdgeInsets.only(top: 15, bottom: 15, right: 10, left: 5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model['title'],
                    style: kTitleTaskStyle,
                  ),
                  Text(
                    model['date'],
                    style: kDateTaskStyle,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model['time'],
                  style: kTimeTaskStyle,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );

// dismissible backgrounds
class BackgroundDeleteArchive extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.fromLTRB(0, 15, 15, 15),
      padding: EdgeInsets.only(top: 15, bottom: 15, right: 10, left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.delete,
            color: Colors.red,
            size: 30,
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.red,
            size: 30,
          ),
        ],
      ),
    );
  }
}
class SecondaryBackgroundDeleteAndArchive extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.fromLTRB(0, 15, 15, 15),
      padding: EdgeInsets.only(top: 15, bottom: 15, right: 10, left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 30,
          ),
          Icon(
            Icons.archive_outlined,
            color: Colors.black,
            size: 30,
          ),

        ],
      ),
    );
  }
}