import 'package:flutter/material.dart';
import 'package:flutter_juntos_aprender/components/app_bar.dart';
import 'package:flutter_juntos_aprender/components/app_drawer.dart';
import 'package:flutter_juntos_aprender/screens/create_student_screen.dart';
import 'package:flutter_juntos_aprender/utils/colors.dart';

class ManageStudents extends StatelessWidget {
  const ManageStudents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Gerenciar Alunos'),
      drawer: AppDrawer(),
      body: ListView(
        children: [
          ListTile(
            title: Text('Aluno 1'),
          ),
          ListTile(
            title: Text('Aluno 2'),
          ),
          // Adicione mais ListTiles conforme necessário
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar para a tela de cadastro de alunos
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateStudentScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: MyColors.roxo,
      ),
    );
  }
}
