import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_juntos_aprender/components/app_bar.dart';
import 'package:flutter_juntos_aprender/components/app_drawer.dart';
import 'package:flutter_juntos_aprender/components/classroom_list.dart';
import 'package:flutter_juntos_aprender/controllers/control_classroom.dart';
import 'package:flutter_juntos_aprender/models/classroom_model.dart';
import 'package:flutter_juntos_aprender/screens/create_classroom_screen.dart';
import 'package:flutter_juntos_aprender/utils/colors.dart';

class ManageClassroom extends StatefulWidget {
  const ManageClassroom({Key? key}) : super(key: key);

  @override
  State<ManageClassroom> createState() => _ManageClassroomState();
}

class _ManageClassroomState extends State<ManageClassroom> {
  late ControlClassRoom _controlClassRoom;

  @override
  initState() {
    super.initState();
    _controlClassRoom = ControlClassRoom();
  }

  _deleteClassroom(int id) {
    _controlClassRoom.deleteClassroom(id);
  }

  _updateStudent(ClassroomModel classroomModel, int id) {
    _controlClassRoom.update(classroomModel, id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Gerenciar Salas"),
      drawer: AppDrawer(),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.roxo,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateClassroomScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _body() {
    return _stream_builder();
  }

  Container _stream_builder() {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: _controlClassRoom.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          _controlClassRoom.getClassrooms(snapshot.data!);
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
          ClassroomList(
              _controlClassRoom.classrooms!, _deleteClassroom, _updateStudent)
        ],
      ),
    );
  }
}
