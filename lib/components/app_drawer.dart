import 'package:flutter/material.dart';
import 'package:flutter_juntos_aprender/components/app_bar.dart';
import 'package:flutter_juntos_aprender/screens/home_screen.dart';
import 'package:flutter_juntos_aprender/screens/manage_classroom_screen.dart';
import 'package:flutter_juntos_aprender/screens/manage_students_screen.dart';
import 'package:flutter_juntos_aprender/services/auth_service.dart';
import 'package:flutter_juntos_aprender/utils/colors.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          CustomAppBar(title: "Menu"),
          Divider(),
          ListTile(
            leading: Icon(Icons.home, color: MyColors.roxo),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.supervised_user_circle, color: MyColors.roxo),
            title: Text('Gerenciar Alunos'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ManageStudents()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.class_, color: MyColors.roxo),
            title: Text('Gerenciar Salas'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ManageClassroom()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: MyColors.roxo),
            title: Text('Logout'),
            onTap: () {
              AuthService().logout();
            },
          ),
        ],
      ),
    );
  }
}
