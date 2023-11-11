import 'package:flutter/material.dart';
import 'package:flutter_juntos_aprender/components/app_drawer.dart';
import 'package:flutter_juntos_aprender/screens/create_classroom_screen.dart';

class ManageClassroom extends StatelessWidget {
  const ManageClassroom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Salas'),
      ),
      drawer: AppDrawer(),
      body: ListView(
        children: [
          ListTile(
            title: Text('Sala 1'),
          ),
          ListTile(
            title: Text('Sala 2'),
          ),
          // Adicione mais ListTiles conforme necessário
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar para a tela de cadastro de alunos
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateClassroomScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
