import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_juntos_aprender/components/app_bar.dart';
import 'package:flutter_juntos_aprender/components/app_drawer.dart';
import 'package:flutter_juntos_aprender/controllers/control_student.dart';
import 'package:flutter_juntos_aprender/models/student.model.dart';
import 'package:flutter_juntos_aprender/screens/create_student_screen.dart';
import 'package:flutter_juntos_aprender/utils/colors.dart';

class ManageStudents extends StatelessWidget {
  const ManageStudents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Gerenciar Alunos'),
      drawer: AppDrawer(),
      body: StreamBuilder(
        stream: ControllStudent().stream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.data?.docs.isEmpty ?? true) {
            return Center(
              child: Text('Você não possui alunos cadastrados.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var studentData =
                  snapshot.data?.docs[index].data() as Map<String, dynamic>;
              var studentModel = StudentModel.fromMap(studentData);

              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(
                    studentModel.nome,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('teste'), // Substitua por informações do aluno
                  onTap: () {
                    // Adicione ação quando o aluno for selecionado
                  },
                ),
              );
            },
          );
        },
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
