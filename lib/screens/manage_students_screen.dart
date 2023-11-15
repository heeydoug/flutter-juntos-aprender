import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_juntos_aprender/components/app_bar.dart';
import 'package:flutter_juntos_aprender/components/app_drawer.dart';
import 'package:flutter_juntos_aprender/components/student_list.dart';
import 'package:flutter_juntos_aprender/controllers/control_student.dart';
import 'package:flutter_juntos_aprender/models/student.model.dart';
import 'package:flutter_juntos_aprender/screens/create_student_screen.dart';
import 'package:flutter_juntos_aprender/utils/colors.dart';

class ManageStudents extends StatefulWidget {
  const ManageStudents({Key? key}) : super(key: key);

  @override
  State<ManageStudents> createState() => _ManageStudentsState();
}

class _ManageStudentsState extends State<ManageStudents> {
  late ControllStudent _controlStudent;

  @override
  initState() {
    super.initState();
    _controlStudent = ControllStudent();
  }

  _deleteStudent(int id) {
    _controlStudent.deleteStudent(id);
  }

  _updateStudent(StudentModel studentModel, int id) {
    _controlStudent.update(studentModel, id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Gerenciar Alunos'),
      drawer: AppDrawer(),
      body: _body(),
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

  _body() {
    return _stream_builder();
  }

  Container _stream_builder() {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: _controlStudent.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          _controlStudent.getStudents(snapshot.data!);
          return _scrollView();
        },
      ),
    );
  }

  SingleChildScrollView _scrollView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          StudentList(_controlStudent.students!, _deleteStudent, _updateStudent)
        ],
      ),
    );
  }
}
