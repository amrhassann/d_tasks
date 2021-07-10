// ignore: import_of_legacy_library_into_null_safe
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manger/cubit/cubit.dart';
import 'package:task_manger/shared/style.dart';
class CustomBottomNaBar extends StatelessWidget {
  CustomBottomNaBar({

    required this.cubit,
  });

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey[700],
      currentIndex: cubit.currentIndex,
      onTap: (index) {
        cubit.changeIndex(index);
      },
      selectedItemColor: Colors.deepOrange,
      selectedLabelStyle: kSelectedLabelBottomNavStyle,
      unselectedLabelStyle: kUnSelectedLabelBottomNavStyle,

      items: [
        BottomNavigationBarItem(
          // icon: Icon(Icons.check_circle_outline),
            label: 'Done',
            icon: BottomNavIcon(
              cubit: cubit,
              icon: Icons.check_circle_outline,
              length: cubit.doneTasks.length,
            )),
        BottomNavigationBarItem(
            label: 'New',
            icon: BottomNavIcon(
              cubit: cubit,
              icon: Icons.menu,
              length: cubit.newTasks.length,
            )),
        BottomNavigationBarItem(
            label: 'Archived',
            icon: BottomNavIcon(
              cubit: cubit,
              icon: Icons.archive_outlined,
              length: cubit.archivedTasks.length,
            )),
      ],
    );
  }
}
class BottomNavIcon extends StatelessWidget {
  const BottomNavIcon({

    required this.cubit,
    required this.length,
    required this.icon,
  }) ;

  final AppCubit cubit;
  final int length;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Badge(
        elevation: 0,
        padding: EdgeInsets.all(3),
        animationType: BadgeAnimationType.slide,
        animationDuration: Duration(seconds: 1),
        badgeColor: Colors.white,
        badgeContent: Text(
          '$length',
          style: TextStyle(color: Colors.deepOrange),
        ),
        position: BadgePosition.topEnd(end: 25),
        child: Icon(icon),
      ),
    );
  }
}